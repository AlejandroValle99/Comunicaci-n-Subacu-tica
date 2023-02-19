sbit pin_on at LATB0_BIT;
sbit led1 at LATB7_BIT;
sbit led2 at LATB6_BIT;
unsigned char tempo;
double voltage=0;
char cuenta_on=0;//
////////////////////////////////////////////////////////////////////////////////
//////////////////////////variables para uart///////////////////////////////////
char trama_rx[100];
char trama_tx[200];

char trama_cont=0;
char dato_rx;

char texto[30];
////////////////////////////////////////////////////////////////////////////////
//////////////////////////variables para ubidot/////////////////////////////////
char flag_ubi=0;
unsigned char largo;
char largo_str[10];
unsigned char led_ubidot;
char captu[30];// para procesar lo capturado por ubidots
float ph;
float temperatura;
unsigned  int  suiche_ubi,pwm_ubi;
////////////////////////////////////////////////////////////////////////////////
/////////////////////Variables para Sensor de Oxygeno///////////////////////////
int CAL_V=1400;
int CAL_T=0;
int tempoxygen=0;
long int ADC_VoltageOxygen=0;
long int V_saturation;
float OxygenoDO=0;
float oxigeno;
const int DO_Table[41] = {
    14460, 14220, 13820, 13440, 13090, 12740, 12420, 12110, 11810, 11530,
    11260, 11010, 10770, 10530, 10300, 10080, 9860, 9660, 9460, 9270,
    9080, 8900, 8730, 8570, 8410, 8250, 8110, 7960, 7820, 7690,
    7560, 7430, 7300, 7180, 7070, 6950, 6840, 6730, 6630, 6530, 6410};
////////////////////////////////////////////////////////////////////////////////
void Uart1_write_text_const(const char *info)
{
 while(*info) UART1_Write(*info++);
}
////////////////////////////////////////////////////////////////////////////////
char tiempo(unsigned int milis, char cap[15], char cap1[15])
{
unsigned int cont1;

// estado_rec=normal;
 trama_cont=0;
  memset(trama_rx,0,100);// LIMPIA LA TRAMA
  RCIF_bit=0;
  //BORRA ERROES DE RECEPCION
  CREN_bit=0;
  CREN_bit=1;
   RCIE_bit=1;
 Delay_ms(10);
    for (cont1=1;cont1<=milis;cont1++)
     {
    delay_Ms(1);

          if (strstr(trama_rx,cap)!=0 )
          {
           RCIE_bit=0; // deshabilita la interrpcion
           Delay_ms(10);
           return(1);
          }
          else  if (strstr(trama_rx,cap1)!=0 )
          {
         RCIE_bit=0; // deshabilita la interrpcion
          Delay_ms(10);
          return(2);
          }
    }

  RCIE_bit=0; // deshabilita la interrpcion
  return(0);
}
////////////////////////////////////////////////////////////////////////////////
char manda_AT_COMANDO(char *coman, char cap[15], char cap1[15],unsigned int retardo)
{
  Uart1_write_text(coman);//manda el comando
  Uart1_write_text_const("\r\n"); // manda final de linea
  return (tiempo(retardo,cap,cap1));
  }
////////////////////////////////////////////////////////////////////////////////
////////////////////////INTENTAR ENCENDER EL MODULO/////////////////////////////
unsigned char prendio()
{
Delay_ms(2000);
/////////MANDAR COMANDO AT PARA VERIFICAR QUE EL MODULO ESTE ENCENDIDO//////////

if ( manda_AT_COMANDO("AT","OK","ERROR",2000)==1) return(1);
//ENCIENDE Y APAGA LED QUE INDICA QUE NO SE HA CONECTADO//
else{
pin_on=0;
Delay_ms(1000);
pin_on=1;
Delay_ms(2000);
pin_on=0;
Delay_ms(2000);
//VUELVE A MANDAR COMANDO AT PARA VERIFICAR SI SE ENCENDIO//
if ( manda_AT_COMANDO("AT","OK","ERROR",2000)==1) return(1);
else return(0);//SINO MANDA ERROR
}
}
////////////////////////////////////////////////////////////////////////////////
//////////////////////INTERRUPCION PARA TRANSMISION/////////////////////////////
void interrupcion() iv 0x0008 ics ICS_AUTO
 {
    // si es interrpcion serial
   if (RCIF_bit==1)
   {
   dato_rx=RCREG; // lee el dato
   trama_rx[trama_cont]=dato_rx;
   trama_cont++;
   if (trama_cont>=100) trama_cont=0;
   RCIF_bit=0;
  }

  }
////////////////////////////////////////////////////////////////////////////////
/////////////////////////GARANTIZAR LA CONEXION GPRS////////////////////////////
void config_gprs()
{
hoy ://///////GO TO PARA REGRESAR EN CASO NO SE CONECTE/////////////////////////

//////////////////RESETEA CUALQUIER CONEXION GPRS///////////////////////////////
manda_AT_COMANDO("AT+CIPSHUT","OK", "ERROR", 2000);

///////////////////////PREPARA SIMPLE CONEXION//////////////////////////////////
tempo=manda_AT_COMANDO("AT+CIPMUX=0", "OK", "ERROR", 4000);
if (tempo!=1)  goto hoy;

///////////////////////////ANALIZA EL ESTADO////////////////////////////////////
tempo=manda_AT_COMANDO("AT+CIPSTATUS", "IP INITIAL", "ERROR", 500);
if (tempo!=1)  goto hoy;

///TRATA DE CONECTAR A RED, DEBE COLOCAR EL APN CLAVE Y USIRIO ACORDE AL PROVEEDOR DEL SERVICIO
tempo=manda_AT_COMANDO("AT+CSTT=\"internet.ideasclaro\",\"\",\"\"", "OK",  "ERROR", 30000);
if (tempo!=1)  goto hoy;

//////////////MANDA ORDENES DE CONFIGURACION DE CALIDAD DE LA RED///////////////
manda_AT_COMANDO("AT+CGQMIN= 1,0,0,0,0,0", "OK", "OK", 500);
manda_AT_COMANDO("AT+CGQREQ= 1,0,0,3,0,0", "OK", "OK", 500);

////////////////COMPOARTAMIENTO AL RECIBIR UN MENSAJE DE TEXTO//////////////////
manda_AT_COMANDO("AT+CMGF=1", "OK", "OK", 500);

//////////////////////QUE REPORTE EL MENSAJE POR EL UART////////////////////////
manda_AT_COMANDO("AT+CNMI=1,1,2,1,0", "OK", "OK", 500);

//////////////////////////////COSULTA EL ESTADO/////////////////////////////////
while(manda_AT_COMANDO("AT+CIPSTATUS", "START", "ERROR", 3000)  == 0 );
Delay_ms(2000);// RETARDO PARA QUE ADEMAS DEL STATUS LLEGUE EL OK

//////////////////////////CREA LAS CONEXIONES GPRS//////////////////////////////
tempo=manda_AT_COMANDO("AT+CIICR", "OK",  "ERROR", 30000);
Delay_ms(10000);
if (tempo!=1)  goto hoy;
       
/////////////////////ESPERA EL ESTADO DE CONEXION A GPRS////////////////////////
while (tempo=manda_AT_COMANDO("AT+CIPSTATUS", "GPRSACT", "ERROR", 6000)==0);
Delay_ms(2000);

///////////////////////////OBTIENE UNA IP LOCAL/////////////////////////////////
tempo=manda_AT_COMANDO("AT+CIFSR", ".", "ERROR", 10000);
if (tempo!=1)  goto hoy;
Delay_ms(3000);
 }
////////////////////////////////////////////////////////////////////////////////
//////////////////////////////CONEXION A UBIDOTS////////////////////////////////
 unsigned char conecta()
{
 tempo=manda_AT_COMANDO("AT+CIPSTART="  "\"TCP\""   ","   "\"things.ubidots.com\""  ","  "\"80\"", "CONNECT OK", "ALREADY CONNECT", 10000);
 Delay_ms(2000);
 if ((tempo==1) ||(tempo==2)) return(1);
 else return(0);
}
////////////////////////////////////////////////////////////////////////////////
////////SI HABILITA EL GPRS CORRECTAMENTE ENVIA LA INFORMACION A UBIDOTS////////
unsigned char conectar()
{
if (conecta()==1)
{
tempo=manda_AT_COMANDO("AT+CIPSEND", ">", "OK",5000);
Delay_ms(500);
memset(trama_tx,0,100);//LIMPIA LA TRAMA//

sprintf(trama_tx,"{\"oxigeno\": %5.2f,\"temperatura\": %5.2f,\"ph\": %5.2f}",oxigeno,temperatura,ph);
largo=strlen(trama_tx);

sprintf(largo_str,"%u\n\n",largo);
Uart1_write_text_const("POST /api/v1.6/devices/proyectofase/?token=BBFF-mw5hBP6jnqrG1IdShi0wYieFf9WyFj HTTP/1.1\nHost: things.ubidots.com\nContent-Type: application/json\nContent-Length: ");
UART1_Write_Text(largo_str);
Uart1_write_text(trama_tx);

Delay_ms(4000);
tempo=manda_AT_COMANDO("\x1A", "SEND OK", "ERROR",4000);//MENSAJE PARA VERIFICAR SI SE ENVIO//
Delay_ms(5000);

tempo=manda_AT_COMANDO("AT+CIPCLOSE", "CLOSE OK", "ERROR",4000);//CERRAR COMANDO
Delay_ms(1000);

//VERIFICAR SI SE MANDO LA INFORMACION//
sprintf(texto,"sw=%1d  pwm=%3d\r\n",suiche_ubi,pwm_ubi);
UART1_Write_Text(texto);
Delay_ms(1000);
if (tempo!=1) return(2);
return(1);
}//SI SE CONECTO//
else return(0);
}//SI NO SE CONECTO//
////////////////////////////////////////////////////////////////////////////////
/////////////////FUNCION PARA LEER EL SENSOR DE TEMPERATURA/////////////////////
float ds18b20_read(char *puerto,char pin);

float ds18b20_read(char *puerto,char pin)
{
unsigned int temp_;
float tempo__;
unsigned char t1_,t2_,td__;
float signo=1.0;
float sensor_temp_;
    Ow_Reset(puerto, pin);                         // Onewire reset signal
    Delay_ms(18);
    Ow_Write(puerto, pin, 0xCC);                   // dirrecciona todos sensores
    Delay_ms(1);
    Ow_Write(puerto, pin, 0x44);                   //iniica conversion
    Delay_ms(150);
    Ow_Reset(puerto, pin);
    Delay_ms(18);
    Ow_Write(puerto, pin, 0xCC);
   Delay_ms(1);
    Ow_Write(puerto, pin, 0xBE);
     Delay_ms(1);
     t1_ =  Ow_Read(puerto, pin);        //lee parte baja
     t2_ =  Ow_Read(puerto, pin);       //lee parte alta

    temp_=( (unsigned int)t2_<<8) || t1_;
     //si es negado
    if ( t2_ & 0x80)
    {
    temp_=~temp_+1;
    signo=-1.0;
     }
      temp_=temp_>>4; //quita la parte decimal

     td__=t1_ & 0x0f;    //saca parte decima
    //suma las decimas deseadas
      tempo__=0;
       if (td__.b3==1)tempo__=tempo__+0.5;
       if (td__.b2==1) tempo__=tempo__+0.25;
       if (td__.b1==1) tempo__=tempo__+0.125;
       if (td__.b0==1) tempo__=tempo__+0.0625;
          if (signo<0) tempo__=-tempo__;
     sensor_temp_=(temp_*signo)+tempo__;  //calcula vlor final

    return (sensor_temp_);

}
////////////////////////////////////////////////////////////////////////////////
void main()
 {
ADCON1=0B1101;//////////TODO DIGITAL EXCEPTO EL EL PUERTO AN0 Y AN1/////////////
TRISA.B2=1;
TRISB=0;
TRISC=0;
TRISC7_bit=1;///////////////////////////RX//////////////////////////////////////

UART1_Init(9600);/////////////VELOCIDAD DEL SIM800L/////////////////////////////
pin_on=0;

INTCON=0b01000000;
Soft_UART_Init(&PORTB, 2, 1, 9600, 0);//INICIALIZA UN PUERTO POR SOFTWARE//

//INTERRUPCION SERIAL//
   RCIF_bit=0;
   RCIE_bit=0;

    LATB=0;
/////////////////////////////////////TIMER//////////////////////////////////////
     //configura timer cero para 1 segundo

    T0CON=0;//LIMPIA REGISTRO DEL TIMER CERO
    TMR0ON_bit=0; // lo mantiene apagado
    TMR0H=72;
    TMR0L=228;
    // PREESCAALDOR DE 256
    T0PS2_bit=1;
    T0PS1_bit=1;
    T0PS0_bit=1;

    TMR0IF_bit=0;
    TMR0IE_bit=0;// deshabilita la interrpcion
////////////////////////////////////////////////////////////////////////////////

   GIE_bit=1;// HABILITA INTERPCIONES GLOBALES
   RCEN_bit=0;
   RCEN_bit=1;
    while ((prendio()==0) || (cuenta_on>=10)) cuenta_on++;  // intenta prender el modulo usando 10 intentos
    config_gprs();
    led_ubidot=1;
    temperatura=ds18b20_read(&porta,2);
    voltage = (5 / 1024.0 * ADC_Read(1))-0.4;
      ph = -5.70 *voltage + 21.34;

////////////////////////////////////////////////////////////////////////////////
   while (1)
   {
      temperatura=ds18b20_read(&porta,2);
      tempoxygen= temperatura;
      OxygenoDO=ADC_Read(0);
      ADC_VoltageOxygen = 5000*OxygenoDO/1024;
      CAL_T=tempoxygen;
      V_saturation = ((CAL_V + (35 * tempoxygen)) - (CAL_T * 35));
      oxigeno=((ADC_VoltageOxygen * (DO_Table[tempoxygen]))/V_saturation)/1000;
      /////////////////////////////////////////
      voltage = (5 / 1024.0 * ADC_Read(1))-0.4;
      ph = -5.70 *voltage + 21.34;
      /////////////////////////////////////////
      conectar();
      Delay_ms(5000);

   }


 }
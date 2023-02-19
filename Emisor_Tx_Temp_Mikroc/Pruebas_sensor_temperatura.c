
// LCD module connections
sbit LCD_RS at LATB0_bit;
sbit LCD_EN at LATB1_bit;
sbit LCD_D4 at LATB2_bit;
sbit LCD_D5 at LATB3_bit;
sbit LCD_D6 at LATB4_bit;
sbit LCD_D7 at LATB5_bit;

sbit LCD_RS_Direction at TRISB0_bit;
sbit LCD_EN_Direction at TRISB1_bit;
sbit LCD_D4_Direction at TRISB2_bit;
sbit LCD_D5_Direction at TRISB3_bit;
sbit LCD_D6_Direction at TRISB4_bit;
sbit LCD_D7_Direction at TRISB5_bit;
// End LCD module connections

float temperatura;
char texto[50];
char num[50];


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

    temp_=( (unsigned int)t2_<<8) | t1_;

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

void USART_Init ()
{
 TRISC.b6=0;
 SPBRG= 207;

 TXSTA.b2=0;                 //BRGH
 TXSTA.B4=0;                 //Sincrono o asincrono     SYNC
 TXSTA.B1=0;                 // Transmit shift register
 RCSTA.B7=1;                 // Habilitacion TX y RX        SPEN
 BAUDCON.b4=0;                 //Inversión de señal
 BAUDCON.b3=0;                //BRG16

 TXSTA.B6=0;                 // 8 bits o 9, TX9
 TXSTA.B5=1;                 // Habilita transmision, TXEN


 RCSTA.B6=0;
 RCSTA.B4=1;
}
void USART_Tx(int info)
{
  TXREG=info;

}

char USART_Rx()
{
 return RCREG;
}
int tempola;
int contador;
void main() {
  OSCCON = 0b01110110;
  ADCON1=0b00001111;                   // Puertos A digitales
  Lcd_Init();
  Lcd_Cmd(_LCD_CURSOR_OFF);
  Lcd_Cmd(_LCD_CLEAR);
  lcd_out(1, 1, "Temp enviada:");
  USART_Init();
  contador=0;

  while(1) {
      temperatura=ds18b20_read(&PORTA,2);
      delay_ms(500);
      tempola=temperatura ;
      inttostr(tempola,texto);
      lcd_out(2,1,texto);
      USART_tx(tempola);
      delay_ms(20);
           }
}
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

int Temp_rx  ;
char texto[50];
char num[50];
int contador;

void USART_Init ()
{
 TRISC.b7=1;
 TRISC.b6=0;
 SPBRG= 207;

 TXSTA.b2=0;                 //BRGH
 TXSTA.B4=0;                 //Sincrono o asincrono     SYNC
 TXSTA.B1=0;                 // Transmit shift register
 RCSTA.B7=1;                 // Habilitacion TX y RX        SPEN
 BAUDCON.b4=0;
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

int USART_Rx()
{
   return RCREG;
}


void main() 
{
  OSCCON = 0b01110110;
  Lcd_Init();                      // Initialize LCD module
  Lcd_Cmd(_LCD_CURSOR_OFF);        // cursor off
  Lcd_Cmd(_LCD_CLEAR);             // clear LCD
  lcd_out(1, 1, "Temp recibida:");
  USART_Init();
  contador++;

         while(1)
         {
             Temp_Rx=USART_Rx() ;
             delay_ms(10);
             inttostr(Temp_Rx,texto);
             lcd_out(2,1,texto);
             delay_ms(10);
         }

}
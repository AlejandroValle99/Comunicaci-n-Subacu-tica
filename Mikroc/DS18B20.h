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
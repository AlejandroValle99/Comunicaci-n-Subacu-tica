#include "ds1307_SH.h"

const d_segundo=0;
const d_minuto=1;
const d_hora=2;
const d_dia=3;
const d_fecha=4;
const d_mes=5;
const d_anho=6;
const d_control=7;
const dir_ds1307=0b11010000;


void carga_inicial(char _seg,char _min,char _hor,char _dia,char _fecha,char _mes, char _anho)
{
 ds1307._segundo=_seg;
 ds1307._minuto=_min;
 ds1307._hora=_hor;
 ds1307._fecha=_fecha;
 ds1307._dia=_dia;
 ds1307._mes=_mes;
 ds1307._anho=_anho;
}


void guarda_control_s()
{
char tempi;


  Soft_I2C_Start();
  Soft_I2C_Write(dir_ds1307  & 0b11111110);
  Soft_I2C_Write(d_control);
  Soft_I2C_Write(0b00010000);
  Soft_I2C_Stop();

}



char lee_segundo_s()
{
char leido;

 Soft_I2C_Start();
 Soft_I2C_Write(dir_ds1307  & 0b11111110);
 Soft_I2C_Write(d_segundo);

 Soft_I2C_Start();

 Soft_I2C_Write(dir_ds1307  | 0b00000001);

 leido= (Bcd2Dec(Soft_I2C_Read(0))) & 0b01111111;

 Soft_I2C_Stop();

return (leido);

}

char lee_minuto_s()
{
char leido;
 Soft_I2C_Start();
 Soft_I2C_Write(dir_ds1307  & 0b11111110);
 Soft_I2C_Write(d_minuto);
 Soft_I2C_Start();
 Soft_I2C_Write(dir_ds1307  | 0b00000001);
 leido= Bcd2Dec(Soft_I2C_Read(0)) & 0b01111111;
 Soft_I2C_Stop();
return (leido);

}

char lee_dia_s()
{
char leido;

 Soft_I2C_Start();
 Soft_I2C_Write(dir_ds1307  & 0b11111110);
 Soft_I2C_Write(d_dia);

 Soft_I2C_Start();

 Soft_I2C_Write(dir_ds1307  | 0b00000001);

 leido= (Bcd2Dec(Soft_I2C_Read(0))) & 0b000001111;

 Soft_I2C_Stop();

return (leido);

}

char lee_hora_s()
{
char leido;

 Soft_I2C_Start();
 Soft_I2C_Write(dir_ds1307  & 0b11111110);
 Soft_I2C_Write(d_hora);

 Soft_I2C_Start();

 Soft_I2C_Write(dir_ds1307  | 0b00000001);

 leido= (Bcd2Dec(Soft_I2C_Read(0))) & 0b001111111;

 Soft_I2C_Stop();

return (leido);

}
char lee_fecha_s()
{
char leido;

 Soft_I2C_Start();
 Soft_I2C_Write(dir_ds1307  & 0b11111110);
 Soft_I2C_Write(d_fecha);
 Soft_I2C_Start();

 Soft_I2C_Write(dir_ds1307  | 0b00000001);

 leido= (Bcd2Dec(Soft_I2C_Read(0))) & 0b00111111;
 Soft_I2C_Stop();

return (leido);

}
char lee_mes_s()
{
char leido;

 Soft_I2C_Start();
 Soft_I2C_Write(dir_ds1307  & 0b11111110);
 Soft_I2C_Write(d_mes);
 Soft_I2C_Start();
 Soft_I2C_Write(dir_ds1307  | 0b00000001);
 leido= (Bcd2Dec(Soft_I2C_Read(0))) & 0b000111111;

 Soft_I2C_Stop();

return (leido);

}
char lee_anho_s()
{
char leido;

 Soft_I2C_Start();
 Soft_I2C_Write(dir_ds1307  & 0b11111110);
 Soft_I2C_Write(d_anho);
 Soft_I2C_Start();
 Soft_I2C_Write(dir_ds1307  | 0b00000001);
 leido= (Bcd2Dec(Soft_I2C_Read(0))) & 0b111111111;

 Soft_I2C_Stop();

return (leido);

}

void guarda_segundo_s()
{
char tempi;

tempi=Dec2Bcd(ds1307._segundo);
tempi.b7=0;

  Soft_I2C_Start();
  Soft_I2C_Write(dir_ds1307  & 0b11111110);
  Soft_I2C_Write(d_segundo);
  Soft_I2C_Write(tempi);
  Soft_I2C_Stop();

}

void guarda_minuto_s()
{
char tempi;

tempi=Dec2Bcd(ds1307._minuto);
tempi.b7=0;

  Soft_I2C_Start();
  Soft_I2C_Write(dir_ds1307  & 0b11111110);
  Soft_I2C_Write(d_minuto);
  Soft_I2C_Write(tempi);
  Soft_I2C_Stop();

}

void guarda_hora_S()
{
char tempi;

tempi=Dec2Bcd(ds1307._hora);
tempi.b7=0;
tempi.b6=0;  //para 24 horas

  Soft_I2C_Start();
  Soft_I2C_Write(dir_ds1307  & 0b11111110);
  Soft_I2C_Write(d_hora);
  Soft_I2C_Write(tempi);
  Soft_I2C_Stop();

}
void guarda_dia_s()
{
char tempi;

tempi=Dec2Bcd(ds1307._dia);
tempi.b7=0;
tempi.b6=0;
tempi.b5=0;
tempi.b4=0;
tempi.b3=0;


  Soft_I2C_Start();
  Soft_I2C_Write(dir_ds1307  & 0b11111110);
  Soft_I2C_Write(d_dia);
  Soft_I2C_Write(tempi);
  Soft_I2C_Stop();

}
void guarda_fecha_s()
{
char tempi;

tempi=Dec2Bcd(ds1307._fecha);
tempi.b7=0;
tempi.b6=0;

  Soft_I2C_Start();
  Soft_I2C_Write(dir_ds1307  & 0b11111110);
  Soft_I2C_Write(d_fecha);
  Soft_I2C_Write(tempi);
  Soft_I2C_Stop();

}
void guarda_mes_s()
{
char tempi;

tempi=Dec2Bcd(ds1307._mes);
tempi.b7=0;

  Soft_I2C_Start();
  Soft_I2C_Write(dir_ds1307  & 0b11111110);
  Soft_I2C_Write(d_mes);
  Soft_I2C_Write(tempi);
  Soft_I2C_Stop();

}
void guarda_anho_s()
{
char tempi;

tempi=Dec2Bcd(ds1307._anho);



  Soft_I2C_Start();
  Soft_I2C_Write(dir_ds1307  & 0b11111110);
  Soft_I2C_Write(d_anho);
  Soft_I2C_Write(tempi);
  Soft_I2C_Stop();

}

void guardatodo_s()
{
guarda_control_s();
guarda_segundo_s();
guarda_minuto_s();
guarda_hora_s();
guarda_dia_s();
guarda_mes_s();
guarda_fecha_s();
guarda_anho_s();
 }

void leertodo_s()
{
ds1307._segundo=lee_segundo_s();
ds1307._minuto=lee_minuto_s();
ds1307._dia=lee_dia_s();
ds1307._fecha=lee_fecha_s();
ds1307._hora=lee_hora_s();
ds1307._mes=lee_mes_s();
ds1307._anho=lee_anho_s();

}

void reloj_init()
{
I2C1_Init(100000);
}


void reloj_init_s()
{
Soft_I2C_Init();
}






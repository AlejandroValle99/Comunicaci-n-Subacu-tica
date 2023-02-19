//Software I2C connections

extern sfr sbit Soft_I2C_Scl;
extern sfr sbit Soft_I2C_Sda ;
extern sfr sbit Soft_I2C_Scl_Direction ;
extern sfr  sbit Soft_I2C_Sda_Direction ;

typedef struct ds1307_estruct {
  char   _segundo,_minuto,_hora;
  char   _dia,_fecha,_mes,_anho;   //fecha es el dia de mes   dia esel dia d ela semana
  char _control;
}reloj;

extern reloj  ds1307;   //crea una  estructura con el formato del reloj  llamada ds1307

//I2C SOFTWARE
void reloj_init_s();
void guarda_segundo_s();
void guarda_minuto_s();
void guarda_hora_s();
void guarda_dia_s();
void guarda_fecha_s();
void guarda_mes_s();
void guarda_anho_s();
void guarda_control_s();
void guardatodo_s();
char lee_segundo_s();
char lee_minuto_s();
char lee_dia_s();
char lee_hora_s();
char lee_fecha_S();
char lee_mes_S();
char lee_anho_s();
void leertodo_s();
void carga_inicial(char _seg,char _min,char _hor,char _dia,char _fecha,char _mes, char _anho);
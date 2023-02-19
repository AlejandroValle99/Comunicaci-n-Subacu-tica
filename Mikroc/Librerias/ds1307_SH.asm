
_carga_inicial:

;ds1307_SH.c,14 :: 		void carga_inicial(char _seg,char _min,char _hor,char _dia,char _fecha,char _mes, char _anho)
;ds1307_SH.c,16 :: 		ds1307._segundo=_seg;
	MOVF        FARG_carga_inicial__seg+0, 0 
	MOVWF       _ds1307+0 
;ds1307_SH.c,17 :: 		ds1307._minuto=_min;
	MOVF        FARG_carga_inicial__min+0, 0 
	MOVWF       _ds1307+1 
;ds1307_SH.c,18 :: 		ds1307._hora=_hor;
	MOVF        FARG_carga_inicial__hor+0, 0 
	MOVWF       _ds1307+2 
;ds1307_SH.c,19 :: 		ds1307._fecha=_fecha;
	MOVF        FARG_carga_inicial__fecha+0, 0 
	MOVWF       _ds1307+4 
;ds1307_SH.c,20 :: 		ds1307._dia=_dia;
	MOVF        FARG_carga_inicial__dia+0, 0 
	MOVWF       _ds1307+3 
;ds1307_SH.c,21 :: 		ds1307._mes=_mes;
	MOVF        FARG_carga_inicial__mes+0, 0 
	MOVWF       _ds1307+5 
;ds1307_SH.c,22 :: 		ds1307._anho=_anho;
	MOVF        FARG_carga_inicial__anho+0, 0 
	MOVWF       _ds1307+6 
;ds1307_SH.c,23 :: 		}
L_end_carga_inicial:
	RETURN      0
; end of _carga_inicial

_guarda_control_s:

;ds1307_SH.c,26 :: 		void guarda_control_s()
;ds1307_SH.c,31 :: 		Soft_I2C_Start();
	CALL        _Soft_I2C_Start+0, 0
;ds1307_SH.c,32 :: 		Soft_I2C_Write(dir_ds1307  & 0b11111110);
	MOVLW       208
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,33 :: 		Soft_I2C_Write(d_control);
	MOVLW       7
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,34 :: 		Soft_I2C_Write(0b00010000);
	MOVLW       16
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,35 :: 		Soft_I2C_Stop();
	CALL        _Soft_I2C_Stop+0, 0
;ds1307_SH.c,37 :: 		}
L_end_guarda_control_s:
	RETURN      0
; end of _guarda_control_s

_lee_segundo_s:

;ds1307_SH.c,41 :: 		char lee_segundo_s()
;ds1307_SH.c,45 :: 		Soft_I2C_Start();
	CALL        _Soft_I2C_Start+0, 0
;ds1307_SH.c,46 :: 		Soft_I2C_Write(dir_ds1307  & 0b11111110);
	MOVLW       208
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,47 :: 		Soft_I2C_Write(d_segundo);
	CLRF        FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,49 :: 		Soft_I2C_Start();
	CALL        _Soft_I2C_Start+0, 0
;ds1307_SH.c,51 :: 		Soft_I2C_Write(dir_ds1307  | 0b00000001);
	MOVLW       209
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,53 :: 		leido= (Bcd2Dec(Soft_I2C_Read(0))) & 0b01111111;
	CLRF        FARG_Soft_I2C_Read_ack+0 
	CLRF        FARG_Soft_I2C_Read_ack+1 
	CALL        _Soft_I2C_Read+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Bcd2Dec_bcdnum+0 
	CALL        _Bcd2Dec+0, 0
	MOVLW       127
	ANDWF       R0, 0 
	MOVWF       lee_segundo_s_leido_L0+0 
;ds1307_SH.c,55 :: 		Soft_I2C_Stop();
	CALL        _Soft_I2C_Stop+0, 0
;ds1307_SH.c,57 :: 		return (leido);
	MOVF        lee_segundo_s_leido_L0+0, 0 
	MOVWF       R0 
;ds1307_SH.c,59 :: 		}
L_end_lee_segundo_s:
	RETURN      0
; end of _lee_segundo_s

_lee_minuto_s:

;ds1307_SH.c,61 :: 		char lee_minuto_s()
;ds1307_SH.c,64 :: 		Soft_I2C_Start();
	CALL        _Soft_I2C_Start+0, 0
;ds1307_SH.c,65 :: 		Soft_I2C_Write(dir_ds1307  & 0b11111110);
	MOVLW       208
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,66 :: 		Soft_I2C_Write(d_minuto);
	MOVLW       1
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,67 :: 		Soft_I2C_Start();
	CALL        _Soft_I2C_Start+0, 0
;ds1307_SH.c,68 :: 		Soft_I2C_Write(dir_ds1307  | 0b00000001);
	MOVLW       209
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,69 :: 		leido= Bcd2Dec(Soft_I2C_Read(0)) & 0b01111111;
	CLRF        FARG_Soft_I2C_Read_ack+0 
	CLRF        FARG_Soft_I2C_Read_ack+1 
	CALL        _Soft_I2C_Read+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Bcd2Dec_bcdnum+0 
	CALL        _Bcd2Dec+0, 0
	MOVLW       127
	ANDWF       R0, 0 
	MOVWF       lee_minuto_s_leido_L0+0 
;ds1307_SH.c,70 :: 		Soft_I2C_Stop();
	CALL        _Soft_I2C_Stop+0, 0
;ds1307_SH.c,71 :: 		return (leido);
	MOVF        lee_minuto_s_leido_L0+0, 0 
	MOVWF       R0 
;ds1307_SH.c,73 :: 		}
L_end_lee_minuto_s:
	RETURN      0
; end of _lee_minuto_s

_lee_dia_s:

;ds1307_SH.c,75 :: 		char lee_dia_s()
;ds1307_SH.c,79 :: 		Soft_I2C_Start();
	CALL        _Soft_I2C_Start+0, 0
;ds1307_SH.c,80 :: 		Soft_I2C_Write(dir_ds1307  & 0b11111110);
	MOVLW       208
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,81 :: 		Soft_I2C_Write(d_dia);
	MOVLW       3
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,83 :: 		Soft_I2C_Start();
	CALL        _Soft_I2C_Start+0, 0
;ds1307_SH.c,85 :: 		Soft_I2C_Write(dir_ds1307  | 0b00000001);
	MOVLW       209
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,87 :: 		leido= (Bcd2Dec(Soft_I2C_Read(0))) & 0b000001111;
	CLRF        FARG_Soft_I2C_Read_ack+0 
	CLRF        FARG_Soft_I2C_Read_ack+1 
	CALL        _Soft_I2C_Read+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Bcd2Dec_bcdnum+0 
	CALL        _Bcd2Dec+0, 0
	MOVLW       15
	ANDWF       R0, 0 
	MOVWF       lee_dia_s_leido_L0+0 
;ds1307_SH.c,89 :: 		Soft_I2C_Stop();
	CALL        _Soft_I2C_Stop+0, 0
;ds1307_SH.c,91 :: 		return (leido);
	MOVF        lee_dia_s_leido_L0+0, 0 
	MOVWF       R0 
;ds1307_SH.c,93 :: 		}
L_end_lee_dia_s:
	RETURN      0
; end of _lee_dia_s

_lee_hora_s:

;ds1307_SH.c,95 :: 		char lee_hora_s()
;ds1307_SH.c,99 :: 		Soft_I2C_Start();
	CALL        _Soft_I2C_Start+0, 0
;ds1307_SH.c,100 :: 		Soft_I2C_Write(dir_ds1307  & 0b11111110);
	MOVLW       208
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,101 :: 		Soft_I2C_Write(d_hora);
	MOVLW       2
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,103 :: 		Soft_I2C_Start();
	CALL        _Soft_I2C_Start+0, 0
;ds1307_SH.c,105 :: 		Soft_I2C_Write(dir_ds1307  | 0b00000001);
	MOVLW       209
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,107 :: 		leido= (Bcd2Dec(Soft_I2C_Read(0))) & 0b001111111;
	CLRF        FARG_Soft_I2C_Read_ack+0 
	CLRF        FARG_Soft_I2C_Read_ack+1 
	CALL        _Soft_I2C_Read+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Bcd2Dec_bcdnum+0 
	CALL        _Bcd2Dec+0, 0
	MOVLW       127
	ANDWF       R0, 0 
	MOVWF       lee_hora_s_leido_L0+0 
;ds1307_SH.c,109 :: 		Soft_I2C_Stop();
	CALL        _Soft_I2C_Stop+0, 0
;ds1307_SH.c,111 :: 		return (leido);
	MOVF        lee_hora_s_leido_L0+0, 0 
	MOVWF       R0 
;ds1307_SH.c,113 :: 		}
L_end_lee_hora_s:
	RETURN      0
; end of _lee_hora_s

_lee_fecha_s:

;ds1307_SH.c,114 :: 		char lee_fecha_s()
;ds1307_SH.c,118 :: 		Soft_I2C_Start();
	CALL        _Soft_I2C_Start+0, 0
;ds1307_SH.c,119 :: 		Soft_I2C_Write(dir_ds1307  & 0b11111110);
	MOVLW       208
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,120 :: 		Soft_I2C_Write(d_fecha);
	MOVLW       4
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,121 :: 		Soft_I2C_Start();
	CALL        _Soft_I2C_Start+0, 0
;ds1307_SH.c,123 :: 		Soft_I2C_Write(dir_ds1307  | 0b00000001);
	MOVLW       209
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,125 :: 		leido= (Bcd2Dec(Soft_I2C_Read(0))) & 0b00111111;
	CLRF        FARG_Soft_I2C_Read_ack+0 
	CLRF        FARG_Soft_I2C_Read_ack+1 
	CALL        _Soft_I2C_Read+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Bcd2Dec_bcdnum+0 
	CALL        _Bcd2Dec+0, 0
	MOVLW       63
	ANDWF       R0, 0 
	MOVWF       lee_fecha_s_leido_L0+0 
;ds1307_SH.c,126 :: 		Soft_I2C_Stop();
	CALL        _Soft_I2C_Stop+0, 0
;ds1307_SH.c,128 :: 		return (leido);
	MOVF        lee_fecha_s_leido_L0+0, 0 
	MOVWF       R0 
;ds1307_SH.c,130 :: 		}
L_end_lee_fecha_s:
	RETURN      0
; end of _lee_fecha_s

_lee_mes_s:

;ds1307_SH.c,131 :: 		char lee_mes_s()
;ds1307_SH.c,135 :: 		Soft_I2C_Start();
	CALL        _Soft_I2C_Start+0, 0
;ds1307_SH.c,136 :: 		Soft_I2C_Write(dir_ds1307  & 0b11111110);
	MOVLW       208
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,137 :: 		Soft_I2C_Write(d_mes);
	MOVLW       5
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,138 :: 		Soft_I2C_Start();
	CALL        _Soft_I2C_Start+0, 0
;ds1307_SH.c,139 :: 		Soft_I2C_Write(dir_ds1307  | 0b00000001);
	MOVLW       209
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,140 :: 		leido= (Bcd2Dec(Soft_I2C_Read(0))) & 0b000111111;
	CLRF        FARG_Soft_I2C_Read_ack+0 
	CLRF        FARG_Soft_I2C_Read_ack+1 
	CALL        _Soft_I2C_Read+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Bcd2Dec_bcdnum+0 
	CALL        _Bcd2Dec+0, 0
	MOVLW       63
	ANDWF       R0, 0 
	MOVWF       lee_mes_s_leido_L0+0 
;ds1307_SH.c,142 :: 		Soft_I2C_Stop();
	CALL        _Soft_I2C_Stop+0, 0
;ds1307_SH.c,144 :: 		return (leido);
	MOVF        lee_mes_s_leido_L0+0, 0 
	MOVWF       R0 
;ds1307_SH.c,146 :: 		}
L_end_lee_mes_s:
	RETURN      0
; end of _lee_mes_s

_lee_anho_s:

;ds1307_SH.c,147 :: 		char lee_anho_s()
;ds1307_SH.c,151 :: 		Soft_I2C_Start();
	CALL        _Soft_I2C_Start+0, 0
;ds1307_SH.c,152 :: 		Soft_I2C_Write(dir_ds1307  & 0b11111110);
	MOVLW       208
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,153 :: 		Soft_I2C_Write(d_anho);
	MOVLW       6
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,154 :: 		Soft_I2C_Start();
	CALL        _Soft_I2C_Start+0, 0
;ds1307_SH.c,155 :: 		Soft_I2C_Write(dir_ds1307  | 0b00000001);
	MOVLW       209
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,156 :: 		leido= (Bcd2Dec(Soft_I2C_Read(0))) & 0b111111111;
	CLRF        FARG_Soft_I2C_Read_ack+0 
	CLRF        FARG_Soft_I2C_Read_ack+1 
	CALL        _Soft_I2C_Read+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_Bcd2Dec_bcdnum+0 
	CALL        _Bcd2Dec+0, 0
	MOVLW       255
	ANDWF       R0, 0 
	MOVWF       lee_anho_s_leido_L0+0 
;ds1307_SH.c,158 :: 		Soft_I2C_Stop();
	CALL        _Soft_I2C_Stop+0, 0
;ds1307_SH.c,160 :: 		return (leido);
	MOVF        lee_anho_s_leido_L0+0, 0 
	MOVWF       R0 
;ds1307_SH.c,162 :: 		}
L_end_lee_anho_s:
	RETURN      0
; end of _lee_anho_s

_guarda_segundo_s:

;ds1307_SH.c,164 :: 		void guarda_segundo_s()
;ds1307_SH.c,168 :: 		tempi=Dec2Bcd(ds1307._segundo);
	MOVF        _ds1307+0, 0 
	MOVWF       FARG_Dec2Bcd_decnum+0 
	CALL        _Dec2Bcd+0, 0
	MOVF        R0, 0 
	MOVWF       guarda_segundo_s_tempi_L0+0 
;ds1307_SH.c,169 :: 		tempi.b7=0;
	BCF         guarda_segundo_s_tempi_L0+0, 7 
;ds1307_SH.c,171 :: 		Soft_I2C_Start();
	CALL        _Soft_I2C_Start+0, 0
;ds1307_SH.c,172 :: 		Soft_I2C_Write(dir_ds1307  & 0b11111110);
	MOVLW       208
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,173 :: 		Soft_I2C_Write(d_segundo);
	CLRF        FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,174 :: 		Soft_I2C_Write(tempi);
	MOVF        guarda_segundo_s_tempi_L0+0, 0 
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,175 :: 		Soft_I2C_Stop();
	CALL        _Soft_I2C_Stop+0, 0
;ds1307_SH.c,177 :: 		}
L_end_guarda_segundo_s:
	RETURN      0
; end of _guarda_segundo_s

_guarda_minuto_s:

;ds1307_SH.c,179 :: 		void guarda_minuto_s()
;ds1307_SH.c,183 :: 		tempi=Dec2Bcd(ds1307._minuto);
	MOVF        _ds1307+1, 0 
	MOVWF       FARG_Dec2Bcd_decnum+0 
	CALL        _Dec2Bcd+0, 0
	MOVF        R0, 0 
	MOVWF       guarda_minuto_s_tempi_L0+0 
;ds1307_SH.c,184 :: 		tempi.b7=0;
	BCF         guarda_minuto_s_tempi_L0+0, 7 
;ds1307_SH.c,186 :: 		Soft_I2C_Start();
	CALL        _Soft_I2C_Start+0, 0
;ds1307_SH.c,187 :: 		Soft_I2C_Write(dir_ds1307  & 0b11111110);
	MOVLW       208
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,188 :: 		Soft_I2C_Write(d_minuto);
	MOVLW       1
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,189 :: 		Soft_I2C_Write(tempi);
	MOVF        guarda_minuto_s_tempi_L0+0, 0 
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,190 :: 		Soft_I2C_Stop();
	CALL        _Soft_I2C_Stop+0, 0
;ds1307_SH.c,192 :: 		}
L_end_guarda_minuto_s:
	RETURN      0
; end of _guarda_minuto_s

_guarda_hora_S:

;ds1307_SH.c,194 :: 		void guarda_hora_S()
;ds1307_SH.c,198 :: 		tempi=Dec2Bcd(ds1307._hora);
	MOVF        _ds1307+2, 0 
	MOVWF       FARG_Dec2Bcd_decnum+0 
	CALL        _Dec2Bcd+0, 0
	MOVF        R0, 0 
	MOVWF       guarda_hora_S_tempi_L0+0 
;ds1307_SH.c,199 :: 		tempi.b7=0;
	BCF         guarda_hora_S_tempi_L0+0, 7 
;ds1307_SH.c,200 :: 		tempi.b6=0;  //para 24 horas
	BCF         guarda_hora_S_tempi_L0+0, 6 
;ds1307_SH.c,202 :: 		Soft_I2C_Start();
	CALL        _Soft_I2C_Start+0, 0
;ds1307_SH.c,203 :: 		Soft_I2C_Write(dir_ds1307  & 0b11111110);
	MOVLW       208
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,204 :: 		Soft_I2C_Write(d_hora);
	MOVLW       2
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,205 :: 		Soft_I2C_Write(tempi);
	MOVF        guarda_hora_S_tempi_L0+0, 0 
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,206 :: 		Soft_I2C_Stop();
	CALL        _Soft_I2C_Stop+0, 0
;ds1307_SH.c,208 :: 		}
L_end_guarda_hora_S:
	RETURN      0
; end of _guarda_hora_S

_guarda_dia_s:

;ds1307_SH.c,209 :: 		void guarda_dia_s()
;ds1307_SH.c,213 :: 		tempi=Dec2Bcd(ds1307._dia);
	MOVF        _ds1307+3, 0 
	MOVWF       FARG_Dec2Bcd_decnum+0 
	CALL        _Dec2Bcd+0, 0
	MOVF        R0, 0 
	MOVWF       guarda_dia_s_tempi_L0+0 
;ds1307_SH.c,214 :: 		tempi.b7=0;
	BCF         guarda_dia_s_tempi_L0+0, 7 
;ds1307_SH.c,215 :: 		tempi.b6=0;
	BCF         guarda_dia_s_tempi_L0+0, 6 
;ds1307_SH.c,216 :: 		tempi.b5=0;
	BCF         guarda_dia_s_tempi_L0+0, 5 
;ds1307_SH.c,217 :: 		tempi.b4=0;
	BCF         guarda_dia_s_tempi_L0+0, 4 
;ds1307_SH.c,218 :: 		tempi.b3=0;
	BCF         guarda_dia_s_tempi_L0+0, 3 
;ds1307_SH.c,221 :: 		Soft_I2C_Start();
	CALL        _Soft_I2C_Start+0, 0
;ds1307_SH.c,222 :: 		Soft_I2C_Write(dir_ds1307  & 0b11111110);
	MOVLW       208
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,223 :: 		Soft_I2C_Write(d_dia);
	MOVLW       3
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,224 :: 		Soft_I2C_Write(tempi);
	MOVF        guarda_dia_s_tempi_L0+0, 0 
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,225 :: 		Soft_I2C_Stop();
	CALL        _Soft_I2C_Stop+0, 0
;ds1307_SH.c,227 :: 		}
L_end_guarda_dia_s:
	RETURN      0
; end of _guarda_dia_s

_guarda_fecha_s:

;ds1307_SH.c,228 :: 		void guarda_fecha_s()
;ds1307_SH.c,232 :: 		tempi=Dec2Bcd(ds1307._fecha);
	MOVF        _ds1307+4, 0 
	MOVWF       FARG_Dec2Bcd_decnum+0 
	CALL        _Dec2Bcd+0, 0
	MOVF        R0, 0 
	MOVWF       guarda_fecha_s_tempi_L0+0 
;ds1307_SH.c,233 :: 		tempi.b7=0;
	BCF         guarda_fecha_s_tempi_L0+0, 7 
;ds1307_SH.c,234 :: 		tempi.b6=0;
	BCF         guarda_fecha_s_tempi_L0+0, 6 
;ds1307_SH.c,236 :: 		Soft_I2C_Start();
	CALL        _Soft_I2C_Start+0, 0
;ds1307_SH.c,237 :: 		Soft_I2C_Write(dir_ds1307  & 0b11111110);
	MOVLW       208
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,238 :: 		Soft_I2C_Write(d_fecha);
	MOVLW       4
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,239 :: 		Soft_I2C_Write(tempi);
	MOVF        guarda_fecha_s_tempi_L0+0, 0 
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,240 :: 		Soft_I2C_Stop();
	CALL        _Soft_I2C_Stop+0, 0
;ds1307_SH.c,242 :: 		}
L_end_guarda_fecha_s:
	RETURN      0
; end of _guarda_fecha_s

_guarda_mes_s:

;ds1307_SH.c,243 :: 		void guarda_mes_s()
;ds1307_SH.c,247 :: 		tempi=Dec2Bcd(ds1307._mes);
	MOVF        _ds1307+5, 0 
	MOVWF       FARG_Dec2Bcd_decnum+0 
	CALL        _Dec2Bcd+0, 0
	MOVF        R0, 0 
	MOVWF       guarda_mes_s_tempi_L0+0 
;ds1307_SH.c,248 :: 		tempi.b7=0;
	BCF         guarda_mes_s_tempi_L0+0, 7 
;ds1307_SH.c,250 :: 		Soft_I2C_Start();
	CALL        _Soft_I2C_Start+0, 0
;ds1307_SH.c,251 :: 		Soft_I2C_Write(dir_ds1307  & 0b11111110);
	MOVLW       208
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,252 :: 		Soft_I2C_Write(d_mes);
	MOVLW       5
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,253 :: 		Soft_I2C_Write(tempi);
	MOVF        guarda_mes_s_tempi_L0+0, 0 
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,254 :: 		Soft_I2C_Stop();
	CALL        _Soft_I2C_Stop+0, 0
;ds1307_SH.c,256 :: 		}
L_end_guarda_mes_s:
	RETURN      0
; end of _guarda_mes_s

_guarda_anho_s:

;ds1307_SH.c,257 :: 		void guarda_anho_s()
;ds1307_SH.c,261 :: 		tempi=Dec2Bcd(ds1307._anho);
	MOVF        _ds1307+6, 0 
	MOVWF       FARG_Dec2Bcd_decnum+0 
	CALL        _Dec2Bcd+0, 0
	MOVF        R0, 0 
	MOVWF       guarda_anho_s_tempi_L0+0 
;ds1307_SH.c,265 :: 		Soft_I2C_Start();
	CALL        _Soft_I2C_Start+0, 0
;ds1307_SH.c,266 :: 		Soft_I2C_Write(dir_ds1307  & 0b11111110);
	MOVLW       208
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,267 :: 		Soft_I2C_Write(d_anho);
	MOVLW       6
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,268 :: 		Soft_I2C_Write(tempi);
	MOVF        guarda_anho_s_tempi_L0+0, 0 
	MOVWF       FARG_Soft_I2C_Write_data_+0 
	CALL        _Soft_I2C_Write+0, 0
;ds1307_SH.c,269 :: 		Soft_I2C_Stop();
	CALL        _Soft_I2C_Stop+0, 0
;ds1307_SH.c,271 :: 		}
L_end_guarda_anho_s:
	RETURN      0
; end of _guarda_anho_s

_guardatodo_s:

;ds1307_SH.c,273 :: 		void guardatodo_s()
;ds1307_SH.c,275 :: 		guarda_control_s();
	CALL        _guarda_control_s+0, 0
;ds1307_SH.c,276 :: 		guarda_segundo_s();
	CALL        _guarda_segundo_s+0, 0
;ds1307_SH.c,277 :: 		guarda_minuto_s();
	CALL        _guarda_minuto_s+0, 0
;ds1307_SH.c,278 :: 		guarda_hora_s();
	CALL        _guarda_hora_S+0, 0
;ds1307_SH.c,279 :: 		guarda_dia_s();
	CALL        _guarda_dia_s+0, 0
;ds1307_SH.c,280 :: 		guarda_mes_s();
	CALL        _guarda_mes_s+0, 0
;ds1307_SH.c,281 :: 		guarda_fecha_s();
	CALL        _guarda_fecha_s+0, 0
;ds1307_SH.c,282 :: 		guarda_anho_s();
	CALL        _guarda_anho_s+0, 0
;ds1307_SH.c,283 :: 		}
L_end_guardatodo_s:
	RETURN      0
; end of _guardatodo_s

_leertodo_s:

;ds1307_SH.c,285 :: 		void leertodo_s()
;ds1307_SH.c,287 :: 		ds1307._segundo=lee_segundo_s();
	CALL        _lee_segundo_s+0, 0
	MOVF        R0, 0 
	MOVWF       _ds1307+0 
;ds1307_SH.c,288 :: 		ds1307._minuto=lee_minuto_s();
	CALL        _lee_minuto_s+0, 0
	MOVF        R0, 0 
	MOVWF       _ds1307+1 
;ds1307_SH.c,289 :: 		ds1307._dia=lee_dia_s();
	CALL        _lee_dia_s+0, 0
	MOVF        R0, 0 
	MOVWF       _ds1307+3 
;ds1307_SH.c,290 :: 		ds1307._fecha=lee_fecha_s();
	CALL        _lee_fecha_s+0, 0
	MOVF        R0, 0 
	MOVWF       _ds1307+4 
;ds1307_SH.c,291 :: 		ds1307._hora=lee_hora_s();
	CALL        _lee_hora_s+0, 0
	MOVF        R0, 0 
	MOVWF       _ds1307+2 
;ds1307_SH.c,292 :: 		ds1307._mes=lee_mes_s();
	CALL        _lee_mes_s+0, 0
	MOVF        R0, 0 
	MOVWF       _ds1307+5 
;ds1307_SH.c,293 :: 		ds1307._anho=lee_anho_s();
	CALL        _lee_anho_s+0, 0
	MOVF        R0, 0 
	MOVWF       _ds1307+6 
;ds1307_SH.c,295 :: 		}
L_end_leertodo_s:
	RETURN      0
; end of _leertodo_s

_reloj_init:

;ds1307_SH.c,297 :: 		void reloj_init()
;ds1307_SH.c,299 :: 		I2C1_Init(100000);
	MOVLW       50
	MOVWF       SSP1ADD+0 
	CALL        _I2C1_Init+0, 0
;ds1307_SH.c,300 :: 		}
L_end_reloj_init:
	RETURN      0
; end of _reloj_init

_reloj_init_s:

;ds1307_SH.c,303 :: 		void reloj_init_s()
;ds1307_SH.c,305 :: 		Soft_I2C_Init();
	CALL        _Soft_I2C_Init+0, 0
;ds1307_SH.c,306 :: 		}
L_end_reloj_init_s:
	RETURN      0
; end of _reloj_init_s

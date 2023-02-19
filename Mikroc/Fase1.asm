
_Uart1_write_text_const:

;Fase1.c,41 :: 		void Uart1_write_text_const(const char *info)
;Fase1.c,43 :: 		while(*info) UART1_Write(*info++);
L_Uart1_write_text_const0:
	MOVF        FARG_Uart1_write_text_const_info+0, 0 
	MOVWF       TBLPTRL+0 
	MOVF        FARG_Uart1_write_text_const_info+1, 0 
	MOVWF       TBLPTRH+0 
	MOVF        FARG_Uart1_write_text_const_info+2, 0 
	MOVWF       TBLPTRU+0 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Uart1_write_text_const1
	MOVF        FARG_Uart1_write_text_const_info+0, 0 
	MOVWF       TBLPTRL+0 
	MOVF        FARG_Uart1_write_text_const_info+1, 0 
	MOVWF       TBLPTRH+0 
	MOVF        FARG_Uart1_write_text_const_info+2, 0 
	MOVWF       TBLPTRU+0 
	TBLRD*+
	MOVFF       TABLAT+0, FARG_UART1_Write_data_+0
	CALL        _UART1_Write+0, 0
	MOVLW       1
	ADDWF       FARG_Uart1_write_text_const_info+0, 1 
	MOVLW       0
	ADDWFC      FARG_Uart1_write_text_const_info+1, 1 
	ADDWFC      FARG_Uart1_write_text_const_info+2, 1 
	GOTO        L_Uart1_write_text_const0
L_Uart1_write_text_const1:
;Fase1.c,44 :: 		}
L_end_Uart1_write_text_const:
	RETURN      0
; end of _Uart1_write_text_const

_tiempo:

;Fase1.c,46 :: 		char tiempo(unsigned int milis, char cap[15], char cap1[15])
;Fase1.c,51 :: 		trama_cont=0;
	CLRF        _trama_cont+0 
;Fase1.c,52 :: 		memset(trama_rx,0,100);// LIMPIA LA TRAMA
	MOVLW       _trama_rx+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_trama_rx+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       100
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;Fase1.c,53 :: 		RCIF_bit=0;
	BCF         RCIF_bit+0, BitPos(RCIF_bit+0) 
;Fase1.c,55 :: 		CREN_bit=0;
	BCF         CREN_bit+0, BitPos(CREN_bit+0) 
;Fase1.c,56 :: 		CREN_bit=1;
	BSF         CREN_bit+0, BitPos(CREN_bit+0) 
;Fase1.c,57 :: 		RCIE_bit=1;
	BSF         RCIE_bit+0, BitPos(RCIE_bit+0) 
;Fase1.c,58 :: 		Delay_ms(10);
	MOVLW       156
	MOVWF       R12, 0
	MOVLW       215
	MOVWF       R13, 0
L_tiempo2:
	DECFSZ      R13, 1, 1
	BRA         L_tiempo2
	DECFSZ      R12, 1, 1
	BRA         L_tiempo2
;Fase1.c,59 :: 		for (cont1=1;cont1<=milis;cont1++)
	MOVLW       1
	MOVWF       tiempo_cont1_L0+0 
	MOVLW       0
	MOVWF       tiempo_cont1_L0+1 
L_tiempo3:
	MOVF        tiempo_cont1_L0+1, 0 
	SUBWF       FARG_tiempo_milis+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__tiempo73
	MOVF        tiempo_cont1_L0+0, 0 
	SUBWF       FARG_tiempo_milis+0, 0 
L__tiempo73:
	BTFSS       STATUS+0, 0 
	GOTO        L_tiempo4
;Fase1.c,61 :: 		delay_Ms(1);
	MOVLW       16
	MOVWF       R12, 0
	MOVLW       148
	MOVWF       R13, 0
L_tiempo6:
	DECFSZ      R13, 1, 1
	BRA         L_tiempo6
	DECFSZ      R12, 1, 1
	BRA         L_tiempo6
	NOP
;Fase1.c,63 :: 		if (strstr(trama_rx,cap)!=0 )
	MOVLW       _trama_rx+0
	MOVWF       FARG_strstr_s1+0 
	MOVLW       hi_addr(_trama_rx+0)
	MOVWF       FARG_strstr_s1+1 
	MOVF        FARG_tiempo_cap+0, 0 
	MOVWF       FARG_strstr_s2+0 
	MOVF        FARG_tiempo_cap+1, 0 
	MOVWF       FARG_strstr_s2+1 
	CALL        _strstr+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__tiempo74
	MOVLW       0
	XORWF       R0, 0 
L__tiempo74:
	BTFSC       STATUS+0, 2 
	GOTO        L_tiempo7
;Fase1.c,65 :: 		RCIE_bit=0; // deshabilita la interrpcion
	BCF         RCIE_bit+0, BitPos(RCIE_bit+0) 
;Fase1.c,66 :: 		Delay_ms(10);
	MOVLW       156
	MOVWF       R12, 0
	MOVLW       215
	MOVWF       R13, 0
L_tiempo8:
	DECFSZ      R13, 1, 1
	BRA         L_tiempo8
	DECFSZ      R12, 1, 1
	BRA         L_tiempo8
;Fase1.c,67 :: 		return(1);
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_tiempo
;Fase1.c,68 :: 		}
L_tiempo7:
;Fase1.c,69 :: 		else  if (strstr(trama_rx,cap1)!=0 )
	MOVLW       _trama_rx+0
	MOVWF       FARG_strstr_s1+0 
	MOVLW       hi_addr(_trama_rx+0)
	MOVWF       FARG_strstr_s1+1 
	MOVF        FARG_tiempo_cap1+0, 0 
	MOVWF       FARG_strstr_s2+0 
	MOVF        FARG_tiempo_cap1+1, 0 
	MOVWF       FARG_strstr_s2+1 
	CALL        _strstr+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__tiempo75
	MOVLW       0
	XORWF       R0, 0 
L__tiempo75:
	BTFSC       STATUS+0, 2 
	GOTO        L_tiempo10
;Fase1.c,71 :: 		RCIE_bit=0; // deshabilita la interrpcion
	BCF         RCIE_bit+0, BitPos(RCIE_bit+0) 
;Fase1.c,72 :: 		Delay_ms(10);
	MOVLW       156
	MOVWF       R12, 0
	MOVLW       215
	MOVWF       R13, 0
L_tiempo11:
	DECFSZ      R13, 1, 1
	BRA         L_tiempo11
	DECFSZ      R12, 1, 1
	BRA         L_tiempo11
;Fase1.c,73 :: 		return(2);
	MOVLW       2
	MOVWF       R0 
	GOTO        L_end_tiempo
;Fase1.c,74 :: 		}
L_tiempo10:
;Fase1.c,59 :: 		for (cont1=1;cont1<=milis;cont1++)
	INFSNZ      tiempo_cont1_L0+0, 1 
	INCF        tiempo_cont1_L0+1, 1 
;Fase1.c,75 :: 		}
	GOTO        L_tiempo3
L_tiempo4:
;Fase1.c,77 :: 		RCIE_bit=0; // deshabilita la interrpcion
	BCF         RCIE_bit+0, BitPos(RCIE_bit+0) 
;Fase1.c,78 :: 		return(0);
	CLRF        R0 
;Fase1.c,79 :: 		}
L_end_tiempo:
	RETURN      0
; end of _tiempo

_manda_AT_COMANDO:

;Fase1.c,81 :: 		char manda_AT_COMANDO(char *coman, char cap[15], char cap1[15],unsigned int retardo)
;Fase1.c,83 :: 		Uart1_write_text(coman);//manda el comando
	MOVF        FARG_manda_AT_COMANDO_coman+0, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVF        FARG_manda_AT_COMANDO_coman+1, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Fase1.c,84 :: 		Uart1_write_text_const("\r\n"); // manda final de linea
	MOVLW       ?lstr_1_Fase1+0
	MOVWF       FARG_Uart1_write_text_const_info+0 
	MOVLW       hi_addr(?lstr_1_Fase1+0)
	MOVWF       FARG_Uart1_write_text_const_info+1 
	MOVLW       higher_addr(?lstr_1_Fase1+0)
	MOVWF       FARG_Uart1_write_text_const_info+2 
	CALL        _Uart1_write_text_const+0, 0
;Fase1.c,85 :: 		return (tiempo(retardo,cap,cap1));
	MOVF        FARG_manda_AT_COMANDO_retardo+0, 0 
	MOVWF       FARG_tiempo_milis+0 
	MOVF        FARG_manda_AT_COMANDO_retardo+1, 0 
	MOVWF       FARG_tiempo_milis+1 
	MOVF        FARG_manda_AT_COMANDO_cap+0, 0 
	MOVWF       FARG_tiempo_cap+0 
	MOVF        FARG_manda_AT_COMANDO_cap+1, 0 
	MOVWF       FARG_tiempo_cap+1 
	MOVF        FARG_manda_AT_COMANDO_cap1+0, 0 
	MOVWF       FARG_tiempo_cap1+0 
	MOVF        FARG_manda_AT_COMANDO_cap1+1, 0 
	MOVWF       FARG_tiempo_cap1+1 
	CALL        _tiempo+0, 0
;Fase1.c,86 :: 		}
L_end_manda_AT_COMANDO:
	RETURN      0
; end of _manda_AT_COMANDO

_prendio:

;Fase1.c,89 :: 		unsigned char prendio()
;Fase1.c,91 :: 		Delay_ms(2000);
	MOVLW       122
	MOVWF       R11, 0
	MOVLW       193
	MOVWF       R12, 0
	MOVLW       129
	MOVWF       R13, 0
L_prendio12:
	DECFSZ      R13, 1, 1
	BRA         L_prendio12
	DECFSZ      R12, 1, 1
	BRA         L_prendio12
	DECFSZ      R11, 1, 1
	BRA         L_prendio12
	NOP
	NOP
;Fase1.c,94 :: 		if ( manda_AT_COMANDO("AT","OK","ERROR",2000)==1) return(1);
	MOVLW       ?lstr2_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_coman+0 
	MOVLW       hi_addr(?lstr2_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_coman+1 
	MOVLW       ?lstr3_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_cap+0 
	MOVLW       hi_addr(?lstr3_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_cap+1 
	MOVLW       ?lstr4_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_cap1+0 
	MOVLW       hi_addr(?lstr4_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_cap1+1 
	MOVLW       208
	MOVWF       FARG_manda_AT_COMANDO_retardo+0 
	MOVLW       7
	MOVWF       FARG_manda_AT_COMANDO_retardo+1 
	CALL        _manda_AT_COMANDO+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_prendio13
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_prendio
L_prendio13:
;Fase1.c,97 :: 		pin_on=0;
	BCF         LATB0_bit+0, BitPos(LATB0_bit+0) 
;Fase1.c,98 :: 		Delay_ms(1000);
	MOVLW       61
	MOVWF       R11, 0
	MOVLW       225
	MOVWF       R12, 0
	MOVLW       63
	MOVWF       R13, 0
L_prendio15:
	DECFSZ      R13, 1, 1
	BRA         L_prendio15
	DECFSZ      R12, 1, 1
	BRA         L_prendio15
	DECFSZ      R11, 1, 1
	BRA         L_prendio15
	NOP
	NOP
;Fase1.c,99 :: 		pin_on=1;
	BSF         LATB0_bit+0, BitPos(LATB0_bit+0) 
;Fase1.c,100 :: 		Delay_ms(2000);
	MOVLW       122
	MOVWF       R11, 0
	MOVLW       193
	MOVWF       R12, 0
	MOVLW       129
	MOVWF       R13, 0
L_prendio16:
	DECFSZ      R13, 1, 1
	BRA         L_prendio16
	DECFSZ      R12, 1, 1
	BRA         L_prendio16
	DECFSZ      R11, 1, 1
	BRA         L_prendio16
	NOP
	NOP
;Fase1.c,101 :: 		pin_on=0;
	BCF         LATB0_bit+0, BitPos(LATB0_bit+0) 
;Fase1.c,102 :: 		Delay_ms(2000);
	MOVLW       122
	MOVWF       R11, 0
	MOVLW       193
	MOVWF       R12, 0
	MOVLW       129
	MOVWF       R13, 0
L_prendio17:
	DECFSZ      R13, 1, 1
	BRA         L_prendio17
	DECFSZ      R12, 1, 1
	BRA         L_prendio17
	DECFSZ      R11, 1, 1
	BRA         L_prendio17
	NOP
	NOP
;Fase1.c,104 :: 		if ( manda_AT_COMANDO("AT","OK","ERROR",2000)==1) return(1);
	MOVLW       ?lstr5_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_coman+0 
	MOVLW       hi_addr(?lstr5_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_coman+1 
	MOVLW       ?lstr6_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_cap+0 
	MOVLW       hi_addr(?lstr6_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_cap+1 
	MOVLW       ?lstr7_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_cap1+0 
	MOVLW       hi_addr(?lstr7_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_cap1+1 
	MOVLW       208
	MOVWF       FARG_manda_AT_COMANDO_retardo+0 
	MOVLW       7
	MOVWF       FARG_manda_AT_COMANDO_retardo+1 
	CALL        _manda_AT_COMANDO+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_prendio18
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_prendio
L_prendio18:
;Fase1.c,105 :: 		else return(0);//SINO MANDA ERROR
	CLRF        R0 
;Fase1.c,107 :: 		}
L_end_prendio:
	RETURN      0
; end of _prendio

_interrupcion:

;Fase1.c,110 :: 		void interrupcion() iv 0x0008 ics ICS_AUTO
;Fase1.c,113 :: 		if (RCIF_bit==1)
	BTFSS       RCIF_bit+0, BitPos(RCIF_bit+0) 
	GOTO        L_interrupcion20
;Fase1.c,115 :: 		dato_rx=RCREG; // lee el dato
	MOVF        RCREG+0, 0 
	MOVWF       _dato_rx+0 
;Fase1.c,116 :: 		trama_rx[trama_cont]=dato_rx;
	MOVLW       _trama_rx+0
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_trama_rx+0)
	MOVWF       FSR1L+1 
	MOVF        _trama_cont+0, 0 
	ADDWF       FSR1L+0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1L+1, 1 
	MOVF        _dato_rx+0, 0 
	MOVWF       POSTINC1+0 
;Fase1.c,117 :: 		trama_cont++;
	INCF        _trama_cont+0, 1 
;Fase1.c,118 :: 		if (trama_cont>=100) trama_cont=0;
	MOVLW       100
	SUBWF       _trama_cont+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupcion21
	CLRF        _trama_cont+0 
L_interrupcion21:
;Fase1.c,119 :: 		RCIF_bit=0;
	BCF         RCIF_bit+0, BitPos(RCIF_bit+0) 
;Fase1.c,120 :: 		}
L_interrupcion20:
;Fase1.c,122 :: 		}
L_end_interrupcion:
L__interrupcion79:
	RETFIE      1
; end of _interrupcion

_config_gprs:

;Fase1.c,125 :: 		void config_gprs()
;Fase1.c,127 :: 		hoy ://///////GO TO PARA REGRESAR EN CASO NO SE CONECTE/////////////////////////
___config_gprs_hoy:
;Fase1.c,130 :: 		manda_AT_COMANDO("AT+CIPSHUT","OK", "ERROR", 2000);
	MOVLW       ?lstr8_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_coman+0 
	MOVLW       hi_addr(?lstr8_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_coman+1 
	MOVLW       ?lstr9_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_cap+0 
	MOVLW       hi_addr(?lstr9_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_cap+1 
	MOVLW       ?lstr10_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_cap1+0 
	MOVLW       hi_addr(?lstr10_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_cap1+1 
	MOVLW       208
	MOVWF       FARG_manda_AT_COMANDO_retardo+0 
	MOVLW       7
	MOVWF       FARG_manda_AT_COMANDO_retardo+1 
	CALL        _manda_AT_COMANDO+0, 0
;Fase1.c,133 :: 		tempo=manda_AT_COMANDO("AT+CIPMUX=0", "OK", "ERROR", 4000);
	MOVLW       ?lstr11_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_coman+0 
	MOVLW       hi_addr(?lstr11_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_coman+1 
	MOVLW       ?lstr12_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_cap+0 
	MOVLW       hi_addr(?lstr12_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_cap+1 
	MOVLW       ?lstr13_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_cap1+0 
	MOVLW       hi_addr(?lstr13_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_cap1+1 
	MOVLW       160
	MOVWF       FARG_manda_AT_COMANDO_retardo+0 
	MOVLW       15
	MOVWF       FARG_manda_AT_COMANDO_retardo+1 
	CALL        _manda_AT_COMANDO+0, 0
	MOVF        R0, 0 
	MOVWF       _tempo+0 
;Fase1.c,134 :: 		if (tempo!=1)  goto hoy;
	MOVF        R0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_config_gprs22
	GOTO        ___config_gprs_hoy
L_config_gprs22:
;Fase1.c,137 :: 		tempo=manda_AT_COMANDO("AT+CIPSTATUS", "IP INITIAL", "ERROR", 500);
	MOVLW       ?lstr14_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_coman+0 
	MOVLW       hi_addr(?lstr14_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_coman+1 
	MOVLW       ?lstr15_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_cap+0 
	MOVLW       hi_addr(?lstr15_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_cap+1 
	MOVLW       ?lstr16_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_cap1+0 
	MOVLW       hi_addr(?lstr16_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_cap1+1 
	MOVLW       244
	MOVWF       FARG_manda_AT_COMANDO_retardo+0 
	MOVLW       1
	MOVWF       FARG_manda_AT_COMANDO_retardo+1 
	CALL        _manda_AT_COMANDO+0, 0
	MOVF        R0, 0 
	MOVWF       _tempo+0 
;Fase1.c,138 :: 		if (tempo!=1)  goto hoy;
	MOVF        R0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_config_gprs23
	GOTO        ___config_gprs_hoy
L_config_gprs23:
;Fase1.c,141 :: 		tempo=manda_AT_COMANDO("AT+CSTT=\"internet.ideasclaro\",\"\",\"\"", "OK",  "ERROR", 30000);
	MOVLW       ?lstr17_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_coman+0 
	MOVLW       hi_addr(?lstr17_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_coman+1 
	MOVLW       ?lstr18_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_cap+0 
	MOVLW       hi_addr(?lstr18_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_cap+1 
	MOVLW       ?lstr19_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_cap1+0 
	MOVLW       hi_addr(?lstr19_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_cap1+1 
	MOVLW       48
	MOVWF       FARG_manda_AT_COMANDO_retardo+0 
	MOVLW       117
	MOVWF       FARG_manda_AT_COMANDO_retardo+1 
	CALL        _manda_AT_COMANDO+0, 0
	MOVF        R0, 0 
	MOVWF       _tempo+0 
;Fase1.c,142 :: 		if (tempo!=1)  goto hoy;
	MOVF        R0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_config_gprs24
	GOTO        ___config_gprs_hoy
L_config_gprs24:
;Fase1.c,145 :: 		manda_AT_COMANDO("AT+CGQMIN= 1,0,0,0,0,0", "OK", "OK", 500);
	MOVLW       ?lstr20_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_coman+0 
	MOVLW       hi_addr(?lstr20_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_coman+1 
	MOVLW       ?lstr21_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_cap+0 
	MOVLW       hi_addr(?lstr21_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_cap+1 
	MOVLW       ?lstr22_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_cap1+0 
	MOVLW       hi_addr(?lstr22_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_cap1+1 
	MOVLW       244
	MOVWF       FARG_manda_AT_COMANDO_retardo+0 
	MOVLW       1
	MOVWF       FARG_manda_AT_COMANDO_retardo+1 
	CALL        _manda_AT_COMANDO+0, 0
;Fase1.c,146 :: 		manda_AT_COMANDO("AT+CGQREQ= 1,0,0,3,0,0", "OK", "OK", 500);
	MOVLW       ?lstr23_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_coman+0 
	MOVLW       hi_addr(?lstr23_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_coman+1 
	MOVLW       ?lstr24_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_cap+0 
	MOVLW       hi_addr(?lstr24_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_cap+1 
	MOVLW       ?lstr25_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_cap1+0 
	MOVLW       hi_addr(?lstr25_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_cap1+1 
	MOVLW       244
	MOVWF       FARG_manda_AT_COMANDO_retardo+0 
	MOVLW       1
	MOVWF       FARG_manda_AT_COMANDO_retardo+1 
	CALL        _manda_AT_COMANDO+0, 0
;Fase1.c,149 :: 		manda_AT_COMANDO("AT+CMGF=1", "OK", "OK", 500);
	MOVLW       ?lstr26_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_coman+0 
	MOVLW       hi_addr(?lstr26_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_coman+1 
	MOVLW       ?lstr27_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_cap+0 
	MOVLW       hi_addr(?lstr27_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_cap+1 
	MOVLW       ?lstr28_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_cap1+0 
	MOVLW       hi_addr(?lstr28_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_cap1+1 
	MOVLW       244
	MOVWF       FARG_manda_AT_COMANDO_retardo+0 
	MOVLW       1
	MOVWF       FARG_manda_AT_COMANDO_retardo+1 
	CALL        _manda_AT_COMANDO+0, 0
;Fase1.c,152 :: 		manda_AT_COMANDO("AT+CNMI=1,1,2,1,0", "OK", "OK", 500);
	MOVLW       ?lstr29_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_coman+0 
	MOVLW       hi_addr(?lstr29_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_coman+1 
	MOVLW       ?lstr30_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_cap+0 
	MOVLW       hi_addr(?lstr30_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_cap+1 
	MOVLW       ?lstr31_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_cap1+0 
	MOVLW       hi_addr(?lstr31_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_cap1+1 
	MOVLW       244
	MOVWF       FARG_manda_AT_COMANDO_retardo+0 
	MOVLW       1
	MOVWF       FARG_manda_AT_COMANDO_retardo+1 
	CALL        _manda_AT_COMANDO+0, 0
;Fase1.c,155 :: 		while(manda_AT_COMANDO("AT+CIPSTATUS", "START", "ERROR", 3000)  == 0 );
L_config_gprs25:
	MOVLW       ?lstr32_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_coman+0 
	MOVLW       hi_addr(?lstr32_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_coman+1 
	MOVLW       ?lstr33_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_cap+0 
	MOVLW       hi_addr(?lstr33_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_cap+1 
	MOVLW       ?lstr34_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_cap1+0 
	MOVLW       hi_addr(?lstr34_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_cap1+1 
	MOVLW       184
	MOVWF       FARG_manda_AT_COMANDO_retardo+0 
	MOVLW       11
	MOVWF       FARG_manda_AT_COMANDO_retardo+1 
	CALL        _manda_AT_COMANDO+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_config_gprs26
	GOTO        L_config_gprs25
L_config_gprs26:
;Fase1.c,156 :: 		Delay_ms(2000);// RETARDO PARA QUE ADEMAS DEL STATUS LLEGUE EL OK
	MOVLW       122
	MOVWF       R11, 0
	MOVLW       193
	MOVWF       R12, 0
	MOVLW       129
	MOVWF       R13, 0
L_config_gprs27:
	DECFSZ      R13, 1, 1
	BRA         L_config_gprs27
	DECFSZ      R12, 1, 1
	BRA         L_config_gprs27
	DECFSZ      R11, 1, 1
	BRA         L_config_gprs27
	NOP
	NOP
;Fase1.c,159 :: 		tempo=manda_AT_COMANDO("AT+CIICR", "OK",  "ERROR", 30000);
	MOVLW       ?lstr35_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_coman+0 
	MOVLW       hi_addr(?lstr35_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_coman+1 
	MOVLW       ?lstr36_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_cap+0 
	MOVLW       hi_addr(?lstr36_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_cap+1 
	MOVLW       ?lstr37_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_cap1+0 
	MOVLW       hi_addr(?lstr37_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_cap1+1 
	MOVLW       48
	MOVWF       FARG_manda_AT_COMANDO_retardo+0 
	MOVLW       117
	MOVWF       FARG_manda_AT_COMANDO_retardo+1 
	CALL        _manda_AT_COMANDO+0, 0
	MOVF        R0, 0 
	MOVWF       _tempo+0 
;Fase1.c,160 :: 		Delay_ms(10000);
	MOVLW       3
	MOVWF       R10, 0
	MOVLW       97
	MOVWF       R11, 0
	MOVLW       195
	MOVWF       R12, 0
	MOVLW       142
	MOVWF       R13, 0
L_config_gprs28:
	DECFSZ      R13, 1, 1
	BRA         L_config_gprs28
	DECFSZ      R12, 1, 1
	BRA         L_config_gprs28
	DECFSZ      R11, 1, 1
	BRA         L_config_gprs28
	DECFSZ      R10, 1, 1
	BRA         L_config_gprs28
	NOP
;Fase1.c,161 :: 		if (tempo!=1)  goto hoy;
	MOVF        _tempo+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_config_gprs29
	GOTO        ___config_gprs_hoy
L_config_gprs29:
;Fase1.c,164 :: 		while (tempo=manda_AT_COMANDO("AT+CIPSTATUS", "GPRSACT", "ERROR", 6000)==0);
L_config_gprs30:
	MOVLW       ?lstr38_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_coman+0 
	MOVLW       hi_addr(?lstr38_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_coman+1 
	MOVLW       ?lstr39_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_cap+0 
	MOVLW       hi_addr(?lstr39_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_cap+1 
	MOVLW       ?lstr40_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_cap1+0 
	MOVLW       hi_addr(?lstr40_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_cap1+1 
	MOVLW       112
	MOVWF       FARG_manda_AT_COMANDO_retardo+0 
	MOVLW       23
	MOVWF       FARG_manda_AT_COMANDO_retardo+1 
	CALL        _manda_AT_COMANDO+0, 0
	MOVF        R0, 0 
	XORLW       0
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       _tempo+0 
	MOVF        R1, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_config_gprs31
	GOTO        L_config_gprs30
L_config_gprs31:
;Fase1.c,165 :: 		Delay_ms(2000);
	MOVLW       122
	MOVWF       R11, 0
	MOVLW       193
	MOVWF       R12, 0
	MOVLW       129
	MOVWF       R13, 0
L_config_gprs32:
	DECFSZ      R13, 1, 1
	BRA         L_config_gprs32
	DECFSZ      R12, 1, 1
	BRA         L_config_gprs32
	DECFSZ      R11, 1, 1
	BRA         L_config_gprs32
	NOP
	NOP
;Fase1.c,168 :: 		tempo=manda_AT_COMANDO("AT+CIFSR", ".", "ERROR", 10000);
	MOVLW       ?lstr41_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_coman+0 
	MOVLW       hi_addr(?lstr41_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_coman+1 
	MOVLW       ?lstr42_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_cap+0 
	MOVLW       hi_addr(?lstr42_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_cap+1 
	MOVLW       ?lstr43_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_cap1+0 
	MOVLW       hi_addr(?lstr43_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_cap1+1 
	MOVLW       16
	MOVWF       FARG_manda_AT_COMANDO_retardo+0 
	MOVLW       39
	MOVWF       FARG_manda_AT_COMANDO_retardo+1 
	CALL        _manda_AT_COMANDO+0, 0
	MOVF        R0, 0 
	MOVWF       _tempo+0 
;Fase1.c,169 :: 		if (tempo!=1)  goto hoy;
	MOVF        R0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_config_gprs33
	GOTO        ___config_gprs_hoy
L_config_gprs33:
;Fase1.c,170 :: 		Delay_ms(3000);
	MOVLW       183
	MOVWF       R11, 0
	MOVLW       161
	MOVWF       R12, 0
	MOVLW       195
	MOVWF       R13, 0
L_config_gprs34:
	DECFSZ      R13, 1, 1
	BRA         L_config_gprs34
	DECFSZ      R12, 1, 1
	BRA         L_config_gprs34
	DECFSZ      R11, 1, 1
	BRA         L_config_gprs34
	NOP
	NOP
;Fase1.c,171 :: 		}
L_end_config_gprs:
	RETURN      0
; end of _config_gprs

_conecta:

;Fase1.c,174 :: 		unsigned char conecta()
;Fase1.c,176 :: 		tempo=manda_AT_COMANDO("AT+CIPSTART="  "\"TCP\""   ","   "\"things.ubidots.com\""  ","  "\"80\"", "CONNECT OK", "ALREADY CONNECT", 10000);
	MOVLW       ?lstr44_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_coman+0 
	MOVLW       hi_addr(?lstr44_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_coman+1 
	MOVLW       ?lstr45_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_cap+0 
	MOVLW       hi_addr(?lstr45_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_cap+1 
	MOVLW       ?lstr46_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_cap1+0 
	MOVLW       hi_addr(?lstr46_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_cap1+1 
	MOVLW       16
	MOVWF       FARG_manda_AT_COMANDO_retardo+0 
	MOVLW       39
	MOVWF       FARG_manda_AT_COMANDO_retardo+1 
	CALL        _manda_AT_COMANDO+0, 0
	MOVF        R0, 0 
	MOVWF       _tempo+0 
;Fase1.c,177 :: 		Delay_ms(2000);
	MOVLW       122
	MOVWF       R11, 0
	MOVLW       193
	MOVWF       R12, 0
	MOVLW       129
	MOVWF       R13, 0
L_conecta35:
	DECFSZ      R13, 1, 1
	BRA         L_conecta35
	DECFSZ      R12, 1, 1
	BRA         L_conecta35
	DECFSZ      R11, 1, 1
	BRA         L_conecta35
	NOP
	NOP
;Fase1.c,178 :: 		if ((tempo==1) ||(tempo==2)) return(1);
	MOVF        _tempo+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__conecta69
	MOVF        _tempo+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L__conecta69
	GOTO        L_conecta38
L__conecta69:
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_conecta
L_conecta38:
;Fase1.c,179 :: 		else return(0);
	CLRF        R0 
;Fase1.c,180 :: 		}
L_end_conecta:
	RETURN      0
; end of _conecta

_conectar:

;Fase1.c,183 :: 		unsigned char conectar()
;Fase1.c,185 :: 		if (conecta()==1)
	CALL        _conecta+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_conectar40
;Fase1.c,187 :: 		tempo=manda_AT_COMANDO("AT+CIPSEND", ">", "OK",5000);
	MOVLW       ?lstr47_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_coman+0 
	MOVLW       hi_addr(?lstr47_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_coman+1 
	MOVLW       ?lstr48_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_cap+0 
	MOVLW       hi_addr(?lstr48_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_cap+1 
	MOVLW       ?lstr49_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_cap1+0 
	MOVLW       hi_addr(?lstr49_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_cap1+1 
	MOVLW       136
	MOVWF       FARG_manda_AT_COMANDO_retardo+0 
	MOVLW       19
	MOVWF       FARG_manda_AT_COMANDO_retardo+1 
	CALL        _manda_AT_COMANDO+0, 0
	MOVF        R0, 0 
	MOVWF       _tempo+0 
;Fase1.c,188 :: 		Delay_ms(500);
	MOVLW       31
	MOVWF       R11, 0
	MOVLW       113
	MOVWF       R12, 0
	MOVLW       30
	MOVWF       R13, 0
L_conectar41:
	DECFSZ      R13, 1, 1
	BRA         L_conectar41
	DECFSZ      R12, 1, 1
	BRA         L_conectar41
	DECFSZ      R11, 1, 1
	BRA         L_conectar41
	NOP
;Fase1.c,189 :: 		memset(trama_tx,0,100);//LIMPIA LA TRAMA//
	MOVLW       _trama_tx+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_trama_tx+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       100
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;Fase1.c,191 :: 		sprintf(trama_tx,"{\"oxigeno\": %5.2f,\"temperatura\": %5.2f,\"ph\": %5.2f}",oxigeno,temperatura,ph);
	MOVLW       _trama_tx+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_trama_tx+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_50_Fase1+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_50_Fase1+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_50_Fase1+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _oxigeno+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _oxigeno+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	MOVF        _oxigeno+2, 0 
	MOVWF       FARG_sprintf_wh+7 
	MOVF        _oxigeno+3, 0 
	MOVWF       FARG_sprintf_wh+8 
	MOVF        _temperatura+0, 0 
	MOVWF       FARG_sprintf_wh+9 
	MOVF        _temperatura+1, 0 
	MOVWF       FARG_sprintf_wh+10 
	MOVF        _temperatura+2, 0 
	MOVWF       FARG_sprintf_wh+11 
	MOVF        _temperatura+3, 0 
	MOVWF       FARG_sprintf_wh+12 
	MOVF        _ph+0, 0 
	MOVWF       FARG_sprintf_wh+13 
	MOVF        _ph+1, 0 
	MOVWF       FARG_sprintf_wh+14 
	MOVF        _ph+2, 0 
	MOVWF       FARG_sprintf_wh+15 
	MOVF        _ph+3, 0 
	MOVWF       FARG_sprintf_wh+16 
	CALL        _sprintf+0, 0
;Fase1.c,192 :: 		largo=strlen(trama_tx);
	MOVLW       _trama_tx+0
	MOVWF       FARG_strlen_s+0 
	MOVLW       hi_addr(_trama_tx+0)
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVF        R0, 0 
	MOVWF       _largo+0 
;Fase1.c,194 :: 		sprintf(largo_str,"%u\n\n",largo);
	MOVLW       _largo_str+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_largo_str+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_51_Fase1+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_51_Fase1+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_51_Fase1+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        R0, 0 
	MOVWF       FARG_sprintf_wh+5 
	CALL        _sprintf+0, 0
;Fase1.c,195 :: 		Uart1_write_text_const("POST /api/v1.6/devices/proyectofase/?token=BBFF-mw5hBP6jnqrG1IdShi0wYieFf9WyFj HTTP/1.1\nHost: things.ubidots.com\nContent-Type: application/json\nContent-Length: ");
	MOVLW       ?lstr_52_Fase1+0
	MOVWF       FARG_Uart1_write_text_const_info+0 
	MOVLW       hi_addr(?lstr_52_Fase1+0)
	MOVWF       FARG_Uart1_write_text_const_info+1 
	MOVLW       higher_addr(?lstr_52_Fase1+0)
	MOVWF       FARG_Uart1_write_text_const_info+2 
	CALL        _Uart1_write_text_const+0, 0
;Fase1.c,196 :: 		UART1_Write_Text(largo_str);
	MOVLW       _largo_str+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_largo_str+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Fase1.c,197 :: 		Uart1_write_text(trama_tx);
	MOVLW       _trama_tx+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_trama_tx+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Fase1.c,199 :: 		Delay_ms(4000);
	MOVLW       244
	MOVWF       R11, 0
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       5
	MOVWF       R13, 0
L_conectar42:
	DECFSZ      R13, 1, 1
	BRA         L_conectar42
	DECFSZ      R12, 1, 1
	BRA         L_conectar42
	DECFSZ      R11, 1, 1
	BRA         L_conectar42
;Fase1.c,200 :: 		tempo=manda_AT_COMANDO("\x1A", "SEND OK", "ERROR",4000);//MENSAJE PARA VERIFICAR SI SE ENVIO//
	MOVLW       ?lstr53_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_coman+0 
	MOVLW       hi_addr(?lstr53_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_coman+1 
	MOVLW       ?lstr54_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_cap+0 
	MOVLW       hi_addr(?lstr54_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_cap+1 
	MOVLW       ?lstr55_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_cap1+0 
	MOVLW       hi_addr(?lstr55_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_cap1+1 
	MOVLW       160
	MOVWF       FARG_manda_AT_COMANDO_retardo+0 
	MOVLW       15
	MOVWF       FARG_manda_AT_COMANDO_retardo+1 
	CALL        _manda_AT_COMANDO+0, 0
	MOVF        R0, 0 
	MOVWF       _tempo+0 
;Fase1.c,201 :: 		Delay_ms(5000);
	MOVLW       2
	MOVWF       R10, 0
	MOVLW       49
	MOVWF       R11, 0
	MOVLW       98
	MOVWF       R12, 0
	MOVLW       69
	MOVWF       R13, 0
L_conectar43:
	DECFSZ      R13, 1, 1
	BRA         L_conectar43
	DECFSZ      R12, 1, 1
	BRA         L_conectar43
	DECFSZ      R11, 1, 1
	BRA         L_conectar43
	DECFSZ      R10, 1, 1
	BRA         L_conectar43
;Fase1.c,203 :: 		tempo=manda_AT_COMANDO("AT+CIPCLOSE", "CLOSE OK", "ERROR",4000);//CERRAR COMANDO
	MOVLW       ?lstr56_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_coman+0 
	MOVLW       hi_addr(?lstr56_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_coman+1 
	MOVLW       ?lstr57_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_cap+0 
	MOVLW       hi_addr(?lstr57_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_cap+1 
	MOVLW       ?lstr58_Fase1+0
	MOVWF       FARG_manda_AT_COMANDO_cap1+0 
	MOVLW       hi_addr(?lstr58_Fase1+0)
	MOVWF       FARG_manda_AT_COMANDO_cap1+1 
	MOVLW       160
	MOVWF       FARG_manda_AT_COMANDO_retardo+0 
	MOVLW       15
	MOVWF       FARG_manda_AT_COMANDO_retardo+1 
	CALL        _manda_AT_COMANDO+0, 0
	MOVF        R0, 0 
	MOVWF       _tempo+0 
;Fase1.c,204 :: 		Delay_ms(1000);
	MOVLW       61
	MOVWF       R11, 0
	MOVLW       225
	MOVWF       R12, 0
	MOVLW       63
	MOVWF       R13, 0
L_conectar44:
	DECFSZ      R13, 1, 1
	BRA         L_conectar44
	DECFSZ      R12, 1, 1
	BRA         L_conectar44
	DECFSZ      R11, 1, 1
	BRA         L_conectar44
	NOP
	NOP
;Fase1.c,207 :: 		sprintf(texto,"sw=%1d  pwm=%3d\r\n",suiche_ubi,pwm_ubi);
	MOVLW       _texto+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_texto+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_59_Fase1+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_59_Fase1+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_59_Fase1+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _suiche_ubi+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _suiche_ubi+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	MOVF        _pwm_ubi+0, 0 
	MOVWF       FARG_sprintf_wh+7 
	MOVF        _pwm_ubi+1, 0 
	MOVWF       FARG_sprintf_wh+8 
	CALL        _sprintf+0, 0
;Fase1.c,208 :: 		UART1_Write_Text(texto);
	MOVLW       _texto+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_texto+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Fase1.c,209 :: 		Delay_ms(1000);
	MOVLW       61
	MOVWF       R11, 0
	MOVLW       225
	MOVWF       R12, 0
	MOVLW       63
	MOVWF       R13, 0
L_conectar45:
	DECFSZ      R13, 1, 1
	BRA         L_conectar45
	DECFSZ      R12, 1, 1
	BRA         L_conectar45
	DECFSZ      R11, 1, 1
	BRA         L_conectar45
	NOP
	NOP
;Fase1.c,210 :: 		if (tempo!=1) return(2);
	MOVF        _tempo+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_conectar46
	MOVLW       2
	MOVWF       R0 
	GOTO        L_end_conectar
L_conectar46:
;Fase1.c,211 :: 		return(1);
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_conectar
;Fase1.c,212 :: 		}//SI SE CONECTO//
L_conectar40:
;Fase1.c,213 :: 		else return(0);
	CLRF        R0 
;Fase1.c,214 :: 		}//SI NO SE CONECTO//
L_end_conectar:
	RETURN      0
; end of _conectar

_ds18b20_read:

;Fase1.c,219 :: 		float ds18b20_read(char *puerto,char pin)
;Fase1.c,224 :: 		float signo=1.0;
	MOVLW       0
	MOVWF       ds18b20_read_signo_L0+0 
	MOVLW       0
	MOVWF       ds18b20_read_signo_L0+1 
	MOVLW       0
	MOVWF       ds18b20_read_signo_L0+2 
	MOVLW       127
	MOVWF       ds18b20_read_signo_L0+3 
;Fase1.c,226 :: 		Ow_Reset(puerto, pin);                         // Onewire reset signal
	MOVF        FARG_ds18b20_read_puerto+0, 0 
	MOVWF       FARG_Ow_Reset_port+0 
	MOVF        FARG_ds18b20_read_puerto+1, 0 
	MOVWF       FARG_Ow_Reset_port+1 
	MOVF        FARG_ds18b20_read_pin+0, 0 
	MOVWF       FARG_Ow_Reset_pin+0 
	CALL        _Ow_Reset+0, 0
;Fase1.c,227 :: 		Delay_ms(18);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       25
	MOVWF       R12, 0
	MOVLW       129
	MOVWF       R13, 0
L_ds18b20_read48:
	DECFSZ      R13, 1, 1
	BRA         L_ds18b20_read48
	DECFSZ      R12, 1, 1
	BRA         L_ds18b20_read48
	DECFSZ      R11, 1, 1
	BRA         L_ds18b20_read48
	NOP
	NOP
;Fase1.c,228 :: 		Ow_Write(puerto, pin, 0xCC);                   // dirrecciona todos sensores
	MOVF        FARG_ds18b20_read_puerto+0, 0 
	MOVWF       FARG_Ow_Write_port+0 
	MOVF        FARG_ds18b20_read_puerto+1, 0 
	MOVWF       FARG_Ow_Write_port+1 
	MOVF        FARG_ds18b20_read_pin+0, 0 
	MOVWF       FARG_Ow_Write_pin+0 
	MOVLW       204
	MOVWF       FARG_Ow_Write_data_+0 
	CALL        _Ow_Write+0, 0
;Fase1.c,229 :: 		Delay_ms(1);
	MOVLW       16
	MOVWF       R12, 0
	MOVLW       148
	MOVWF       R13, 0
L_ds18b20_read49:
	DECFSZ      R13, 1, 1
	BRA         L_ds18b20_read49
	DECFSZ      R12, 1, 1
	BRA         L_ds18b20_read49
	NOP
;Fase1.c,230 :: 		Ow_Write(puerto, pin, 0x44);                   //iniica conversion
	MOVF        FARG_ds18b20_read_puerto+0, 0 
	MOVWF       FARG_Ow_Write_port+0 
	MOVF        FARG_ds18b20_read_puerto+1, 0 
	MOVWF       FARG_Ow_Write_port+1 
	MOVF        FARG_ds18b20_read_pin+0, 0 
	MOVWF       FARG_Ow_Write_pin+0 
	MOVLW       68
	MOVWF       FARG_Ow_Write_data_+0 
	CALL        _Ow_Write+0, 0
;Fase1.c,231 :: 		Delay_ms(150);
	MOVLW       10
	MOVWF       R11, 0
	MOVLW       34
	MOVWF       R12, 0
	MOVLW       161
	MOVWF       R13, 0
L_ds18b20_read50:
	DECFSZ      R13, 1, 1
	BRA         L_ds18b20_read50
	DECFSZ      R12, 1, 1
	BRA         L_ds18b20_read50
	DECFSZ      R11, 1, 1
	BRA         L_ds18b20_read50
;Fase1.c,232 :: 		Ow_Reset(puerto, pin);
	MOVF        FARG_ds18b20_read_puerto+0, 0 
	MOVWF       FARG_Ow_Reset_port+0 
	MOVF        FARG_ds18b20_read_puerto+1, 0 
	MOVWF       FARG_Ow_Reset_port+1 
	MOVF        FARG_ds18b20_read_pin+0, 0 
	MOVWF       FARG_Ow_Reset_pin+0 
	CALL        _Ow_Reset+0, 0
;Fase1.c,233 :: 		Delay_ms(18);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       25
	MOVWF       R12, 0
	MOVLW       129
	MOVWF       R13, 0
L_ds18b20_read51:
	DECFSZ      R13, 1, 1
	BRA         L_ds18b20_read51
	DECFSZ      R12, 1, 1
	BRA         L_ds18b20_read51
	DECFSZ      R11, 1, 1
	BRA         L_ds18b20_read51
	NOP
	NOP
;Fase1.c,234 :: 		Ow_Write(puerto, pin, 0xCC);
	MOVF        FARG_ds18b20_read_puerto+0, 0 
	MOVWF       FARG_Ow_Write_port+0 
	MOVF        FARG_ds18b20_read_puerto+1, 0 
	MOVWF       FARG_Ow_Write_port+1 
	MOVF        FARG_ds18b20_read_pin+0, 0 
	MOVWF       FARG_Ow_Write_pin+0 
	MOVLW       204
	MOVWF       FARG_Ow_Write_data_+0 
	CALL        _Ow_Write+0, 0
;Fase1.c,235 :: 		Delay_ms(1);
	MOVLW       16
	MOVWF       R12, 0
	MOVLW       148
	MOVWF       R13, 0
L_ds18b20_read52:
	DECFSZ      R13, 1, 1
	BRA         L_ds18b20_read52
	DECFSZ      R12, 1, 1
	BRA         L_ds18b20_read52
	NOP
;Fase1.c,236 :: 		Ow_Write(puerto, pin, 0xBE);
	MOVF        FARG_ds18b20_read_puerto+0, 0 
	MOVWF       FARG_Ow_Write_port+0 
	MOVF        FARG_ds18b20_read_puerto+1, 0 
	MOVWF       FARG_Ow_Write_port+1 
	MOVF        FARG_ds18b20_read_pin+0, 0 
	MOVWF       FARG_Ow_Write_pin+0 
	MOVLW       190
	MOVWF       FARG_Ow_Write_data_+0 
	CALL        _Ow_Write+0, 0
;Fase1.c,237 :: 		Delay_ms(1);
	MOVLW       16
	MOVWF       R12, 0
	MOVLW       148
	MOVWF       R13, 0
L_ds18b20_read53:
	DECFSZ      R13, 1, 1
	BRA         L_ds18b20_read53
	DECFSZ      R12, 1, 1
	BRA         L_ds18b20_read53
	NOP
;Fase1.c,238 :: 		t1_ =  Ow_Read(puerto, pin);        //lee parte baja
	MOVF        FARG_ds18b20_read_puerto+0, 0 
	MOVWF       FARG_Ow_Read_port+0 
	MOVF        FARG_ds18b20_read_puerto+1, 0 
	MOVWF       FARG_Ow_Read_port+1 
	MOVF        FARG_ds18b20_read_pin+0, 0 
	MOVWF       FARG_Ow_Read_pin+0 
	CALL        _Ow_Read+0, 0
	MOVF        R0, 0 
	MOVWF       ds18b20_read_t1__L0+0 
;Fase1.c,239 :: 		t2_ =  Ow_Read(puerto, pin);       //lee parte alta
	MOVF        FARG_ds18b20_read_puerto+0, 0 
	MOVWF       FARG_Ow_Read_port+0 
	MOVF        FARG_ds18b20_read_puerto+1, 0 
	MOVWF       FARG_Ow_Read_port+1 
	MOVF        FARG_ds18b20_read_pin+0, 0 
	MOVWF       FARG_Ow_Read_pin+0 
	CALL        _Ow_Read+0, 0
	MOVF        R0, 0 
	MOVWF       ds18b20_read_t2__L0+0 
;Fase1.c,241 :: 		temp_=( (unsigned int)t2_<<8) || t1_;
	MOVF        R0, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	MOVF        R3, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_ds18b20_read55
	MOVF        ds18b20_read_t1__L0+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_ds18b20_read55
	CLRF        R0 
	GOTO        L_ds18b20_read54
L_ds18b20_read55:
	MOVLW       1
	MOVWF       R0 
L_ds18b20_read54:
	MOVF        R0, 0 
	MOVWF       ds18b20_read_temp__L0+0 
	MOVLW       0
	MOVWF       ds18b20_read_temp__L0+1 
;Fase1.c,243 :: 		if ( t2_ & 0x80)
	BTFSS       ds18b20_read_t2__L0+0, 7 
	GOTO        L_ds18b20_read56
;Fase1.c,245 :: 		temp_=~temp_+1;
	COMF        ds18b20_read_temp__L0+0, 1 
	COMF        ds18b20_read_temp__L0+1, 1 
	INFSNZ      ds18b20_read_temp__L0+0, 1 
	INCF        ds18b20_read_temp__L0+1, 1 
;Fase1.c,246 :: 		signo=-1.0;
	MOVLW       0
	MOVWF       ds18b20_read_signo_L0+0 
	MOVLW       0
	MOVWF       ds18b20_read_signo_L0+1 
	MOVLW       128
	MOVWF       ds18b20_read_signo_L0+2 
	MOVLW       127
	MOVWF       ds18b20_read_signo_L0+3 
;Fase1.c,247 :: 		}
L_ds18b20_read56:
;Fase1.c,248 :: 		temp_=temp_>>4; //quita la parte decimal
	RRCF        ds18b20_read_temp__L0+1, 1 
	RRCF        ds18b20_read_temp__L0+0, 1 
	BCF         ds18b20_read_temp__L0+1, 7 
	RRCF        ds18b20_read_temp__L0+1, 1 
	RRCF        ds18b20_read_temp__L0+0, 1 
	BCF         ds18b20_read_temp__L0+1, 7 
	RRCF        ds18b20_read_temp__L0+1, 1 
	RRCF        ds18b20_read_temp__L0+0, 1 
	BCF         ds18b20_read_temp__L0+1, 7 
	RRCF        ds18b20_read_temp__L0+1, 1 
	RRCF        ds18b20_read_temp__L0+0, 1 
	BCF         ds18b20_read_temp__L0+1, 7 
;Fase1.c,250 :: 		td__=t1_ & 0x0f;    //saca parte decima
	MOVLW       15
	ANDWF       ds18b20_read_t1__L0+0, 0 
	MOVWF       ds18b20_read_td___L0+0 
;Fase1.c,252 :: 		tempo__=0;
	CLRF        ds18b20_read_tempo___L0+0 
	CLRF        ds18b20_read_tempo___L0+1 
	CLRF        ds18b20_read_tempo___L0+2 
	CLRF        ds18b20_read_tempo___L0+3 
;Fase1.c,253 :: 		if (td__.b3==1)tempo__=tempo__+0.5;
	BTFSS       ds18b20_read_td___L0+0, 3 
	GOTO        L_ds18b20_read57
	MOVF        ds18b20_read_tempo___L0+0, 0 
	MOVWF       R0 
	MOVF        ds18b20_read_tempo___L0+1, 0 
	MOVWF       R1 
	MOVF        ds18b20_read_tempo___L0+2, 0 
	MOVWF       R2 
	MOVF        ds18b20_read_tempo___L0+3, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       126
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       ds18b20_read_tempo___L0+0 
	MOVF        R1, 0 
	MOVWF       ds18b20_read_tempo___L0+1 
	MOVF        R2, 0 
	MOVWF       ds18b20_read_tempo___L0+2 
	MOVF        R3, 0 
	MOVWF       ds18b20_read_tempo___L0+3 
L_ds18b20_read57:
;Fase1.c,254 :: 		if (td__.b2==1) tempo__=tempo__+0.25;
	BTFSS       ds18b20_read_td___L0+0, 2 
	GOTO        L_ds18b20_read58
	MOVF        ds18b20_read_tempo___L0+0, 0 
	MOVWF       R0 
	MOVF        ds18b20_read_tempo___L0+1, 0 
	MOVWF       R1 
	MOVF        ds18b20_read_tempo___L0+2, 0 
	MOVWF       R2 
	MOVF        ds18b20_read_tempo___L0+3, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       125
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       ds18b20_read_tempo___L0+0 
	MOVF        R1, 0 
	MOVWF       ds18b20_read_tempo___L0+1 
	MOVF        R2, 0 
	MOVWF       ds18b20_read_tempo___L0+2 
	MOVF        R3, 0 
	MOVWF       ds18b20_read_tempo___L0+3 
L_ds18b20_read58:
;Fase1.c,255 :: 		if (td__.b1==1) tempo__=tempo__+0.125;
	BTFSS       ds18b20_read_td___L0+0, 1 
	GOTO        L_ds18b20_read59
	MOVF        ds18b20_read_tempo___L0+0, 0 
	MOVWF       R0 
	MOVF        ds18b20_read_tempo___L0+1, 0 
	MOVWF       R1 
	MOVF        ds18b20_read_tempo___L0+2, 0 
	MOVWF       R2 
	MOVF        ds18b20_read_tempo___L0+3, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       124
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       ds18b20_read_tempo___L0+0 
	MOVF        R1, 0 
	MOVWF       ds18b20_read_tempo___L0+1 
	MOVF        R2, 0 
	MOVWF       ds18b20_read_tempo___L0+2 
	MOVF        R3, 0 
	MOVWF       ds18b20_read_tempo___L0+3 
L_ds18b20_read59:
;Fase1.c,256 :: 		if (td__.b0==1) tempo__=tempo__+0.0625;
	BTFSS       ds18b20_read_td___L0+0, 0 
	GOTO        L_ds18b20_read60
	MOVF        ds18b20_read_tempo___L0+0, 0 
	MOVWF       R0 
	MOVF        ds18b20_read_tempo___L0+1, 0 
	MOVWF       R1 
	MOVF        ds18b20_read_tempo___L0+2, 0 
	MOVWF       R2 
	MOVF        ds18b20_read_tempo___L0+3, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       123
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       ds18b20_read_tempo___L0+0 
	MOVF        R1, 0 
	MOVWF       ds18b20_read_tempo___L0+1 
	MOVF        R2, 0 
	MOVWF       ds18b20_read_tempo___L0+2 
	MOVF        R3, 0 
	MOVWF       ds18b20_read_tempo___L0+3 
L_ds18b20_read60:
;Fase1.c,257 :: 		if (signo<0) tempo__=-tempo__;
	CLRF        R4 
	CLRF        R5 
	CLRF        R6 
	CLRF        R7 
	MOVF        ds18b20_read_signo_L0+0, 0 
	MOVWF       R0 
	MOVF        ds18b20_read_signo_L0+1, 0 
	MOVWF       R1 
	MOVF        ds18b20_read_signo_L0+2, 0 
	MOVWF       R2 
	MOVF        ds18b20_read_signo_L0+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_ds18b20_read61
	BTG         ds18b20_read_tempo___L0+2, 7 
L_ds18b20_read61:
;Fase1.c,258 :: 		sensor_temp_=(temp_*signo)+tempo__;  //calcula vlor final
	MOVF        ds18b20_read_temp__L0+0, 0 
	MOVWF       R0 
	MOVF        ds18b20_read_temp__L0+1, 0 
	MOVWF       R1 
	CALL        _word2double+0, 0
	MOVF        ds18b20_read_signo_L0+0, 0 
	MOVWF       R4 
	MOVF        ds18b20_read_signo_L0+1, 0 
	MOVWF       R5 
	MOVF        ds18b20_read_signo_L0+2, 0 
	MOVWF       R6 
	MOVF        ds18b20_read_signo_L0+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        ds18b20_read_tempo___L0+0, 0 
	MOVWF       R4 
	MOVF        ds18b20_read_tempo___L0+1, 0 
	MOVWF       R5 
	MOVF        ds18b20_read_tempo___L0+2, 0 
	MOVWF       R6 
	MOVF        ds18b20_read_tempo___L0+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
;Fase1.c,260 :: 		return (sensor_temp_);
;Fase1.c,262 :: 		}
L_end_ds18b20_read:
	RETURN      0
; end of _ds18b20_read

_main:

;Fase1.c,264 :: 		void main()
;Fase1.c,266 :: 		ADCON1=0B1101;//////////TODO DIGITAL EXCEPTO EL EL PUERTO AN0 Y AN1/////////////
	MOVLW       13
	MOVWF       ADCON1+0 
;Fase1.c,267 :: 		TRISA.B2=1;
	BSF         TRISA+0, 2 
;Fase1.c,268 :: 		TRISB=0;
	CLRF        TRISB+0 
;Fase1.c,269 :: 		TRISC=0;
	CLRF        TRISC+0 
;Fase1.c,270 :: 		TRISC7_bit=1;///////////////////////////RX//////////////////////////////////////
	BSF         TRISC7_bit+0, BitPos(TRISC7_bit+0) 
;Fase1.c,272 :: 		UART1_Init(9600);/////////////VELOCIDAD DEL SIM800L/////////////////////////////
	BSF         BAUDCON+0, 3, 0
	MOVLW       4
	MOVWF       SPBRGH+0 
	MOVLW       225
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;Fase1.c,273 :: 		pin_on=0;
	BCF         LATB0_bit+0, BitPos(LATB0_bit+0) 
;Fase1.c,275 :: 		INTCON=0b01000000;
	MOVLW       64
	MOVWF       INTCON+0 
;Fase1.c,276 :: 		Soft_UART_Init(&PORTB, 2, 1, 9600, 0);//INICIALIZA UN PUERTO POR SOFTWARE//
	MOVLW       PORTB+0
	MOVWF       FARG_Soft_UART_Init_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Soft_UART_Init_port+1 
	MOVLW       2
	MOVWF       FARG_Soft_UART_Init_rx_pin+0 
	MOVLW       1
	MOVWF       FARG_Soft_UART_Init_tx_pin+0 
	MOVLW       128
	MOVWF       FARG_Soft_UART_Init_baud_rate+0 
	MOVLW       37
	MOVWF       FARG_Soft_UART_Init_baud_rate+1 
	MOVLW       0
	MOVWF       FARG_Soft_UART_Init_baud_rate+2 
	MOVWF       FARG_Soft_UART_Init_baud_rate+3 
	CLRF        FARG_Soft_UART_Init_inverted+0 
	CALL        _Soft_UART_Init+0, 0
;Fase1.c,279 :: 		RCIF_bit=0;
	BCF         RCIF_bit+0, BitPos(RCIF_bit+0) 
;Fase1.c,280 :: 		RCIE_bit=0;
	BCF         RCIE_bit+0, BitPos(RCIE_bit+0) 
;Fase1.c,282 :: 		LATB=0;
	CLRF        LATB+0 
;Fase1.c,286 :: 		T0CON=0;//LIMPIA REGISTRO DEL TIMER CERO
	CLRF        T0CON+0 
;Fase1.c,287 :: 		TMR0ON_bit=0; // lo mantiene apagado
	BCF         TMR0ON_bit+0, BitPos(TMR0ON_bit+0) 
;Fase1.c,288 :: 		TMR0H=72;
	MOVLW       72
	MOVWF       TMR0H+0 
;Fase1.c,289 :: 		TMR0L=228;
	MOVLW       228
	MOVWF       TMR0L+0 
;Fase1.c,291 :: 		T0PS2_bit=1;
	BSF         T0PS2_bit+0, BitPos(T0PS2_bit+0) 
;Fase1.c,292 :: 		T0PS1_bit=1;
	BSF         T0PS1_bit+0, BitPos(T0PS1_bit+0) 
;Fase1.c,293 :: 		T0PS0_bit=1;
	BSF         T0PS0_bit+0, BitPos(T0PS0_bit+0) 
;Fase1.c,295 :: 		TMR0IF_bit=0;
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;Fase1.c,296 :: 		TMR0IE_bit=0;// deshabilita la interrpcion
	BCF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;Fase1.c,299 :: 		GIE_bit=1;// HABILITA INTERPCIONES GLOBALES
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;Fase1.c,300 :: 		RCEN_bit=0;
	BCF         RCEN_bit+0, BitPos(RCEN_bit+0) 
;Fase1.c,301 :: 		RCEN_bit=1;
	BSF         RCEN_bit+0, BitPos(RCEN_bit+0) 
;Fase1.c,302 :: 		while ((prendio()==0) || (cuenta_on>=10)) cuenta_on++;  // intenta prender el modulo usando 10 intentos
L_main62:
	CALL        _prendio+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__main70
	MOVLW       10
	SUBWF       _cuenta_on+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L__main70
	GOTO        L_main63
L__main70:
	INCF        _cuenta_on+0, 1 
	GOTO        L_main62
L_main63:
;Fase1.c,303 :: 		config_gprs();
	CALL        _config_gprs+0, 0
;Fase1.c,304 :: 		led_ubidot=1;
	MOVLW       1
	MOVWF       _led_ubidot+0 
;Fase1.c,305 :: 		temperatura=ds18b20_read(&porta,2);
	MOVLW       PORTA+0
	MOVWF       FARG_ds18b20_read_puerto+0 
	MOVLW       hi_addr(PORTA+0)
	MOVWF       FARG_ds18b20_read_puerto+1 
	MOVLW       2
	MOVWF       FARG_ds18b20_read_pin+0 
	CALL        _ds18b20_read+0, 0
	MOVF        R0, 0 
	MOVWF       _temperatura+0 
	MOVF        R1, 0 
	MOVWF       _temperatura+1 
	MOVF        R2, 0 
	MOVWF       _temperatura+2 
	MOVF        R3, 0 
	MOVWF       _temperatura+3 
;Fase1.c,306 :: 		voltage = (5 / 1024.0 * ADC_Read(1))-0.4;
	MOVLW       1
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	CALL        _word2double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       119
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       205
	MOVWF       R4 
	MOVLW       204
	MOVWF       R5 
	MOVLW       76
	MOVWF       R6 
	MOVLW       125
	MOVWF       R7 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _voltage+0 
	MOVF        R1, 0 
	MOVWF       _voltage+1 
	MOVF        R2, 0 
	MOVWF       _voltage+2 
	MOVF        R3, 0 
	MOVWF       _voltage+3 
;Fase1.c,307 :: 		ph = -5.70 *voltage + 21.34;
	MOVLW       102
	MOVWF       R4 
	MOVLW       102
	MOVWF       R5 
	MOVLW       182
	MOVWF       R6 
	MOVLW       129
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       82
	MOVWF       R4 
	MOVLW       184
	MOVWF       R5 
	MOVLW       42
	MOVWF       R6 
	MOVLW       131
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _ph+0 
	MOVF        R1, 0 
	MOVWF       _ph+1 
	MOVF        R2, 0 
	MOVWF       _ph+2 
	MOVF        R3, 0 
	MOVWF       _ph+3 
;Fase1.c,310 :: 		while (1)
L_main66:
;Fase1.c,312 :: 		temperatura=ds18b20_read(&porta,2);
	MOVLW       PORTA+0
	MOVWF       FARG_ds18b20_read_puerto+0 
	MOVLW       hi_addr(PORTA+0)
	MOVWF       FARG_ds18b20_read_puerto+1 
	MOVLW       2
	MOVWF       FARG_ds18b20_read_pin+0 
	CALL        _ds18b20_read+0, 0
	MOVF        R0, 0 
	MOVWF       _temperatura+0 
	MOVF        R1, 0 
	MOVWF       _temperatura+1 
	MOVF        R2, 0 
	MOVWF       _temperatura+2 
	MOVF        R3, 0 
	MOVWF       _temperatura+3 
;Fase1.c,313 :: 		tempoxygen= temperatura;
	CALL        _double2int+0, 0
	MOVF        R0, 0 
	MOVWF       _tempoxygen+0 
	MOVF        R1, 0 
	MOVWF       _tempoxygen+1 
;Fase1.c,314 :: 		OxygenoDO=ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	CALL        _word2double+0, 0
	MOVF        R0, 0 
	MOVWF       _OxygenoDO+0 
	MOVF        R1, 0 
	MOVWF       _OxygenoDO+1 
	MOVF        R2, 0 
	MOVWF       _OxygenoDO+2 
	MOVF        R3, 0 
	MOVWF       _OxygenoDO+3 
;Fase1.c,315 :: 		ADC_VoltageOxygen = 5000*OxygenoDO/1024;
	MOVLW       0
	MOVWF       R4 
	MOVLW       64
	MOVWF       R5 
	MOVLW       28
	MOVWF       R6 
	MOVLW       139
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       137
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	CALL        _double2longint+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__main+0 
	MOVF        R1, 0 
	MOVWF       FLOC__main+1 
	MOVF        R2, 0 
	MOVWF       FLOC__main+2 
	MOVF        R3, 0 
	MOVWF       FLOC__main+3 
	MOVF        FLOC__main+0, 0 
	MOVWF       _ADC_VoltageOxygen+0 
	MOVF        FLOC__main+1, 0 
	MOVWF       _ADC_VoltageOxygen+1 
	MOVF        FLOC__main+2, 0 
	MOVWF       _ADC_VoltageOxygen+2 
	MOVF        FLOC__main+3, 0 
	MOVWF       _ADC_VoltageOxygen+3 
;Fase1.c,316 :: 		CAL_T=tempoxygen;
	MOVF        _tempoxygen+0, 0 
	MOVWF       _CAL_T+0 
	MOVF        _tempoxygen+1, 0 
	MOVWF       _CAL_T+1 
;Fase1.c,317 :: 		V_saturation = ((CAL_V + (35 * tempoxygen)) - (CAL_T * 35));
	MOVLW       35
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        _tempoxygen+0, 0 
	MOVWF       R4 
	MOVF        _tempoxygen+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       _CAL_V+0, 0 
	MOVWF       _V_saturation+0 
	MOVF        R1, 0 
	ADDWFC      _CAL_V+1, 0 
	MOVWF       _V_saturation+1 
	MOVLW       0
	BTFSC       _V_saturation+1, 7 
	MOVLW       255
	MOVWF       _V_saturation+2 
	MOVWF       _V_saturation+3 
	MOVF        R0, 0 
	SUBWF       _V_saturation+0, 1 
	MOVF        R1, 0 
	SUBWFB      _V_saturation+1, 1 
	MOVLW       0
	BTFSC       _V_saturation+1, 7 
	MOVLW       255
	MOVWF       _V_saturation+2 
	MOVWF       _V_saturation+3 
;Fase1.c,318 :: 		oxigeno=((ADC_VoltageOxygen * (DO_Table[tempoxygen]))/V_saturation)/1000;
	MOVF        _tempoxygen+0, 0 
	MOVWF       R0 
	MOVF        _tempoxygen+1, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       _tempoxygen+1, 7 
	MOVLW       255
	MOVWF       R2 
	MOVWF       R3 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	MOVLW       _DO_Table+0
	ADDWF       R0, 0 
	MOVWF       TBLPTR+0 
	MOVLW       hi_addr(_DO_Table+0)
	ADDWFC      R1, 0 
	MOVWF       TBLPTR+1 
	MOVLW       higher_addr(_DO_Table+0)
	ADDWFC      R2, 0 
	MOVWF       TBLPTR+2 
	TBLRD*+
	MOVFF       TABLAT+0, R0
	TBLRD*+
	MOVFF       TABLAT+0, R1
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	MOVWF       R2 
	MOVWF       R3 
	MOVF        FLOC__main+0, 0 
	MOVWF       R4 
	MOVF        FLOC__main+1, 0 
	MOVWF       R5 
	MOVF        FLOC__main+2, 0 
	MOVWF       R6 
	MOVF        FLOC__main+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_U+0, 0
	MOVF        _V_saturation+0, 0 
	MOVWF       R4 
	MOVF        _V_saturation+1, 0 
	MOVWF       R5 
	MOVF        _V_saturation+2, 0 
	MOVWF       R6 
	MOVF        _V_saturation+3, 0 
	MOVWF       R7 
	CALL        _Div_32x32_S+0, 0
	MOVLW       232
	MOVWF       R4 
	MOVLW       3
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Div_32x32_S+0, 0
	CALL        _longint2double+0, 0
	MOVF        R0, 0 
	MOVWF       _oxigeno+0 
	MOVF        R1, 0 
	MOVWF       _oxigeno+1 
	MOVF        R2, 0 
	MOVWF       _oxigeno+2 
	MOVF        R3, 0 
	MOVWF       _oxigeno+3 
;Fase1.c,320 :: 		voltage = (5 / 1024.0 * ADC_Read(1))-0.4;
	MOVLW       1
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	CALL        _word2double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       119
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       205
	MOVWF       R4 
	MOVLW       204
	MOVWF       R5 
	MOVLW       76
	MOVWF       R6 
	MOVLW       125
	MOVWF       R7 
	CALL        _Sub_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _voltage+0 
	MOVF        R1, 0 
	MOVWF       _voltage+1 
	MOVF        R2, 0 
	MOVWF       _voltage+2 
	MOVF        R3, 0 
	MOVWF       _voltage+3 
;Fase1.c,321 :: 		ph = -5.70 *voltage + 21.34;
	MOVLW       102
	MOVWF       R4 
	MOVLW       102
	MOVWF       R5 
	MOVLW       182
	MOVWF       R6 
	MOVLW       129
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       82
	MOVWF       R4 
	MOVLW       184
	MOVWF       R5 
	MOVLW       42
	MOVWF       R6 
	MOVLW       131
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _ph+0 
	MOVF        R1, 0 
	MOVWF       _ph+1 
	MOVF        R2, 0 
	MOVWF       _ph+2 
	MOVF        R3, 0 
	MOVWF       _ph+3 
;Fase1.c,323 :: 		conectar();
	CALL        _conectar+0, 0
;Fase1.c,324 :: 		Delay_ms(5000);
	MOVLW       2
	MOVWF       R10, 0
	MOVLW       49
	MOVWF       R11, 0
	MOVLW       98
	MOVWF       R12, 0
	MOVLW       69
	MOVWF       R13, 0
L_main68:
	DECFSZ      R13, 1, 1
	BRA         L_main68
	DECFSZ      R12, 1, 1
	BRA         L_main68
	DECFSZ      R11, 1, 1
	BRA         L_main68
	DECFSZ      R10, 1, 1
	BRA         L_main68
;Fase1.c,326 :: 		}
	GOTO        L_main66
;Fase1.c,329 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

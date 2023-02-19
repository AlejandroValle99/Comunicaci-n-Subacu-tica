
_ds18b20_read:

;Pruebas_sensor_temperatura.c,23 :: 		float ds18b20_read(char *puerto,char pin)
;Pruebas_sensor_temperatura.c,28 :: 		float signo=1.0;
	MOVLW       0
	MOVWF       ds18b20_read_signo_L0+0 
	MOVLW       0
	MOVWF       ds18b20_read_signo_L0+1 
	MOVLW       0
	MOVWF       ds18b20_read_signo_L0+2 
	MOVLW       127
	MOVWF       ds18b20_read_signo_L0+3 
;Pruebas_sensor_temperatura.c,33 :: 		Ow_Reset(puerto, pin);                         // Onewire reset signal
	MOVF        FARG_ds18b20_read_puerto+0, 0 
	MOVWF       FARG_Ow_Reset_port+0 
	MOVF        FARG_ds18b20_read_puerto+1, 0 
	MOVWF       FARG_Ow_Reset_port+1 
	MOVF        FARG_ds18b20_read_pin+0, 0 
	MOVWF       FARG_Ow_Reset_pin+0 
	CALL        _Ow_Reset+0, 0
;Pruebas_sensor_temperatura.c,34 :: 		Delay_ms(18);
	MOVLW       117
	MOVWF       R12, 0
	MOVLW       225
	MOVWF       R13, 0
L_ds18b20_read0:
	DECFSZ      R13, 1, 1
	BRA         L_ds18b20_read0
	DECFSZ      R12, 1, 1
	BRA         L_ds18b20_read0
;Pruebas_sensor_temperatura.c,35 :: 		Ow_Write(puerto, pin, 0xCC);                   // dirrecciona todos sensores
	MOVF        FARG_ds18b20_read_puerto+0, 0 
	MOVWF       FARG_Ow_Write_port+0 
	MOVF        FARG_ds18b20_read_puerto+1, 0 
	MOVWF       FARG_Ow_Write_port+1 
	MOVF        FARG_ds18b20_read_pin+0, 0 
	MOVWF       FARG_Ow_Write_pin+0 
	MOVLW       204
	MOVWF       FARG_Ow_Write_data_+0 
	CALL        _Ow_Write+0, 0
;Pruebas_sensor_temperatura.c,36 :: 		Delay_ms(1);
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       125
	MOVWF       R13, 0
L_ds18b20_read1:
	DECFSZ      R13, 1, 1
	BRA         L_ds18b20_read1
	DECFSZ      R12, 1, 1
	BRA         L_ds18b20_read1
;Pruebas_sensor_temperatura.c,37 :: 		Ow_Write(puerto, pin, 0x44);                   //iniica conversion
	MOVF        FARG_ds18b20_read_puerto+0, 0 
	MOVWF       FARG_Ow_Write_port+0 
	MOVF        FARG_ds18b20_read_puerto+1, 0 
	MOVWF       FARG_Ow_Write_port+1 
	MOVF        FARG_ds18b20_read_pin+0, 0 
	MOVWF       FARG_Ow_Write_pin+0 
	MOVLW       68
	MOVWF       FARG_Ow_Write_data_+0 
	CALL        _Ow_Write+0, 0
;Pruebas_sensor_temperatura.c,38 :: 		Delay_ms(150);
	MOVLW       4
	MOVWF       R11, 0
	MOVLW       207
	MOVWF       R12, 0
	MOVLW       1
	MOVWF       R13, 0
L_ds18b20_read2:
	DECFSZ      R13, 1, 1
	BRA         L_ds18b20_read2
	DECFSZ      R12, 1, 1
	BRA         L_ds18b20_read2
	DECFSZ      R11, 1, 1
	BRA         L_ds18b20_read2
	NOP
	NOP
;Pruebas_sensor_temperatura.c,40 :: 		Ow_Reset(puerto, pin);
	MOVF        FARG_ds18b20_read_puerto+0, 0 
	MOVWF       FARG_Ow_Reset_port+0 
	MOVF        FARG_ds18b20_read_puerto+1, 0 
	MOVWF       FARG_Ow_Reset_port+1 
	MOVF        FARG_ds18b20_read_pin+0, 0 
	MOVWF       FARG_Ow_Reset_pin+0 
	CALL        _Ow_Reset+0, 0
;Pruebas_sensor_temperatura.c,41 :: 		Delay_ms(18);
	MOVLW       117
	MOVWF       R12, 0
	MOVLW       225
	MOVWF       R13, 0
L_ds18b20_read3:
	DECFSZ      R13, 1, 1
	BRA         L_ds18b20_read3
	DECFSZ      R12, 1, 1
	BRA         L_ds18b20_read3
;Pruebas_sensor_temperatura.c,42 :: 		Ow_Write(puerto, pin, 0xCC);
	MOVF        FARG_ds18b20_read_puerto+0, 0 
	MOVWF       FARG_Ow_Write_port+0 
	MOVF        FARG_ds18b20_read_puerto+1, 0 
	MOVWF       FARG_Ow_Write_port+1 
	MOVF        FARG_ds18b20_read_pin+0, 0 
	MOVWF       FARG_Ow_Write_pin+0 
	MOVLW       204
	MOVWF       FARG_Ow_Write_data_+0 
	CALL        _Ow_Write+0, 0
;Pruebas_sensor_temperatura.c,43 :: 		Delay_ms(1);
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       125
	MOVWF       R13, 0
L_ds18b20_read4:
	DECFSZ      R13, 1, 1
	BRA         L_ds18b20_read4
	DECFSZ      R12, 1, 1
	BRA         L_ds18b20_read4
;Pruebas_sensor_temperatura.c,44 :: 		Ow_Write(puerto, pin, 0xBE);
	MOVF        FARG_ds18b20_read_puerto+0, 0 
	MOVWF       FARG_Ow_Write_port+0 
	MOVF        FARG_ds18b20_read_puerto+1, 0 
	MOVWF       FARG_Ow_Write_port+1 
	MOVF        FARG_ds18b20_read_pin+0, 0 
	MOVWF       FARG_Ow_Write_pin+0 
	MOVLW       190
	MOVWF       FARG_Ow_Write_data_+0 
	CALL        _Ow_Write+0, 0
;Pruebas_sensor_temperatura.c,45 :: 		Delay_ms(1);
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       125
	MOVWF       R13, 0
L_ds18b20_read5:
	DECFSZ      R13, 1, 1
	BRA         L_ds18b20_read5
	DECFSZ      R12, 1, 1
	BRA         L_ds18b20_read5
;Pruebas_sensor_temperatura.c,46 :: 		t1_ =  Ow_Read(puerto, pin);        //lee parte baja
	MOVF        FARG_ds18b20_read_puerto+0, 0 
	MOVWF       FARG_Ow_Read_port+0 
	MOVF        FARG_ds18b20_read_puerto+1, 0 
	MOVWF       FARG_Ow_Read_port+1 
	MOVF        FARG_ds18b20_read_pin+0, 0 
	MOVWF       FARG_Ow_Read_pin+0 
	CALL        _Ow_Read+0, 0
	MOVF        R0, 0 
	MOVWF       ds18b20_read_t1__L0+0 
;Pruebas_sensor_temperatura.c,47 :: 		t2_ =  Ow_Read(puerto, pin);       //lee parte alta
	MOVF        FARG_ds18b20_read_puerto+0, 0 
	MOVWF       FARG_Ow_Read_port+0 
	MOVF        FARG_ds18b20_read_puerto+1, 0 
	MOVWF       FARG_Ow_Read_port+1 
	MOVF        FARG_ds18b20_read_pin+0, 0 
	MOVWF       FARG_Ow_Read_pin+0 
	CALL        _Ow_Read+0, 0
;Pruebas_sensor_temperatura.c,49 :: 		temp_=( (unsigned int)t2_<<8) | t1_;
	MOVF        R0, 0 
	MOVWF       ds18b20_read_temp__L0+0 
	MOVLW       0
	MOVWF       ds18b20_read_temp__L0+1 
	MOVF        ds18b20_read_temp__L0+0, 0 
	MOVWF       ds18b20_read_temp__L0+1 
	CLRF        ds18b20_read_temp__L0+0 
	MOVF        ds18b20_read_t1__L0+0, 0 
	IORWF       ds18b20_read_temp__L0+0, 1 
	MOVLW       0
	IORWF       ds18b20_read_temp__L0+1, 1 
;Pruebas_sensor_temperatura.c,52 :: 		if ( t2_ & 0x80)
	BTFSS       R0, 7 
	GOTO        L_ds18b20_read6
;Pruebas_sensor_temperatura.c,54 :: 		temp_=~temp_+1;
	COMF        ds18b20_read_temp__L0+0, 1 
	COMF        ds18b20_read_temp__L0+1, 1 
	INFSNZ      ds18b20_read_temp__L0+0, 1 
	INCF        ds18b20_read_temp__L0+1, 1 
;Pruebas_sensor_temperatura.c,55 :: 		signo=-1.0;
	MOVLW       0
	MOVWF       ds18b20_read_signo_L0+0 
	MOVLW       0
	MOVWF       ds18b20_read_signo_L0+1 
	MOVLW       128
	MOVWF       ds18b20_read_signo_L0+2 
	MOVLW       127
	MOVWF       ds18b20_read_signo_L0+3 
;Pruebas_sensor_temperatura.c,56 :: 		}
L_ds18b20_read6:
;Pruebas_sensor_temperatura.c,57 :: 		temp_=temp_>>4; //quita la parte decimal
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
;Pruebas_sensor_temperatura.c,59 :: 		td__=t1_ & 0x0f;    //saca parte decima
	MOVLW       15
	ANDWF       ds18b20_read_t1__L0+0, 0 
	MOVWF       ds18b20_read_td___L0+0 
;Pruebas_sensor_temperatura.c,61 :: 		tempo__=0;
	CLRF        ds18b20_read_tempo___L0+0 
	CLRF        ds18b20_read_tempo___L0+1 
	CLRF        ds18b20_read_tempo___L0+2 
	CLRF        ds18b20_read_tempo___L0+3 
;Pruebas_sensor_temperatura.c,62 :: 		if (td__.b3==1)tempo__=tempo__+0.5;
	BTFSS       ds18b20_read_td___L0+0, 3 
	GOTO        L_ds18b20_read7
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
L_ds18b20_read7:
;Pruebas_sensor_temperatura.c,63 :: 		if (td__.b2==1) tempo__=tempo__+0.25;
	BTFSS       ds18b20_read_td___L0+0, 2 
	GOTO        L_ds18b20_read8
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
L_ds18b20_read8:
;Pruebas_sensor_temperatura.c,64 :: 		if (td__.b1==1) tempo__=tempo__+0.125;
	BTFSS       ds18b20_read_td___L0+0, 1 
	GOTO        L_ds18b20_read9
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
L_ds18b20_read9:
;Pruebas_sensor_temperatura.c,65 :: 		if (td__.b0==1) tempo__=tempo__+0.0625;
	BTFSS       ds18b20_read_td___L0+0, 0 
	GOTO        L_ds18b20_read10
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
L_ds18b20_read10:
;Pruebas_sensor_temperatura.c,66 :: 		if (signo<0) tempo__=-tempo__;
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
	GOTO        L_ds18b20_read11
	BTG         ds18b20_read_tempo___L0+2, 7 
L_ds18b20_read11:
;Pruebas_sensor_temperatura.c,67 :: 		sensor_temp_=(temp_*signo)+tempo__;  //calcula vlor final
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
;Pruebas_sensor_temperatura.c,69 :: 		return (sensor_temp_);
;Pruebas_sensor_temperatura.c,71 :: 		}
L_end_ds18b20_read:
	RETURN      0
; end of _ds18b20_read

_USART_Init:

;Pruebas_sensor_temperatura.c,73 :: 		void USART_Init ()
;Pruebas_sensor_temperatura.c,75 :: 		TRISC.b6=0;
	BCF         TRISC+0, 6 
;Pruebas_sensor_temperatura.c,76 :: 		SPBRG= 207;
	MOVLW       207
	MOVWF       SPBRG+0 
;Pruebas_sensor_temperatura.c,78 :: 		TXSTA.b2=0;                 //BRGH
	BCF         TXSTA+0, 2 
;Pruebas_sensor_temperatura.c,79 :: 		TXSTA.B4=0;                 //Sincrono o asincrono     SYNC
	BCF         TXSTA+0, 4 
;Pruebas_sensor_temperatura.c,80 :: 		TXSTA.B1=0;                 // Transmit shift register
	BCF         TXSTA+0, 1 
;Pruebas_sensor_temperatura.c,81 :: 		RCSTA.B7=1;                 // Habilitacion TX y RX        SPEN
	BSF         RCSTA+0, 7 
;Pruebas_sensor_temperatura.c,82 :: 		BAUDCON.b4=0;                 //Inversión de señal
	BCF         BAUDCON+0, 4 
;Pruebas_sensor_temperatura.c,83 :: 		BAUDCON.b3=0;                //BRG16
	BCF         BAUDCON+0, 3 
;Pruebas_sensor_temperatura.c,85 :: 		TXSTA.B6=0;                 // 8 bits o 9, TX9
	BCF         TXSTA+0, 6 
;Pruebas_sensor_temperatura.c,86 :: 		TXSTA.B5=1;                 // Habilita transmision, TXEN
	BSF         TXSTA+0, 5 
;Pruebas_sensor_temperatura.c,89 :: 		RCSTA.B6=0;
	BCF         RCSTA+0, 6 
;Pruebas_sensor_temperatura.c,90 :: 		RCSTA.B4=1;
	BSF         RCSTA+0, 4 
;Pruebas_sensor_temperatura.c,91 :: 		}
L_end_USART_Init:
	RETURN      0
; end of _USART_Init

_USART_Tx:

;Pruebas_sensor_temperatura.c,92 :: 		void USART_Tx(int info)
;Pruebas_sensor_temperatura.c,94 :: 		TXREG=info;
	MOVF        FARG_USART_Tx_info+0, 0 
	MOVWF       TXREG+0 
;Pruebas_sensor_temperatura.c,96 :: 		}
L_end_USART_Tx:
	RETURN      0
; end of _USART_Tx

_USART_Rx:

;Pruebas_sensor_temperatura.c,99 :: 		char USART_Rx()
;Pruebas_sensor_temperatura.c,101 :: 		return RCREG;
	MOVF        RCREG+0, 0 
	MOVWF       R0 
;Pruebas_sensor_temperatura.c,102 :: 		}
L_end_USART_Rx:
	RETURN      0
; end of _USART_Rx

_main:

;Pruebas_sensor_temperatura.c,105 :: 		void main() {
;Pruebas_sensor_temperatura.c,106 :: 		OSCCON = 0b01110110;
	MOVLW       118
	MOVWF       OSCCON+0 
;Pruebas_sensor_temperatura.c,107 :: 		ADCON1=0b00001111;                   // Configure all PORTA pins as digital
	MOVLW       15
	MOVWF       ADCON1+0 
;Pruebas_sensor_temperatura.c,108 :: 		Lcd_Init();                      // Initialize LCD module
	CALL        _Lcd_Init+0, 0
;Pruebas_sensor_temperatura.c,109 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);        // cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Pruebas_sensor_temperatura.c,110 :: 		Lcd_Cmd(_LCD_CLEAR);             // clear LCD
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Pruebas_sensor_temperatura.c,111 :: 		lcd_out(1, 1, "Temp enviada:");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_Pruebas_sensor_temperatura+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_Pruebas_sensor_temperatura+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Pruebas_sensor_temperatura.c,112 :: 		USART_Init();
	CALL        _USART_Init+0, 0
;Pruebas_sensor_temperatura.c,113 :: 		contador=0;
	CLRF        _contador+0 
	CLRF        _contador+1 
;Pruebas_sensor_temperatura.c,115 :: 		while(1) {
L_main12:
;Pruebas_sensor_temperatura.c,116 :: 		temperatura=ds18b20_read(&PORTA,2);
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
;Pruebas_sensor_temperatura.c,117 :: 		delay_ms(500);
	MOVLW       13
	MOVWF       R11, 0
	MOVLW       175
	MOVWF       R12, 0
	MOVLW       182
	MOVWF       R13, 0
L_main14:
	DECFSZ      R13, 1, 1
	BRA         L_main14
	DECFSZ      R12, 1, 1
	BRA         L_main14
	DECFSZ      R11, 1, 1
	BRA         L_main14
	NOP
;Pruebas_sensor_temperatura.c,118 :: 		tempola=temperatura ;
	MOVF        _temperatura+0, 0 
	MOVWF       R0 
	MOVF        _temperatura+1, 0 
	MOVWF       R1 
	MOVF        _temperatura+2, 0 
	MOVWF       R2 
	MOVF        _temperatura+3, 0 
	MOVWF       R3 
	CALL        _double2int+0, 0
	MOVF        R0, 0 
	MOVWF       _tempola+0 
	MOVF        R1, 0 
	MOVWF       _tempola+1 
;Pruebas_sensor_temperatura.c,119 :: 		inttostr(tempola,texto);
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _texto+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_texto+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Pruebas_sensor_temperatura.c,120 :: 		contador++;
	INFSNZ      _contador+0, 1 
	INCF        _contador+1, 1 
;Pruebas_sensor_temperatura.c,121 :: 		inttostr(contador,num);
	MOVF        _contador+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _contador+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _num+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_num+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Pruebas_sensor_temperatura.c,122 :: 		lcd_out(1,9,num);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _num+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_num+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Pruebas_sensor_temperatura.c,123 :: 		lcd_out(2,1,texto);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _texto+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_texto+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Pruebas_sensor_temperatura.c,124 :: 		USART_tx(tempola);
	MOVF        _tempola+0, 0 
	MOVWF       FARG_USART_Tx_info+0 
	MOVF        _tempola+1, 0 
	MOVWF       FARG_USART_Tx_info+1 
	CALL        _USART_Tx+0, 0
;Pruebas_sensor_temperatura.c,125 :: 		delay_ms(20);
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_main15:
	DECFSZ      R13, 1, 1
	BRA         L_main15
	DECFSZ      R12, 1, 1
	BRA         L_main15
	NOP
	NOP
;Pruebas_sensor_temperatura.c,126 :: 		}
	GOTO        L_main12
;Pruebas_sensor_temperatura.c,127 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

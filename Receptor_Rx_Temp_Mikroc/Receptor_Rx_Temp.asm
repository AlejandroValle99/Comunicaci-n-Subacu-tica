
_USART_Init:

;Receptor_Rx_Temp.c,18 :: 		void USART_Init ()
;Receptor_Rx_Temp.c,20 :: 		TRISC.b7=1;
	BSF         TRISC+0, 7 
;Receptor_Rx_Temp.c,21 :: 		TRISC.b6=0;
	BCF         TRISC+0, 6 
;Receptor_Rx_Temp.c,22 :: 		SPBRG= 207;
	MOVLW       207
	MOVWF       SPBRG+0 
;Receptor_Rx_Temp.c,24 :: 		TXSTA.b2=0;                 //BRGH
	BCF         TXSTA+0, 2 
;Receptor_Rx_Temp.c,25 :: 		TXSTA.B4=0;                 //Sincrono o asincrono     SYNC
	BCF         TXSTA+0, 4 
;Receptor_Rx_Temp.c,26 :: 		TXSTA.B1=0;                 // Transmit shift register
	BCF         TXSTA+0, 1 
;Receptor_Rx_Temp.c,27 :: 		RCSTA.B7=1;                 // Habilitacion TX y RX        SPEN
	BSF         RCSTA+0, 7 
;Receptor_Rx_Temp.c,28 :: 		BAUDCON.b4=0;
	BCF         BAUDCON+0, 4 
;Receptor_Rx_Temp.c,29 :: 		BAUDCON.b3=0;                //BRG16
	BCF         BAUDCON+0, 3 
;Receptor_Rx_Temp.c,31 :: 		TXSTA.B6=0;                 // 8 bits o 9, TX9
	BCF         TXSTA+0, 6 
;Receptor_Rx_Temp.c,32 :: 		TXSTA.B5=1;                 // Habilita transmision, TXEN
	BSF         TXSTA+0, 5 
;Receptor_Rx_Temp.c,35 :: 		RCSTA.B6=0;
	BCF         RCSTA+0, 6 
;Receptor_Rx_Temp.c,36 :: 		RCSTA.B4=1;
	BSF         RCSTA+0, 4 
;Receptor_Rx_Temp.c,37 :: 		}
L_end_USART_Init:
	RETURN      0
; end of _USART_Init

_USART_Tx:

;Receptor_Rx_Temp.c,39 :: 		void USART_Tx(int info)
;Receptor_Rx_Temp.c,41 :: 		TXREG=info;
	MOVF        FARG_USART_Tx_info+0, 0 
	MOVWF       TXREG+0 
;Receptor_Rx_Temp.c,43 :: 		}
L_end_USART_Tx:
	RETURN      0
; end of _USART_Tx

_USART_Rx:

;Receptor_Rx_Temp.c,45 :: 		int USART_Rx()
;Receptor_Rx_Temp.c,47 :: 		return RCREG;
	MOVF        RCREG+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
;Receptor_Rx_Temp.c,48 :: 		}
L_end_USART_Rx:
	RETURN      0
; end of _USART_Rx

_main:

;Receptor_Rx_Temp.c,51 :: 		void main()
;Receptor_Rx_Temp.c,53 :: 		OSCCON = 0b01110110;
	MOVLW       118
	MOVWF       OSCCON+0 
;Receptor_Rx_Temp.c,54 :: 		Lcd_Init();                      // Initialize LCD module
	CALL        _Lcd_Init+0, 0
;Receptor_Rx_Temp.c,55 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);        // cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Receptor_Rx_Temp.c,56 :: 		Lcd_Cmd(_LCD_CLEAR);             // clear LCD
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Receptor_Rx_Temp.c,57 :: 		lcd_out(1, 1, "Temp recibida:");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_Receptor_Rx_Temp+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_Receptor_Rx_Temp+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Receptor_Rx_Temp.c,58 :: 		USART_Init();
	CALL        _USART_Init+0, 0
;Receptor_Rx_Temp.c,60 :: 		while(1)
L_main0:
;Receptor_Rx_Temp.c,62 :: 		Temp_Rx=USART_Rx() ;
	CALL        _USART_Rx+0, 0
	MOVF        R0, 0 
	MOVWF       _Temp_rx+0 
	MOVF        R1, 0 
	MOVWF       _Temp_rx+1 
;Receptor_Rx_Temp.c,63 :: 		delay_ms(10);
	MOVLW       65
	MOVWF       R12, 0
	MOVLW       238
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	NOP
;Receptor_Rx_Temp.c,64 :: 		inttostr(Temp_Rx,texto);
	MOVF        _Temp_rx+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _Temp_rx+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _texto+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_texto+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;Receptor_Rx_Temp.c,65 :: 		lcd_out(2,1,"27");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_Receptor_Rx_Temp+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_Receptor_Rx_Temp+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Receptor_Rx_Temp.c,66 :: 		delay_ms(10);
	MOVLW       65
	MOVWF       R12, 0
	MOVLW       238
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
	NOP
;Receptor_Rx_Temp.c,67 :: 		}
	GOTO        L_main0
;Receptor_Rx_Temp.c,69 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

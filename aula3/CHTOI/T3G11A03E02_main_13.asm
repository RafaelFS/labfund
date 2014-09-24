;Importando PACK  ==================================================================
PACK        		<           ; Sub-rotina PACK
PACK_VAR1   		<           ; Endereço da primeira palavra a ser empacotada
PACK_VAR2   		<           ; Endereço da segunda palabra a ser empacotada

;Importando UNPACK  =======================================================================
UNPACK        		<           ; Sub-rotina UNPACK
UNPACK_OUT_ADDR1  	<	     	; Endereço de saída da primeira palavra 
UNPACK_OUT_ADDR2 	<       	; Endereço de saída da segunda palavra 
UNPACK_PACKAGE     	<         	; Word empacotada

;Importando MEMCOPY =======================================================================
MEMCOPY       		<           ; Sub-rotina MEMCOPY
MEMCOPY_NWORDS 		< 			; Número de palavras a serem copiadas (cópia da subrotina)
MEMCOPY_END_ORIGEM	<			; Endereço inicial da sequência de origem (cópia da subrotina)
MEMCOPY_END_DESTINO	<			; Endereço inicial da sequência de destino (cópia da subrotina)

; Importando CHTOI  =======================================================================
CHTOI				<
CHTOI_IN1		 	<           ; Endereço de entrada da primeira palavra
CHTOI_IN2 			<       	; Endereço de entrada da segunda palavra
CHTOI_WORD	     	<       	; Word final
CHTOI_AUX 			<
CHTOI_D 			<
CHTOI_D1          	<       	; Digito 1 
CHTOI_D2  	     	<       	; Digito 2 
CHTOI_D3  	     	<       	; Digito 3 
CHTOI_D4  	     	<       	; Digito 4 

;Importando constantes ===========================================================
SHIFT2	    		<           ; Constante que desloca em 2 posições os bits das palavras
LD_VAZIA     		<           ; Instrução
TRATA_NEG			<
VOLTA_NEG 			<
MM_VAZIA			<
LD_VAZIA			<
INC_ADDRESS 		<
INCREASE			<
INVALID_ADDR		<
CH_1				<
CH_2				<
CH_3				<
CH_4				<
CH_5 				<
CH_6 				<
CH_E				<

						& 		/0000				; Inicio do programa em 0000
INI						JP 		MAIN_CHTOI			; Pula para a label MAIN_PACK
ENTRADA_CHTOI_1			K		/3739
ENTRADA_CHTOI_2			K		/4142					
; Corpo do teste de funcionamento de CHTOI
MAIN_CHTOI 				LV 		ENTRADA_CHTOI_1
						MM 		CHTOI_IN1 						
						LV 		ENTRADA_CHTOI_2
						MM 		CHTOI_IN2
						SC 		CHTOI
FIM						HM 		FIM					; FIM
						# 		INI					; Indica o fim do programa (Pseudo-comando)

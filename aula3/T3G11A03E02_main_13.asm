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

; Importando ITOCH ===============================================================================
ITOCH 				<			
ITOCH_END_SAIDA_1	<			; Endereço onde a saída 1 de ITOCH será armazenada
ITOCH_END_SAIDA_2	<			; Endereço onde a saída 2 de ITOCH será armazenada

; Programa Principal ============================================================================
						& 		/0000				; Inicio do programa em 0000
INI						JP 		MAIN_CHTOI			; Pula para a label MAIN_PACK
ENTRADA_CHTOI_1			K		/3739 				; Primeira palavra de entrada de CHTOI
ENTRADA_CHTOI_2			K		/4142				; Segunda palavra de entrada de CHTOI
SAIDA_CHTOI				K 		/0000				; Endereço em que a saída de CHTOI é salva
ENTRADA_ITOCH			K		/79AB               ; Entrada de ITOCH
SAIDA_ITOCH_1 			K 		/0000				; Primeira palavra de saida de ITOCH
SAIDA_ITOCH_2 			K 		/0000				; Segunda palavra de saida de ITOCH					
; Corpo do teste de funcionamento de CHTOI
MAIN_CHTOI 				LV 		ENTRADA_CHTOI_1		; Recebe o endereco de memoria da primeira entrada de CHTOI
						MM 		CHTOI_IN1 			; Salva o endereco no parâmetro CHTOI_IN1 		
						LV 		ENTRADA_CHTOI_2		; Recebe o endereco de memoria da segunda entrada de CHTOI
						MM 		CHTOI_IN2			; Salva o endereco no parâmetro CHTOI_IN2
						SC 		CHTOI 				; Chama CHTOI
						MM 		SAIDA_CHTOI 		; Salva a saída de CHTOI, presente no Acumulador, em SAIDA_CHTOI
; Corpo do teste de funcionamento de ITOCH
MAIN_ITOCH				LV 		SAIDA_ITOCH_1		; Recebe o endereco de memoria da primeira saída de ITOCH
						MM 		ITOCH_END_SAIDA_1	; Salva o endereco no parâmetro ITOCH_END_SAIDA_1
						LV 	 	SAIDA_ITOCH_2		; Recebe o endereco de memoria da segunda saída de ITOCH
						MM 		ITOCH_END_SAIDA_2	; Salva o endereco no parâmetro ITOCH_END_SAIDA_2
						LD 		ENTRADA_ITOCH       ; Coloca o valor de entrada de ITOCH no Acumulador
						SC 		ITOCH 				; Chama a sub-rotina ITOCH	
FIM						HM 		FIM					; FIM
						# 		INI					; Indica o fim do programa (Pseudo-comando)

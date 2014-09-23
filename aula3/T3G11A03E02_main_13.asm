;Importando ITOCH  ==================================================================
ITOCH 				>
ITOCH_END_SAIDA_1	>
ITOCH_END_SAIDA_2	>

						& 		/0000				; Inicio do programa em 0000
INI						JP 		MAIN_PACK			; Pula para a label MAIN_PACK
ENTRADA_ITOCH			K		/79AB               ; Entrada de ITOCH
SAIDA_ITOCH_1 			K 		/0000				; Primeira palavra de saida de ITOCH
SAIDA_ITOCH_2 			K 		/0000				; Segunda palavra de saida de ITOCH
					
; Corpo do teste de funcionamento de PACK
MAIN_PACK				LV 		SAIDA_ITOCH_1		; Recebe o endereco de memoria de ENTRADA_PACK_1
						MM 		ITOCH_END_SAIDA_1	; Salva o endereco na memoria PACK_VAR1
						LV 	 	SAIDA_ITOCH_2		; Recebe o endereco de memoria de ENTRADA_PACK_2
						MM 		ITOCH_END_SAIDA_2	; Salva o endereco na memoria PACK_VAR2
						LD 		ENTRADA_ITOCH       ;
						SC 		ITOCH 				; Chama a sub-rotina PACK	
FIM						HM 		FIM					; FIM
						# 		INI					; Indica o fim do programa (Pseudo-comando)

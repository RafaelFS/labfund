						@ 		/0000				; Inicio do programa em 0000
INI						JP 		RESET				; Pula para a label MAIN_PACK
LU 						K 		/0000
RESET 					OS 		/01FA
						JP  	SKIP
NUM_SKIP 				K 		/0002
LU_SKIP					K  		/0000
SKIP 				 	OS 		/02FE
FIM						HM 		FIM					; FIM
						# 		INI					; Indica o fim do programa (Pseudo-comando)
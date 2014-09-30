						@ 		/0000				; Inicio do programa em 0000
INI						JP 		reset				; Pula para a label MAIN_PACK
LU 						K 		/0000
reset  					OS 		/01FA
FIM						HM 		FIM					; FIM
						# 		INI					; Indica o fim do programa (Pseudo-comando)
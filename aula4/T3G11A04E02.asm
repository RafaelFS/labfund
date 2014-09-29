						@ 		/0000				; Inicio do programa em 0000
INI						JP 		MAIN_OS				; Pula para a label MAIN_PACK
LU						K 		/0002				; Parâmetro de unidade lógica para a função de adicionar dispostivo
TYPE					K		/0003				; Parâmetro de tipo de dispostivo para a função de adicionar dispostivo
MAIN_OS					OS 		/02AD				; Instrução OS que chama a função de adicionar dispostivo 
FIM						HM 		FIM					; FIM
						# 		INI					; Indica o fim do programa (Pseudo-comando)
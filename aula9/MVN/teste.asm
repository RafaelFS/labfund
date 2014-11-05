; Coloque aqui seus imports

		@ 	/0000
MAIN	JP 	INI		; salta para o início do programa
UL		K 	/0000 	; parâmetro: UL onde está o arquivo de batch

INI		LV /0000			; coloque aqui o código do seu monitor batch
		OS /0EE
		LV /0001
		OS /0EE
		LV /0002
		OS /0EE
		LV /0003
		OS /0EE
		LV /0004
		OS /0EE
		LV /0005
		OS /0EE
FIM 	HM	FIM		; fim do programa

# MAIN

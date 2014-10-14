		@ /0000 		; endereço absoluto
JP 		INI 			; vai para início do programa
VAL 	K 		/1234 	; valor a ser escrito no disco
INI 	LD 		VAL 	; carrega valor no acumulador
		PD 		/300 	; escreve valor do acumulador no disco 
						; cujo ID é 00 (operação de “append”)
END 	HM 		END 	; fim
		# 		INI
				

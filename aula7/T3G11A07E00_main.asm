		@ /0000 		; endere�o absoluto
JP 		INI 			; vai para in�cio do programa
VAL 	K 		/1234 	; valor a ser escrito no disco
INI 	LD 		VAL 	; carrega valor no acumulador
		PD 		/300 	; escreve valor do acumulador no disco 
						; cujo ID � 00 (opera��o de �append�)
END 	HM 		END 	; fim
		# 		INI
				

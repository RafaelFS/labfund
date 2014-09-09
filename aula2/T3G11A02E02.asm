			@ 		/0000		; Avisa o montador que o endereço inicial do programa é 0000
INI			JP		MAIN		; Pula para o início do programa MAIN
			IN  	/1234		; Word a ser desempacotada
			OUT1 	/0000   	; Primeira word de saída
			OUT2	/0000 		; Segunda word de saída

MAIN		LV		OUT1 		; Coloca o endereço de OUT1 no Acumulador
			MM 		UNPACK_W1	; Copia o conteúdo do Acumulador para UNPACK_W1
			LV		OUT2 		; Coloca o endereço de OUT2 no Acumulador
			MM 		UNPACK_W2	; Copia o conteúdo do Acumulador para UNPACK_W2 
			LD		IN 			; Copia o conteúdo de IN para o Acumulador
			SC  	UNPACK      ; Executa a subrotina UNPACK
FIM			HM

UNPACK_W1	K		/0000		; Endereço da primeira palavra resultado de UNPACK 
UNPACK_W2	K		/0000		; Endereço da segunda palavra resultado de UNPACK
PACKAGE		K 		/0000       ; Word empacotada
UNPACK 		K 		/0000		; Início da subrotina UNPACK (endereço reservado para retorno)
			MM 		PACKAGE		; Copia o contéudo do Acumulador para PACKAGE;
			
			#	

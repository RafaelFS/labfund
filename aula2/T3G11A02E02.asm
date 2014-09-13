			@ 		/0000		; Avisa o montador que o endereço inicial do programa é 0000
INI			JP		MAIN		; Pula para o início do programa MAIN
INPUT 		K 		/1234		; Word a ser desempacotada
OUT1 		K		/0000   	; Primeira word de saída
OUT2		K		/0000 		; Segunda word de saída

;Variáveis auxiliares
MMVAZIA		LV      /0000		; Move to memory vazia para criação de instrução dinamicamente

; Corpo do programa principal
MAIN		LV		OUT1 		; Coloca o endereço de OUT1 no Acumulador
			MM 		W1XADDRESS	; Copia o conteúdo do Acumulador para W1XADDRESS
			LV		OUT2 		; Coloca o endereço de OUT2 no Acumulador
			MM 		W2XADDRESS	; Copia o conteúdo do Acumulador para W2XADDRESS
			LD		INPUT 		; Copia o conteúdo de INPUT para o Acumulador
			SC  	UNPACK      ; Executa a subrotina UNPACK
FIMDEMAIN	HM		FIMDEMAIN   ; Fim do programa

; Subrotina que desempacota a palavra presente no Acumulador e salva as palavras resultantes nos
; endereço armazenado em UNPACK_W1 e UNPACK_W2

;Variáveis da subrotina
W1XADDRESS	K		/0000		; Endereço de saída da primeira palavra 
W2XADDRESS	K		/0000		; Endereço de saída da segunda palavra 
W1 			K		/0000       ; Palavra 1 (2 primeiros digitos da original)
W2 			K		/0000		; Palavra 2 (2 ultimos digitos da original)
PACKAGE		K 		/0000       ; Word empacotada
W1DESLOCADA K		/0000		; A primeira palavra deslocada
DESLOCADOR	K 		/0100
;Corpo da subrotina
UNPACK 		K 		/0000		; Início da subrotina UNPACK (endereço reservado para retorno)
			MM 		PACKAGE		; Copia o contéudo do Acumulador para PACKAGE;
			JN		NEGATIVO    ; Se a palavra é um número negativo, pula para o caso NEGATIVO
POSITIVO	/		DESLOCADOR	; Se a palavra é positiva, divido por /100 para obter a primeira palavra no Acumulador
			MM		W1 			; Copio a primeira palavra em W1;
			LD      W1XADDRESS  ; Copio o endereço de saída da primeira palavra para o Acumulador
			+		MMVAZIA		; Combina o endereço de saída da primeira palavra com a isntrução MM
			MM		SALVA1		; Tranfere a instrução completa para a posição SALVA1
			LV 		W1 			; Copia o valor de W1 para o Acumulador
SALVA1      K		/0000		; Executa a instrução MM <valor contido em W1XADDRESS>, salvando a palavra 1 na posição de saída desejada
			*		DESLOCADOR	; Multiplica a primeira palavra por /100 para deslocá-la duas posições para a direita
			MM  	W1DESLOCADA	; Salvo a palavra 1 deslocada em W1DESLOCADA
			LD 		PACKAGE 	; Copio a palavra empacotada para o Acumulador
			- 		W1DESLOCADA	; Subtraio os dois primeiros digitos da palavra empacotada para obter a segunda palavra
			MM		W2 			; Copio a segunda palavra em W2;
			LD      W2XADDRESS  ; Copio o endereço de saída da segunda palavra para o Acumulador
			+		MMVAZIA		; Combina o endereço de saída da segunda palavra com a instrução MM
			MM		SALVA2		; Tranfere a instrução completa para a posição SALVA1
			LV 		W2 			; Copia o valor de W2 para o Acumulador
SALVA2      K		/0000		; Executa a instrução MM <valor contido em W1XADDRESS>, salvando a palavra 1 na posição de saída desejada
			JP 		FIMDEUNPACK
NEGATIVO    K 		/0000		
FIMDEUNPACK	RS 		UNPACK		; Retorno da subrotina
			#		INI
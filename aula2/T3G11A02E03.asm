; A02E03
; Subrotina que copia uma sequência de tamanho arbitrário de bytes da 
; memória de uma posição em outra. Retorna 0000 em caso de 
; sucesso e FFFF em caso de erro
		
			@ 		/0000		; Avisa o montador que o endereço inicial do programa é 0000
INI			JP		MAIN		; Pula para o início do programa MAIN
NWORDS		K		/0004		; Número de palavras a serem copiadas
ENDORIGEM	K		/0000		; Endereço inicial da sequência de origem
ENDDESTINO	K		/0000		; Endereço inicial da sequência de destino
			$		/0020		; Reservo o espaço até o endereço 28, avisando que a próxima instrução ocorre no endereço 30
;Corpo do programa principal
MAIN		LD 		NWORDS		; Copia o conteúdo de NWORDS para o Acumulador
			MM 		SUBNWORDS	; Copia o conteúdo de NWORDS para SUBNWORDS
			LD 		ENDORIGEM	; Copia o conteúdo de ENDORIGEM para o Acumulador
			MM 		SUBENDORI	; Copia o conteúdo de ENDORIGEM para SUBENDORI
			LD 		ENDDESTINO	; Copia o conteúdo de ENDDESTINO para o Acumulador
			MM 		SUBENDDES	; Copia o conteúdo de ENDDESTINO para SUBENDDES
			SC  	MEMCOPY     ; Executa a subrotina MEMCOPY
FIMDEMAIN	HM		FIMDEMAIN   ; Fim do programa	 


;Variáveis da subrotina
SUBNWORDS 	K		/0000		; Número de palavras a serem copiadas (cópia da subrotina)
SUBENDORI	K		/0000		; Endereço inicial da sequência de origem (cópia da subrotina)
SUBENDDES 	K		/0000		; Endereço inicial da sequência de destino (cópia da subrotina)
OK			K		/0000		; Código de retorno de funcionamento correto
ERRO 		K		/FFFF		; Código de retorno de caso de erro 
;Corpo da Subrotina
MEMCOPY		K 		/0000		; Início da subrotina MEMCOPY (endereço reservado para retorno)
FIMMEMCOPY	RS 		UNPACK		; Retorno da subrotina
			#		INI

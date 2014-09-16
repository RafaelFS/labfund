; A02E03
; Subrotina que copia uma sequência de tamanho arbitrário de bytes da 
; memória de uma posição em outra. Retorna 0000 em caso de 
; sucesso e FFFF em caso de erro
		
			@ 		/0000		; Avisa o montador que o endereço inicial do programa é 0000
INI			JP		MAIN		; Pula para o início do programa MAIN
NWORDS		K		/0000		; Número de palavras a serem copiadas
ENDORIGEM	K		/5000		; Endereço inicial da sequência de origem
ENDDESTINO	K		/7000		; Endereço inicial da sequência de destino
			@		/0030		; Reservo o espaço até o endereço 28, avisando que a próxima instrução ocorre no endereço 30
;Corpo do programa principal
MAIN		LD 		NWORDS		; Copia o conteúdo de NWORDS para o Acumulador
			MM 		SNWORDS		; Copia o conteúdo de NWORDS para SNWORDS
			LD 		ENDORIGEM	; Copia o conteúdo de ENDORIGEM para o Acumulador
			MM 		SENDORIGEM	; Copia o conteúdo de ENDORIGEM para SENDORIGEM
			LD 		ENDDESTINO	; Copia o conteúdo de ENDDESTINO para o Acumulador
			MM 		SENDDESTINO	; Copia o conteúdo de ENDDESTINO para SENDDESTINO
			SC  	MEMCOPY     ; Executa a subrotina MEMCOPY
FIMDEMAIN	HM		FIMDEMAIN   ; Fim do programa	 


;Variáveis da subrotina
SNWORDS 	K		/0000		; Número de palavras a serem copiadas (cópia da subrotina)
SENDORIGEM	K		/0000		; Endereço inicial da sequência de origem (cópia da subrotina)
SENDDESTINO	K		/0000		; Endereço inicial da sequência de destino (cópia da subrotina)
SORIATUAL	K		/0000		; Endereço atual que eu estou lendo	
SDESATUAL	K		/0000		; Endereço atual para onde estou copiando
CONTAGEM	K		/0000		; Número de palavras que ainda preciso copiar
OK			K		/0000		; Código de retorno de funcionamento correto
ERRO 		K		/FFFF		; Código de retorno de caso de erro 
MMVAZIA		MM      /0000
LDVAZIA		MM      /0000

;Corpo da Subrotina
MEMCOPY		K 		/0000		; Início da subrotina MEMCOPY (endereço reservado para retorno)
			;Inicio colocando os valores iniciais das variáveis de controle
			LD      SENDORIGEM  ; Copio o endereço de origem para o Acumulador
			MM 		SORIATUAL   ; Copio o endereço de origem para endereço que estou lendo
			LD      SENDDESTINO ; Copio o endereço de destino para o Acumulador
			MM 		SDESATUAL   ; Copio o endereço de destino para endereço que estou lendo
			LD      SNWORDS     ; Copio o número de palavras para o Acumulador
			MM 		CONTAGEM    ; Copio o número de palavras para CONTAGEM
LOOP 		JZ		FIMMEMCOPY  ; Pula para fora do LOOP se CONTAGEM = 0
FIMMEMCOPY	LD 		OK			; Coloco o código de OK no Acumulador
			RS 		MEMCOPY		; Retorno da subrotina
			#		INI

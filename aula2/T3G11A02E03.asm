; A02E03
; Subrotina que copia uma sequência de tamanho arbitrário de bytes da 
; memória de uma posição em outra. Retorna 0000 em caso de 
; sucesso e FFFF em caso de erro
		
				@ 		/0000			; Avisa o montador que o endereço inicial do programa é 0000
INI				JP		MAIN			; Pula para o início do programa MAIN
NWORDS			K		/0003			; Número de palavras a serem copiadas
ENDORIGEM		K		/0008			; Endereço inicial da sequência de origem
ENDDESTINO		K		/0010			; Endereço inicial da sequência de destino
SEQORIGEM		K 		/0001			; Inicio dos endereços reservados para a origem
				K		/0002		
				K 		/0003
				K		/0004		
				@		/0010			; Seto os 4 endereços a partir do 10 com FFFF para melhorar visualização dos testes
				K		/FFFF
				K		/FFFF
				K		/FFFF
				K		/FFFF
				@		/0030			; Reservo o espaço até o endereço 28, avisando que a próxima instrução ocorre no endereço 30
;Corpo do programa principal
MAIN			LD 		NWORDS			; Copia o conteúdo de NWORDS para o Acumulador
				MM 		SNWORDS			; Copia o conteúdo de NWORDS para SNWORDS
				LD 		ENDORIGEM		; Copia o conteúdo de ENDORIGEM para o Acumulador
				MM 		SENDORIGEM		; Copia o conteúdo de ENDORIGEM para SENDORIGEM
				LD 		ENDDESTINO		; Copia o conteúdo de ENDDESTINO para o Acumulador
				MM 		SENDDESTINO		; Copia o conteúdo de ENDDESTINO para SENDDESTINO
				SC  	MEMCOPY     	; Executa a subrotina MEMCOPY
FIMDEMAIN		HM		FIMDEMAIN   	; Fim do programa	 


;Variáveis da subrotina
SNWORDS 		K		/0000			; Número de palavras a serem copiadas (cópia da subrotina)
SENDORIGEM		K		/0000			; Endereço inicial da sequência de origem (cópia da subrotina)
SENDDESTINO		K		/0000			; Endereço inicial da sequência de destino (cópia da subrotina)
SORIATUAL		K		/0000			; Endereço atual que eu estou lendo	
SDESATUAL		K		/0000			; Endereço atual para onde estou copiando
CONTAGEM		K		/0000			; Número de palavras que ainda preciso copiar
OK				K		/0000			; Código de retorno de funcionamento correto
ERRO 			K		/FFFF			; Código de retorno de caso de erro 
MMVAZIA			MM      /0000       	; Código com MM vazia
LDVAZIA			LD    	/0000			; Código com LD vazia
COPIANDO 		K		/0000			; Dado que está sendo copiado
INCADDRESS		K		/0002			; Constante de incremento de endereço
DECCONT			K 		/0001			; Constante de decremento de contagem
RETORNO			K		/0000			; Retorno da subrotina
INVALID_ADDR	K		/1000       	; Constante de endereço invalido. Qualquer endereço igual ou maior que ele é inválido
;Corpo da Subrotina
MEMCOPY			K 		/0000			; Início da subrotina MEMCOPY (endereço reservado para retorno)
				; Tratando erros
MC_ERRO_CHK_1	LD      SENDORIGEM  	; Copio o endereço de origem para o Acumulador
				-		INVALID_ADDR	; Subtraio o endereço pelo primeiro endereço inválido 
				JN		MC_ERRO_CHK_2	; Se for negativo, o endereço é válido e pula para o segundo check
MC_ERRO_1		LD 		ERRO            ; Se entrou aqui, o endereço é inválido. Copio o código de erro no Acumulador.
				MM 		RETORNO 		; Copio o código de erro em RETORNO
MC_ERRO_CHK_2	LD      SENDDESTINO  	; Copio o endereço de origem para o Acumulador
				-		INVALID_ADDR	; Subtraio o endereço pelo primeiro endereço inválido 
				JN		ERRO_CHK_FIM	; Se for negativo, o endereço é válido
MC_ERRO_2		LD 		ERRO            ; Se entrou aqui, o endereço é inválido. Copio o código de erro no Acumulador.
				MM 		RETORNO 		; Copio o código de erro em RETORNO
ERRO_CHK_FIM	LD 		RETORNO         ; Carrego RETORNO no Acumulador
				JZ		INICIOMEMCP		; Se retorno = 0, continuo, senão pulo pro final
				JP		FIMMEMCOPY		

				; Inicio colocando os valores iniciais das variáveis de controle
INICIOMEMCP		LD      SENDORIGEM  	; Copio o endereço de origem para o Acumulador
				MM 		SORIATUAL   	; Copio o endereço de origem para endereço que estou lendo
				LD      SENDDESTINO 	; Copio o endereço de destino para o Acumulador
				MM 		SDESATUAL   	; Copio o endereço de destino para endereço que estou lendo
				;Inicia contagem	
				LD      SNWORDS     	; Copio o número de palavras para o Acumulador
				MM 		CONTAGEM    	; Copio o número de palavras para CONTAGEM
				; Loop de copias	
LOOP 			JZ		FIMMEMCOPY  	; Pula para fora do LOOP se CONTAGEM = 0
				LD 		SORIATUAL   	; Copio o endereço atual a ser lido para o Acumulador
				+		LDVAZIA     	; Somo o endeço atual a ser lido com a instrução de LOAD, obtendo uma instrução que lê o valor atual
				MM		COPIAATUAL 		; Envio a instrução que lê o valor atual para COPIAATUAL
COPIAATUAL		K 		/0000			; Executa instrução que lê o valor atual
				MM 		COPIANDO    	; Copia o valor atual para COPIANDO
				LD 		SDESATUAL   	; Copio o endereço atual de destino para o Acumulador
				+		MMVAZIA     	; Somo o endereço atual de destino com a instrução de MM, obtendo uma instrução que envia para o destino atual
				MM		ENVIAATUAL 		; Envio a instrução que envia para o destino atual para ENVIAATUAL
				LD 		COPIANDO    	; Copio o valor atual para o Acumulador
ENVIAATUAL		K 		/0000			; Executa instrução que envia para o destino atual
				;Incrementando os endereços e decrementando a CONTAGEM
				LD 		SORIATUAL   
				+ 		INCADDRESS
				MM      SORIATUAL
				LD 		SDESATUAL   
				+ 		INCADDRESS
				MM      SDESATUAL
				LD 		CONTAGEM
				- 		DECCONT
				MM 		CONTAGEM
				JP		LOOP 			; Retorna ao Inicio do LOOP 
FIMMEMCOPY		LD 		RETORNO			; Coloco o valor de RETORNO no Acumulador
				RS 		MEMCOPY			; Retorno da subrotina
				#		INI

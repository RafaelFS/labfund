; T3G11A03E02_rotinas_13.asm
; Arquivo que contém as rotinas desenvolvidas nas aulas anteriores
					&       /0000
;Exportando PACK  ==================================================================
PACK        		>           ; Sub-rotina PACK
PACK_VAR1   		>           ; Endereço da primeira palavra a ser empacotada
PACK_VAR2   		>           ; Endereço da segunda palabra a ser empacotada

;Exportando UNPACK  =======================================================================
UNPACK              >
UNPACK_OUT_ADDR1  	>	     	; Endereço de saída da primeira palavra 
UNPACK_OUT_ADDR2 	>       	; Endereço de saída da segunda palavra 
UNPACK_PACKAGE     	>         	; Word empacotada

;Exportando MEMCOPY =======================================================================
MEMCOPY             >
MEMCOPY_NWORDS 		> 			; Número de palavras a serem copiadas (cópia da subrotina)
MEMCOPY_END_ORIGEM	>			; Endereço inicial da sequência de origem (cópia da subrotina)
MEMCOPY_END_DESTINO	>			; Endereço inicial da sequência de destino (cópia da subrotina)

; Exportando CHTOI  =======================================================================
CHTOI				>
CHTOI_IN1		 	>           ; Endereço de entrada da primeira palavra
CHTOI_IN2 			>       	; Endereço de entrada da segunda palavra
CHTOI_WORD	     	>       	; Word final
CHTOI_AUX 			>
CHTOI_D 			>
CHTOI_D1          	>       	; Digito 1 
CHTOI_D2  	     	>       	; Digito 2 
CHTOI_D3  	     	>       	; Digito 3 
CHTOI_D4  	     	>       	; Digito 4 

;Importando constantes ===========================================================
SHIFT2	    		<           ; Constante que desloca em 2 posições os bits das palavras
LD_VAZIA     		<           ; Instrução
TRATA_NEG			<
VOLTA_NEG 			<
MM_VAZIA			<
LD_VAZIA			<
INC_ADDRESS 		<
INCREASE			<
INVALID_ADDR		<
CH_1				<
CH_2				<
CH_3				<
CH_4				<
CH_5 				<
CH_6 				<
CH_E				<
	
; Subrotina PACK ===============================================================================
; Recebe o endereço de duas palavras e retorna no Acumulador a composição entre as duas

; Variáveis de PACK
PACK_VAR1   K /0000     ; Variavel do programa
PACK_VAR2   K /0000     ; Variavel do programa
; Corpo de PACK
PACK        K /0000             ; Sub-rotina PACK
			LD      PACK_VAR1   ; Recebe o endereco de IN1 (conteudo de PACK_VAR1)
			+       LD_VAZIA     ; Soma com (8000H)
			MM      PACK_X      ; Salva no proximo endereco de memoria
PACK_X      K       /0000       ; Executa a instrucao recem-montada
			*       SHIFT2      ; Multiplica por 100H
			MM      PACK_VAR1   ; Salva na memoria PACK_VAR1
			LD      PACK_VAR2   ; Recebe o endereco de IN2 (conteudo de PACK_VAR2)
			+       LD_VAZIA    ; Soma com (8000H)
			MM      PACK_Y      ; Salva no proximo endereco de memoria
PACK_Y      K       /0000       ; Executa a instrucao recem-montada
			+       PACK_VAR1   ; Soma com o conteudo de PACK_VAR1
			RS      PACK        ; Fim da sub-rotina 


; Subrotina UNPACK =============================================================================
; Subrotina que desempacota a palavra presente no Acumulador e salva as palavras resultantes nos
; endereço armazenado em UNPACK_W1 e UNPACK_W2

;Variáveis de UNPACK
UNPACK_OUT_ADDR1  	K       /0000       	; Endereço de saída da primeira palavra 
UNPACK_OUT_ADDR2 	K       /0000       	; Endereço de saída da segunda palavra 
UNPACK_PACKAGE     	K       /0000       	; Word empacotada
UNPACK_W1          	K       /0000       	; Palavra 1 (2 primeiros digitos da original)
UNPACK_W2       	K       /0000       	; Palavra 2 (2 ultimos digitos da original)
UNPACK_W1_DESLOCADA K       /0000       	; A primeira palavra deslocada

;Corpo da subrotina
UNPACK      		K       /0000       			; Início da subrotina UNPACK (endereço reservado para retorno)
					MM      UNPACK_PACKAGE  		; Copia o contéudo do Acumulador para PACKAGE;
					JN      UNPACK_NEGATIVO 		; Se a palavra é um número negativo, pula para o caso NEGATIVO
UNPACK_POSITIVO    	/       SHIFT2 	    			; Se a palavra é positiva, divido por /100 para obter a primeira palavra no Acumulador
					MM      UNPACK_W1 				; Copio a primeira palavra em W1;
					LD      UNPACK_OUT_ADDR1		; Copio o endereço de saída da primeira palavra para o Acumulador
					+       MM_VAZIA     			; Combina o endereço de saída da primeira palavra com a isntrução MM
					MM      UNPACK_SALVA1   		; Tranfere a instrução completa para a posição SALVA1
					LD      UNPACK_W1       		; Copia o valor de W1 para o Acumulador
UNPACK_SALVA1      	K       /0000       			; Executa a instrução MM <valor contido em W1XADDRESS>, salvando a palavra 1 na posição de saída desejada
					LD      UNPACK_W1       		; Copia o valor de W1 para o Acumulador
					*       SHIFT2 					; Multiplica a primeira palavra por /100 para deslocá-la duas posições para a direita
					MM      UNPACK_W1_DESLOCADA 	; Salvo a palavra 1 deslocada em W1DESLOCADA
					LD      UNPACK_PACKAGE     		; Copio a palavra empacotada para o Acumulador
					-       UNPACK_W1_DESLOCADA 	; Subtraio os dois primeiros digitos da palavra empacotada para obter a segunda palavra
					MM      UNPACK_W2          		; Copio a segunda palavra em W2;
					LD      UNPACK_OUT_ADDR2		; Copio o endereço de saída da segunda palavra para o Acumulador
					+       MM_VAZIA     			; Combina o endereço de saída da segunda palavra com a instrução MM
					MM      UNPACK_SALVA2      		; Tranfere a instrução completa para a posição SALVA1
					LD      UNPACK_W2          		; Copia o valor de W2 para o Acumulador
UNPACK_SALVA2      	K       /0000       			; Executa a instrução MM <valor contido em W1XADDRESS>, salvando a palavra 1 na posição de saída desejada
					JP      UNPACK_FIM 	    
UNPACK_NEGATIVO    	+       TRATA_NEG    			; Soma 8000 no numero negativo para poder tratar como positivo
					/       SHIFT2 					; Divido por /100 para obter a primeira palavra passada para positiva no Acumulador
					+       VOLTA_NEG    			; Soma 80 para passar a primeira palavra para positiva
					MM      UNPACK_W1          		; Copio a primeira palavra em W1;
					LD      UNPACK_OUT_ADDR1  		; Copio o endereço de saída da primeira palavra para o Acumulador
					+       MM_VAZIA     			; Combina o endereço de saída da primeira palavra com a isntrução MM
					MM      UNPACK_SALVA3      		; Tranfere a instrução completa para a posição SALVA1
					LD      UNPACK_W1          		; Copia o valor de W1 para o Acumulador
UNPACK_SALVA3      	K       /0000       			; Executa a instrução MM <valor contido em W1XADDRESS>, salvando a palavra 1 na posição de saída desejada
					LD      UNPACK_W1         		; Copia o valor de W1 para o Acumulador
					*       SHIFT2		  			; Multiplica a primeira palavra por /100 para deslocá-la duas posições para a direita
					MM      UNPACK_W1_DESLOCADA 	; Salvo a palavra 1 deslocada em W1DESLOCADA
					LD      UNPACK_PACKAGE			; Copio a palavra empacotada para o Acumulador
					-       UNPACK_W1_DESLOCADA 	; Subtraio os dois primeiros digitos da palavra empacotada para obter a segunda palavra
					MM      UNPACK_W2          		; Copio a segunda palavra em W2;
					LD      UNPACK_OUT_ADDR2  		; Copio o endereço de saída da segunda palavra para o Acumulador
					+       MM_VAZIA     			; Combina o endereço de saída da segunda palavra com a instrução MM
					MM      UNPACK_SALVA4      		; Tranfere a instrução completa para a posição SALVA1
					LD      UNPACK_W2          		; Copia o valor de W2 para o Acumulador
UNPACK_SALVA4      	K       /0000       			; Executa a instrução MM <valor contido em W1XADDRESS>, salvando a palavra 1 na posição de saída desejada
UNPACK_FIM	 		RS      UNPACK      			; Retorno da subrotina


; Subrotina MEMCOPY =============================================================================
; Subrotina que copia uma sequência de tamanho arbitrário de bytes da 
; memória de uma posição em outra. Retorna 0000 no Acumulador em caso de 
; sucesso e FFFF em caso de erro

;Variáveis da Subrotina
MEMCOPY_NWORDS 				K		/0000					; Número de palavras a serem copiadas (cópia da subrotina)
MEMCOPY_END_ORIGEM			K		/0000					; Endereço inicial da sequência de origem (cópia da subrotina)
MEMCOPY_END_DESTINO			K		/0000					; Endereço inicial da sequência de destino (cópia da subrotina)
MEMCOPY_ORIGEM_ATUAL		K		/0000					; Endereço atual que eu estou lendo	
MEMCOPY_DESTINO_ATUAL		K		/0000					; Endereço atual para onde estou copiando
MEMCOPY_CONTAGEM			K		/0000					; Número de palavras que ainda preciso copiar
MEMCOPY_OK					K		/0000					; Código de retorno de funcionamento correto
MEMCOPY_ERRO 				K		/FFFF					; Código de retorno de caso de erro 
MEMCOPY_COPIANDO 			K		/0000					; Dado que está sendo copiado
MEMCOPY_RETORNO				K		/0000					; Retorno da subrotina

;Corpo da Subrotina
MEMCOPY						K 		/0000					; Início da subrotina MEMCOPY (endereço reservado para retorno)
							; Tratando erros	
MEMCOPY_ERRO_CHK_1			LD      MEMCOPY_END_ORIGEM 		; Copio o endereço de origem para o Acumulador
							-		INVALID_ADDR			; Subtraio o endereço pelo primeiro endereço inválido 
							JN		MEMCOPY_ERRO_CHK_2		; Se for negativo, o endereço é válido e pula para o segundo check
MEMCOPY_ERRO_1_DETECTADO	LD 		MEMCOPY_ERRO            ; Se entrou aqui, o endereço é inválido. Copio o código de erro no Acumulador.
							MM 		MEMCOPY_RETORNO 		; Copio o código de erro em RETORNO
MEMCOPY_ERRO_CHK_2			LD      MEMCOPY_END_DESTINO  	; Copio o endereço de origem para o Acumulador
							-		INVALID_ADDR			; Subtraio o endereço pelo primeiro endereço inválido 
							JN		MEMCOPY_ERRO_CHK_FIM	; Se for negativo, o endereço é válido
MEMCOPY_ERRO_2_DETECTADO	LD 		MEMCOPY_ERRO            ; Se entrou aqui, o endereço é inválido. Copio o código de erro no Acumulador.
							MM 		MEMCOPY_RETORNO 		; Copio o código de erro em RETORNO
MEMCOPY_ERRO_CHK_FIM		LD 		MEMCOPY_RETORNO         ; Carrego RETORNO no Acumulador
							JZ		MEMCOPY_INICIO			; Se retorno = 0, continuo, senão pulo pro final
							JP		MEMCOPY_FIM		
							; Inicio colocando os valores iniciais das variáveis de controle
MEMCOPY_INICIO				LD      MEMCOPY_END_ORIGEM  	; Copio o endereço de origem para o Acumulador
							MM 		MEMCOPY_ORIGEM_ATUAL   	; Copio o endereço de origem para endereço que estou lendo
							LD      MEMCOPY_END_DESTINO 	; Copio o endereço de destino para o Acumulador
							MM 		MEMCOPY_DESTINO_ATUAL   ; Copio o endereço de destino para endereço que estou lendo
							;Inicia contagem			
							LD      MEMCOPY_NWORDS     		; Copio o número de palavras para o Acumulador
							MM 		MEMCOPY_CONTAGEM    	; Copio o número de palavras para CONTAGEM
							; Loop de copias			
MEMCOPY_LOOP 				JZ		MEMCOPY_FIM  			; Pula para fora do LOOP se CONTAGEM = 0
							LD 		MEMCOPY_ORIGEM_ATUAL   	; Copio o endereço atual a ser lido para o Acumulador
							+		LD_VAZIA     			; Somo o endeço atual a ser lido com a instrução de LOAD, obtendo uma instrução que lê o valor atual
							MM		MEMCOPY_COPIA_ATUAL 	; Envio a instrução que lê o valor atual para COPIAATUAL
MEMCOPY_COPIA_ATUAL			K 		/0000					; Executa instrução que lê o valor atual
							MM 		MEMCOPY_COPIANDO    	; Copia o valor atual para COPIANDO
							LD 		MEMCOPY_DESTINO_ATUAL   ; Copio o endereço atual de destino para o Acumulador
							+		MM_VAZIA     			; Somo o endereço atual de destino com a instrução de MM, obtendo uma instrução que envia para o destino atual
							MM		MEMCOPY_ENVIA_ATUAL 	; Envio a instrução que envia para o destino atual para ENVIAATUAL
							LD 		MEMCOPY_COPIANDO    	; Copio o valor atual para o Acumulador
MEMCOPY_ENVIA_ATUAL			K 		/0000					; Executa instrução que envia para o destino atual
							;Incrementando os endereços e decrementando a CONTAGEM
							LD 		MEMCOPY_ORIGEM_ATUAL 	; Incremento o endereço de origem para pegar o próximo valor a ser copiado  
							+ 		INC_ADDRESS
							MM      MEMCOPY_ORIGEM_ATUAL 
							LD 		MEMCOPY_DESTINO_ATUAL   ; Incremento o endeço de destino para que a cópia ocupa a próxima posição da sequencia
							+ 		INC_ADDRESS
							MM      MEMCOPY_DESTINO_ATUAL
							LD 		MEMCOPY_CONTAGEM		; Decremento a contagem de palavras que faltam copiar
							- 		INCREASE 				
							MM 		MEMCOPY_CONTAGEM
							JP		MEMCOPY_LOOP 			; Retorna ao Inicio do LOOP 
MEMCOPY_FIM					LD 		MEMCOPY_RETORNO			; Coloco o valor de RETORNO no Acumulador
							RS 		MEMCOPY					; Retorno da subrotina

; Subrotina CHTOI  =============================================================================
; Subrotina que converte duas words contendo caracteres ASCII hexadecimais para o numero inteiro
; correspondente.

; Variaveis de CHTOI
CHTOI_IN1		 	K       /0000       	; Endereço de entrada da primeira palavra 
CHTOI_IN2 			K       /0000       	; Endereço de entrada da segunda palavra
CHTOI_WORD	     	K       /0000       	; Word final
CHTOI_AUX 			K		/0000			; Variavel auxiliar (guarda o endereco das variavels CHTOI_DX)
CHTOI_D 			K 		/0000			; Variavel auxiliar (guarda o valor a ser salvo)
CHTOI_D1          	K       /0000       	; Digito 1 
CHTOI_D2  	     	K       /0000       	; Digito 2 
CHTOI_D3  	     	K       /0000       	; Digito 3 
CHTOI_D4  	     	K       /0000       	; Digito 4 

; Corpo da subrotina
CHTOI 						K		/0000					; Inicio da subrotina CHTOI (endereco reservado para retorno)
							LV 		CHTOI_D1 				; Guarda o endereco de CHTOI_D1 no Acumulador
							MM      UNPACK_OUT_ADDR1		; a Primeira saida de UNPACK sera salva em CHTOI_D1
							LV   	CHTOI_D2 				;
							MM 		UNPACK_OUT_ADDR2 		; a Segunda saida de UNPACK sera salva em CHTOI_D2
							LD 		CHTOI_IN1				; recebe o endereço da primeira palavra
							+ 		LD_VAZIA				; Montagem de instrucao dinamica
							MM 		WORD1					;
WORD1 						K 		/0000					; Carrega o valor da primeira palavra no Acumulador
							SC 		UNPACK 					; Execucao da subrotina UNPACK, para separar a palavra
							LV 		CHTOI_D3 				; Repeticao do processo para a segunda palavra
							MM      UNPACK_OUT_ADDR1
							LV   	CHTOI_D4
							MM 		UNPACK_OUT_ADDR2
							LD 		CHTOI_IN2				;
							+ 		LD_VAZIA
							MM 		WORD2
WORD2 						K 		/0000
							SC 		UNPACK
; Inicio das conversoes de hexa para inteiros
CHTOI_DIG1					LV 		CHTOI_D1 				; Endereço de CHTOI_D1 para Acumulador
							MM 		CHTOI_AUX 				; Salva o endereço de CHTOI_D1 em CHTOI_AUX
							LD 		CHTOI_D1 				; Carrega o valor de CHTOI_D1 no Acumulador
							JP		CHTOI_TESTE 			; Jump para CHTOI_TESTE
CHTOI_DIG2					LV 		CHTOI_D2 				; Analogo a CHTOI_DIG1
							MM 		CHTOI_AUX
							LD 		CHTOI_D2
							JP		CHTOI_TESTE
CHTOI_DIG3					LV 		CHTOI_D3 				; Analogo a CHTOI_DIG1
							MM 		CHTOI_AUX
							LD 		CHTOI_D3
							JP		CHTOI_TESTE
CHTOI_DIG4					LV 		CHTOI_D4 				; Analogo a CHTOI_DIG1
							MM 		CHTOI_AUX
							LD 		CHTOI_D4
							JP		CHTOI_TESTE
CHTOI_TESTE					-		CH_1 					; Subtrai-se 0040H para verificar se o digito esta entre 30-3F ou 41-46
							JZ		CHTOI_ERRO				; Se o digito 40H, o caracter é inválido
							JN		CHTOI_0F				; Se o resultado no acumulador for negativo, o digito esta entre 30-3F
							-		CH_3 					; Senao, o digito eh maior que 41, subtrai-se 0007H
							JN		CHTOI_AF 				; Se o resultado for negativo, esta entre 41 e 46 (ou seja, esta entre A-F em ASCII)
							JP		CHTOI_ERRO 				; Senao eh caracter invalido
CHTOI_0F					+		CH_2 					; Soma-se 0006H
							JN		CHTOI_09 				; Se o resultado for negativo, esta entre 0-9 (ASCII)
							JP		CHTOI_ERRO				; Senao eh caracter invalido (esta entre 3A-3F)
CHTOI_09					-		CH_2 					; Subtrai-se o valor 0006H que foi adicionado anteriormente
							+		CH_4 					; Soma-se 0010H e obtem-se o inteiro de 0 a 9
							MM 		CHTOI_D 				; Salva o resultado em CHTOI_D
							LD 		CHTOI_AUX 				; Carrega o endereço salvo em CHTOI_AUX
							+ 		MM_VAZIA 				; Montagem de instrucao dinamica (Salvar o resultado na memoria do digito)
							MM 		CHTOI_SAVE 				
							LD 		CHTOI_D
							JP		CHTOI_SAVE
CHTOI_AF					+		CH_4 					; Soma-se 0010H e obtem-se o inteiro de A-F
							MM 		CHTOI_D 				; Salva o resultado em CHTOI_D
							LD 		CHTOI_AUX				; Carrega o endereço salvo em CHTOI_AUX
							+ 		MM_VAZIA 				; Montagem de instrucao dinamica (Salvar o resultado na memoria do digito)
							MM 		CHTOI_SAVE
							LD 		CHTOI_D
							JP		CHTOI_SAVE
CHTOI_SAVE					K 		/0000 					; Executa a instrução montada dinamicamente (Salvar o dado presente no acumulador nas variaveis CHTOI_Dx)
							LV 		CHTOI_D1 				; Carrega o endereco de CHTOI_D1
							- 		CHTOI_AUX				; Se for igual ao salvo em CHTOI_AUX,
							JZ 		CHTOI_DIG2				; Executa-se CHTOI_DIG2
							LV 		CHTOI_D2 				; Carrega o endereco de CHTOI_D2
							- 		CHTOI_AUX 				; Se for igual ao salvo em CHTOI_AUX,
							JZ 		CHTOI_DIG3				; Executa-se CHTOI_DIG3
							LV 		CHTOI_D3 				; Carrega o endereco de CHTOI_D3
							- 		CHTOI_AUX 				; Se for igual ao salvo em CHTOI_AUX,
							JZ 		CHTOI_DIG4	 			; Executa-se CHTOI_DIG4
							LV 		CHTOI_D4 				; Carrega o endereco de CHTOI_D4
							- 		CHTOI_AUX 				; Se for igual ao salvo em CHTOI_AUX,
							JZ 		CHTOI_FIM 				; Executa-se CHTOI_FIM
CHTOI_FIM					LV    	/0000					; Carrego o valor 0
							MM      CHTOI_WORD				; Coloco inicialmente 0 na saída
							LD 		CHTOI_D1 				; Carrega o primeiro digito
							* 		CH_6 					; Multiplica por 1000H
							+ 		CHTOI_WORD 				; Soma-se com a variavel de saida
							MM 		CHTOI_WORD				; Armazena o resultado
							LD 		CHTOI_D2 				; Carrega o segundo digito
							* 		CH_5 					; Multiplica por 0100H
							+		CHTOI_WORD 				; Soma-se com a variavel de saida
							MM 		CHTOI_WORD 				; Armazena o resultado
							LD 		CHTOI_D3 				; Carrega o terceiro digito
							* 		CH_4 					; Multiplica por 0010H
							+ 		CHTOI_WORD 				; Soma-se com a variavel de saida
							MM 		CHTOI_WORD 				; Armazena o resultado
							LD 		CHTOI_D4 				; Carrega o quarto digito
							+ 		CHTOI_WORD 				; Soma-se com a variavel de saida
							MM 		CHTOI_WORD 				; Salva o resultado
							RS 		CHTOI 					; Saida da subrotina
CHTOI_ERRO					LD 		CH_E 					; Carrega /FFFF (indica erro) no acumulador
							RS 		CHTOI 					; Sai do programa
							#		PACK				
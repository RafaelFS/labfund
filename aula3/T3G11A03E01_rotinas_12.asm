; T3G11A03E01_rotinas_12.asm
; Arquivo que contém as rotinas desenvolvidas nas aulas anteriores
			&       /0000
;Exportando PACK  ==================================================================
PACK        >                   ; Sub-rotina PACK
PACK_VAR1   >                   ; Endereço da primeira palavra a ser empacotada
PACK_VAR2   >                   ; Endereço da segunda palabra a ser empacotada


;Importando constantes ===========================================================
SHIFT2	    <                   ; Constante que desloca em 2 posições os bits das palavras
LDVAZIA     <                   ; Instrução
TRATANEG	>
VOLTANEG 	>
MM_VAZIA	>
LD_VAZIA	>
INC_ADDRESS >
INCREASE	>


; Subrotina PACK ===============================================================================
; Recebe o endereço de duas palavras e retorna no Acumulador a composição entre as duas

; Variáveis de PACK
PACK_VAR1   K /0000     ; Variavel do programa
PACK_VAR2   K /0000     ; Variavel do programa
; Corpo de PACK
PACK        K /0000             ; Sub-rotina PACK
			LD      PACK_VAR1   ; Recebe o endereco de IN1 (conteudo de PACK_VAR1)
			+       LDVAZIA     ; Soma com (8000H)
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
					#       INI		
		



;Variáveis da subrotina
SNWORDS     K       /0000       ; Número de palavras a serem copiadas (cópia da subrotina)
SENDORIGEM  K       /0000       ; Endereço inicial da sequência de origem (cópia da subrotina)
SENDDESTINO K       /0000       ; Endereço inicial da sequência de destino (cópia da subrotina)
SORIATUAL   K       /0000       ; Endereço atual que eu estou lendo 
SDESATUAL   K       /0000       ; Endereço atual para onde estou copiando
CONTAGEM    K       /0000       ; Número de palavras que ainda preciso copiar
OK          K       /0000       ; Código de retorno de funcionamento correto
ERRO        K       /FFFF       ; Código de retorno de caso de erro 
MMVAZIA     MM      /0000       ; Código com MM vazia
LDVAZIA     LD      /0000       ; Código com LD vazia
COPIANDO    K       /0000       ; Dado que está sendo copiado
INCADDRESS  K       /0002       ; Constante de incremento de endereço
DECCONT     K       /0001       ; Constante de decremento de contagem

;Corpo da Subrotina
MEMCOPY     K       /0000       ; Início da subrotina MEMCOPY (endereço reservado para retorno)
			;Inicio colocando os valores iniciais das variáveis de controle
			LD      SENDORIGEM  ; Copio o endereço de origem para o Acumulador
			MM      SORIATUAL   ; Copio o endereço de origem para endereço que estou lendo
			LD      SENDDESTINO ; Copio o endereço de destino para o Acumulador
			MM      SDESATUAL   ; Copio o endereço de destino para endereço que estou lendo
			LD      SNWORDS     ; Copio o número de palavras para o Acumulador
			MM      CONTAGEM    ; Copio o número de palavras para CONTAGEM
			; Loop de copias
LOOP        JZ      FIMMEMCOPY  ; Pula para fora do LOOP se CONTAGEM = 0
			LD      SORIATUAL   ; Copio o endereço atual a ser lido para o Acumulador
			+       LDVAZIA     ; Somo o endeço atual a ser lido com a instrução de LOAD, obtendo uma instrução que lê o valor atual
			MM      COPIAATUAL  ; Envio a instrução que lê o valor atual para COPIAATUAL
COPIAATUAL  K       /0000       ; Executa instrução que lê o valor atual
			MM      COPIANDO    ; Copia o valor atual para COPIANDO
			LD      SDESATUAL   ; Copio o endereço atual de destino para o Acumulador
			+       MMVAZIA     ; Somo o endereço atual de destino com a instrução de MM, obtendo uma instrução que envia para o destino atual
			MM      ENVIAATUAL  ; Envio a instrução que envia para o destino atual para ENVIAATUAL
			LD      COPIANDO    ; Copio o valor atual para o Acumulador
ENVIAATUAL  K       /0000       ; Executa instrução que envia para o destino atual
			;Incrementando os endereços e decrementando a CONTAGEM
			LD      SORIATUAL   
			+       INCADDRESS
			MM      SORIATUAL
			LD      SDESATUAL   
			+       INCADDRESS
			MM      SDESATUAL
			LD      CONTAGEM
			-       DECCONT
			MM      CONTAGEM
			JP      LOOP        ; Retorna ao Inicio do LOOP 
FIMMEMCOPY  LD      OK          ; Coloco o código de OK no Acumulador
			RS      MEMCOPY     ; Retorno da subrotina
			#       INI
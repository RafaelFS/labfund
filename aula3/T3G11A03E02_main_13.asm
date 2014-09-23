;Importando PACK  ==================================================================
PACK        		<           ; Sub-rotina PACK
PACK_VAR1   		<           ; Endereço da primeira palavra a ser empacotada
PACK_VAR2   		<           ; Endereço da segunda palabra a ser empacotada

;Importando UNPACK  =======================================================================
UNPACK        		<           ; Sub-rotina UNPACK
UNPACK_OUT_ADDR1  	<	     	; Endereço de saída da primeira palavra 
UNPACK_OUT_ADDR2 	<       	; Endereço de saída da segunda palavra 
UNPACK_PACKAGE     	<         	; Word empacotada

;Importando MEMCOPY =======================================================================
MEMCOPY       		<           ; Sub-rotina MEMCOPY
MEMCOPY_NWORDS 		< 			; Número de palavras a serem copiadas (cópia da subrotina)
MEMCOPY_END_ORIGEM	<			; Endereço inicial da sequência de origem (cópia da subrotina)
MEMCOPY_END_DESTINO	<			; Endereço inicial da sequência de destino (cópia da subrotina)

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

						& 		/0000				; Inicio do programa em 0000
INI						JP 		MAIN_PACK			; Pula para a label MAIN_PACK
ENTRADA_PACK_1 			K 		/00FA				; Primeira palavra de entrada para PACK
ENTRADA_PACK_2 			K 		/0010				; Segunda palavra de entrada para PACK
SAIDA_PACK 				K 		/0000				; Saida de PACK
ENTRADA_UNPACK			K		/8001				; Palavra de entrada de UNPACK
SAIDA_UNPACK_1			K		/0000				; Primeira palavra de saída de UNPACK
SAIDA_UNPACK_2			K		/0000				; Segunda palavra de sáida para UNPACK
NWORDS_MEMCOPY			K		/0003				; Número de palavras que serão copiadas por MEMCOPY
END_ORIGEM_MEMCOPY		K		/0014				; Endereço da primeira palavra da lista a ser copiada por MEMCOPY
END_DESTINO_MEMCOPY		K		/001C				; Primeiro endereço para o qual as palavras serão copiads por MEMCOPY
MEMORIA_MEMCOPY			K		/0001				; Endereços de 0014 a 0024 reservados para utilização MEMCOPY. Os valores foram escolhidos para verificação dos testes 
						K		/0002
						K		/0003
						K		/0004
						K		/FFFF
						K		/FFFF
						K		/FFFF
						K		/FFFF
						K		/FFFF						
; Corpo do teste de funcionamento de PACK
MAIN_PACK				LV 		ENTRADA_PACK_1		; Recebe o endereco de memoria de ENTRADA_PACK_1
						MM 		PACK_VAR1			; Salva o endereco na memoria PACK_VAR1
						LV 	 	ENTRADA_PACK_2		; Recebe o endereco de memoria de ENTRADA_PACK_2
						MM 		PACK_VAR2			; Salva o endereco na memoria PACK_VAR2
						SC 		PACK 				; Chama a sub-rotina PACK
						MM 		SAIDA_PACK			; Salva o resultado na saida (SAIDA_PACK)
; Corpo do teste de funcionamento de UNPACK
MAIN_UNPACK				LV		SAIDA_UNPACK_1 		; Coloca o endereço de SAIDA_UNPACK_1 no Acumulador
						MM 		UNPACK_OUT_ADDR1	; Copia o conteúdo do Acumulador para UNPACK_OUT_ADDR1
						LV		SAIDA_UNPACK_2 		; Coloca o endereço de SAIDA_UNPACK_2 no Acumulador
						MM 		UNPACK_OUT_ADDR2	; Copia o conteúdo do Acumulador para UNPACK_OUT_ADDR2
						LD		ENTRADA_UNPACK 		; Copia o conteúdo de ENTRADA_UNPACK para o Acumulador
						SC  	UNPACK      		; Executa a subrotina UNPACK
; Corpo do teste de funcionamento de MEMCOPY
MAIN_MEMCOPY			LD 		NWORDS_MEMCOPY		; Copia o conteúdo de número de palavras para o Acumulador
						MM 		MEMCOPY_NWORDS		; Copia o conteúdo de número de palvaras para MEMCOPY_NWORDS, parâmetro da subrotina
						LD 		END_ORIGEM_MEMCOPY	; Copia o conteúdo de END_ORIGEM_MEMCOPY para o Acumulador
						MM 		MEMCOPY_END_ORIGEM	; Copia o endereço de origem para MEMCOPY_END_ORIGEM, parâmetro da subrotina
						LD 		END_DESTINO_MEMCOPY	; Copia o conteúdo de END_DESTINO_MEMCOPY para o Acumulador
						MM 		MEMCOPY_END_DESTINO	; Copia o endereço de destino para MEMCOPY_END_DESTINO, parâmetro da subrotina
						SC  	MEMCOPY     		; Executa a subrotina MEMCOPY 						
FIM						HM 		FIM					; FIM
						# 		INI					; Indica o fim do programa (Pseudo-comando)

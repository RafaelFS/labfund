; Subrotina DUMPER
; Grava em arquivo toda a imagem binária da memória
			&       /0000
;Exportando DUMPER  ==================================================================
DUMPER 		>  
DUMP_INI 	>	; Endereço onde começa o dump
DUMP_TAM 	>	; Numero total de palavras a serem "dumpadas"
DUMP_UL 	>	; Unidade logica do disco a ser usado
DUMP_BL 	>	; Tamanho do bloco
DUMP_EXE 	>	; Endereço onde começaria a execução (valor dummy, apenas para manter o formato)


; Constantes usadas em DUMPER =========================================
INC_ADDRESS		K		/0002		; Constante de incremento de endereço
INVALID_ADDR	K		/1000       ; Constante de endereço invalido. Qualquer endereço igual ou maior que ele é inválido
LD_VAZIA    	LD 		/0000		; Load vazia para criação de intruções dinamicamente
INCREASE		K 		/0001		; Constante de decremento de contagem

PD_DISCO_VAZIA	PD 		/300 		; Put Data apenas com o tipo disco especificado 

; Variáveis de DUMPER ================================================================
DUMP_INI 		K 		/0000			; Endereço onde começa o dump
DUMP_TAM 		K 		/0000			; Numero total de palavras a serem "dumpadas"
DUMP_UL 		K 		/0000			; Unidade logica do disco a ser usado
DUMP_BL 		K 		/0000			; Tamanho do bloco
DUMP_EXE 		K 		/0000			; Endereço onde começaria a execução (valor dummy, apenas para manter o formato)
DUMP_END_ATUAL	K 		/0000			; Endereço atual que será "dumpado"
DUMP_CONTADOR	K 		/0000
DUMP_PD			K 		/0000

DUMPER 			K 		/0000
				LD 		DUMP_INI		; Pego o Endereço inicial e guardo como o endereço atual
				MM 		DUMP_END_ATUAL
				LD 		DUMP_UL			; Crio a instrução de PD com a Unidade Lógica atual
				+		PD_DISCO_VAZIA
				MM 		DUMP_PD         ; Salvo em todos os lugares em que ela é usada
				
				MM 		DUMP_PD_LOOP	


				MM 		DUMP_SAVE_INI    ; DUMP da posição inicial	
				LD 		DUMP_INI
DUMP_SAVE_INI	K 		/0000			
				
				LD 		DUMP_PD				; DUMP do numero total de palavras	
				MM 		DUMP_SAVE_TAM    
				LD 		DUMP_TAM
DUMP_SAVE_TAM	K 		/0000		

										; Salvo a instrução de dump no 

DUMP_LOOP		LD		DUMP_CONTADOR 	; Pego o CONTADOR atual e verifico se é igual ao tamanho DUMP_TAM. Se é igual, então acabou e vai para o final da Subrotina
				-		DUMP_TAM		
				JZ 		DUMP_FIM		
				LD		DUMP_END_ATUAL	; Se não acabou, pego o valor presente no endereço atual (com a ajuda de um load criado dinamicamente)
				+		LD_VAZIA
				MM 		DUMP_GET_VALOR
DUMP_GET_VALOR	K		/0000			
DUMP_PD_LOOP	K		/0000			; Salvo no disco
				LD		DUMP_END_ATUAL  ; Incremento o endereço atual
				+		INC_ADDRESS
				MM 		DUMP_END_ATUAL
				LD 		DUMP_CONTADOR	; Incremento o contador e volto ao início
				+		INCREASE 	
				MM 		DUMP_CONTADOR
				JP 		DUMP_LOOP
DUMP_FIM		RS 		DUMPER
				#		DUMPER
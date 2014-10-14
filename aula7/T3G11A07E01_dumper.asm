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

; Variáveis de DUMPER ================================================================
DUMP_INI 		K 		/0000			; Endereço onde começa o dump
DUMP_TAM 		K 		/0000			; Numero total de palavras a serem "dumpadas"
DUMP_UL 		K 		/0000			; Unidade logica do disco a ser usado
DUMP_BL 		K 		/0000			; Tamanho do bloco
DUMP_EXE 		K 		/0000			; Endereço onde começaria a execução (valor dummy, apenas para manter o formato)
DUMP_END_ATUAL	K 		/0000			; Endereço atual que será "dumpado"

; Constantes usadas em DUMPER
INC_ADDRESS		K		/0002		; Constante de incremento de endereço
INVALID_ADDR	K		/1000       ; Constante de endereço invalido. Qualquer endereço igual ou maior que ele é inválido
LD_VAZIA    	LD 		/0000		; Load vazia para criação de intruções dinamicamente


DUMPER 			K 		/0000
				LD 		DUMP_INI		; Pego o Endereço inicial e guardo como o endereço atual
				MM 		DUMP_END_ATUAL
DUMP_LOOP		LD		DUMP_END_ATUAL 	; Pego o Endereço atual e verifico se é igual ao endereço invalido. Se é igual, então acabou e vai para o final da Subrotina
				-		INVALID_ADDR		
				JZ 		DUMP_FIM		
				LD		DUMP_END_ATUAL	; Se não acabou, pego o valor presente no endereço atual (com a ajuda de um load criado dinamicamente)
				+		LD_VAZIA
				MM 		DUMP_GET_VALOR
DUMP_GET_VALOR	K		/0000			
				PD		/300			; Salvo no disco
				LD 		DUMP_END_ATUAL	; Incremento o endereço e volto ao início
				+		INC_ADDRESS 	
				MM 		DUMP_END_ATUAL
				JP 		DUMP_LOOP
DUMP_FIM		RS 		DUMPER
				#		DUMPER
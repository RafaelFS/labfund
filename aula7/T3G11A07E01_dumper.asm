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


DUMPER 			K 		/0000
				LV 		DUMP_INI

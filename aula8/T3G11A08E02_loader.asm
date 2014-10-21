; Subrotina LOADER
; Grava na memória os dados presentes em um arquivo
					&       /0000
;Exportando LOADER  ==================================================================
LOADER 		>  
LOADER_UL 	>	


; Variáveis de LOADER ================================================================
LOADER_UL 			K 		/0000			; Unidade logica do disco a ser lido
LOADER_INI 			K 		/0000			; Endereço onde começa o load
LOADER_TAM 			K 		/0000			; Numero total de palavras a serem lidas
LOADER_BL 			K 		/0000			; Tamanho do bloco
LOADER_EXE 			K 		/0000			; Endereço onde começaria a execução (valor dummy, apenas para manter o formato)
LOADER_END_ATUAL	K 		/0000			; Endereço atual que será "dumpado"
LOADER_CONTADOR		K 		/0000			; Contador que armazena o número de palavras a serem lidas
LOADER_GD  			K		/0000			; Intrução de Get Data montada com a unidade lógica atual
LOADER_OUT			K 		/0000			; Mensagem de saída do loader

; Constantes usadas em LOADER
INC_ADDRESS			K		/0002		; Constante de incremento de endereço
INVALID_ADDR		K		/1000       ; Constante de endereço invalido. Qualquer endereço igual ou maior que ele é inválido
LD_VAZIA    		LD 		/0000		; Load vazia para criação de intruções dinamicamente
INCREASE			K 		/0001		; Constante de decremento de contagem
	
GD_VAZIA_D			GD 		/300 		; Get Data apenas com o tipo disco especificado 
NAO_CABE			K 		/FFFE			
	
LOADER				K 		/0000
					LD 		LOADER_UL		; Crio a instrução de GD com a Unidade Lógica atual
					+		GD_VAZIA_D	
					MM 		LOADER_GD       ; Salvo-a em todos os lugares em que ela é usada
	
					LD 		LOADER_GD 		; Obtenho do arquivo o endereço inicial e salvo na variável correspondente
					MM      LOADER_SAVE_INI		
LOADER_SAVE_INI		K		/0000			
					MM 		LOADER_INI

					LD 		LOADER_GD 		; Obtenho do arquivo o numero total de palavras e salvo na variável correspondente
					MM      LOADER_SAVE_TAM		
LOADER_SAVE_TAM		K		/0000			
					MM 		LOADER_TAM

					LD 		NAO_CABE		; Inicio saída com a mensagem que não cabe
					MM 		LOADER_OUT      
					LD 		LOADER_TAM 		; Comparo o ultimo endereço a ser ocupado (endereço inicial + (nwords-1)*espaço_de_um_endereço) com o endereço invalido...
					-       INCREASE
					*		INC_ADDRESS
					+		LOADER_INI
					- 		INVALID_ADDR
					JN		LOADER_COUBE	; Se for menor, cabe
					JP		LOADER_FIM		; Se não, pulo para o fim
LOADER_COUBE		LV 		/AAA
					MM 		LOADER_OUT
LOADER_FIM			LD 		LOADER_OUT
					RS 		LOADER
					#		LOADER

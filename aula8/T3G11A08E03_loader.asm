; Subrotina LOADER
; Grava na memória os dados presentes em um arquivo
					&       /0000
;Exportando LOADER  ==================================================================
LOADER 		>  
LOADER_UL 	>	


; Variáveis de LOADER ================================================================
LOADER_UL 			K 		/0000				; Unidade logica do disco a ser lido
LOADER_INI 			K 		/0000				; Endereço onde começa o load
LOADER_TAM 			K 		/0000				; Numero total de palavras a serem lidas
LOADER_BL 			K 		/0000				; Tamanho do bloco
LOADER_EXE 			K 		/0000				; Endereço onde começaria a execução (valor dummy, apenas para manter o formato)
LOADER_END_ATUAL	K 		/0000				; Endereço atual que será "dumpado"
LOADER_CONTADOR		K 		/0000				; Contador que armazena o número de palavras a serem lidas
LOADER_GD  			K		/0000				; Intrução de Get Data montada com a unidade lógica atual
LOADER_OUT			K 		/0000				; Mensagem de saída do loader
LOADER_CS_OBTIDO	K 		/0000				; Checksum calculado pelo loader
LOADER_CS_ORIGINAL	K		/0000				; Checksum fornecido no arquivo de dump
LOADER_END_BLOCO	K 		/0000				; Salva o endereço inicial do bloco atual
; Constantes usadas em LOADER ===============================================
INC_ADDRESS			K		/0002				; Constante de incremento de endereço
INVALID_ADDR		K		/1000       		; Constante de endereço invalido. Qualquer endereço igual ou maior que ele é inválido
LD_VAZIA    		LD 		/0000				; Load vazia para criação de intruções dinamicamente
MM_VAZIA			MM      /0000				; Move to memory vazia para criação de instrução dinamicamente
INCREASE			K 		/0001				; Constante de decremento de contagem
			
GD_VAZIA_D			GD 		/300 				; Get Data apenas com o tipo disco especificado 
NAO_CABE			K 		/FFFE				; Mensagem de erro que indica que o dump não cabe na memória
NAO_CONFERE			K 		/FFFC				; Mensagem de erro que indica que o checksum não confere
	
LOADER				K 		/0000
					LD 		LOADER_UL				; Crio a instrução de GD com a Unidade Lógica atual
					+		GD_VAZIA_D			
					MM 		LOADER_GD       		; Salvo-a em todos os lugares em que ela é usada
			
					LD 		LOADER_GD 				; Obtenho do arquivo o endereço inicial e salvo na variável correspondente
					MM      LOADER_GET_INI				
LOADER_GET_INI		K		/0000					
					MM 		LOADER_INI		
		
					LD 		LOADER_GD 				; Obtenho do arquivo o numero total de palavras e salvo na variável correspondente
					MM      LOADER_GET_TAM				
LOADER_GET_TAM		K		/0000					
					MM 		LOADER_TAM		
		
					LD 		NAO_CABE				; Inicio saída com a mensagem que não cabe
					MM 		LOADER_OUT      		
					LD 		LOADER_TAM 				; Comparo o ultimo endereço a ser ocupado (endereço inicial + (nwords-1)*espaço_de_um_endereço) com o endereço invalido...
					-       INCREASE		
					*		INC_ADDRESS		
					+		LOADER_INI		
					- 		INVALID_ADDR		
					JN		LOADER_COUBE			; Se for menor, cabe
					JP		LOADER_FIM				; Se não, pulo para o fim
		
LOADER_COUBE		LD  	LOADER_TAM 				; Inicio o contador com o número total de words
					MM 		LOADER_CONTADOR		
					LD 		LOADER_INI 				; Inicio o endereço atual com o endereço inicial
					MM 		LOADER_END_ATUAL		 	
		
LOADER_LOOP_FILE	LD 		LOADER_CONTADOR 		; Verifico se o contador é zero. Se for, vou para o fim          
					JZ		LOADER_FIM_OK		
													; Senão, inicio o salvar do proximo bloco
LOADER_BLOCK_START	LV 		/0000					; Reseto o checksum calculado
					MM      LOADER_CS_OBTIDO    	
	
					LD 		LOADER_GD 				; Obtenho o endereço inicial do bloco
					MM      LOADER_GET_BLK_END				
LOADER_GET_BLK_END	K		/0000					
					MM 		LOADER_END_BLOCO	
															
					LD 		LOADER_GD 				; Obtenho o tamanho do bloco
					MM      LOADER_GET_BLK_TAM				
LOADER_GET_BLK_TAM	K		/0000					
					MM 		LOADER_BL

					LD 		LOADER_END_BLOCO 		; Seto o endereço atual com o endereço inicial do bloco
					MM 		LOADER_END_ATUAL

LOADER_BLK_LOOP		LD      LOADER_GD				; Vou ler os dados do bloco
					MM 		LOADER_GET_WORD	
					LD 		LOADER_END_ATUAL	
					+ 		MM_VAZIA	
					MM 		LOADER_SAVE_WORD	
LOADER_GET_WORD     K		/0000					; Para tanto, uso GD e MM criadas dinamicamente	
LOADER_SAVE_WORD	K  		/0000	
					MM 		LOADER_OUT 				; Salvo o valor atual como saída da subrotina
					
					+ 		LOADER_CS_OBTIDO 		; Adiciono o valor atual ao Checksum
					MM 		LOADER_CS_OBTIDO

					LD 		LOADER_END_ATUAL		; Atualizo o endereço, o contador e o tamanho do bloco restante
					+ 		INC_ADDRESS	
					MM 		LOADER_END_ATUAL	
					LD 		LOADER_CONTADOR	
					-		INCREASE	
					MM 		LOADER_CONTADOR	
					LD 		LOADER_BL
					- 		INCREASE
					MM 		LOADER_BL

					LD 		LOADER_BL 				; Se tamanho do bloco restante é 0, pulo para o fim do bloco 
					JZ 		LOADER_BLK_END						
					JP 		LOADER_BLK_LOOP         ; Senão, continuo a ler os dados do bloco
LOADER_BLK_END		LD 		LOADER_GD				; Antes de terminar, pego o checksum indicado no arquivo
					MM      LOADER_GET_CS				
LOADER_GET_CS		K		/0000					
					MM 		LOADER_CS_ORIGINAL

					-		LOADER_CS_OBTIDO 		; Já estou com o valor do Checksum obtido no arquivo então subtraio do calculado
					JZ      LOADER_LOOP_FILE 		; Se for 0, tudo ok e retorno ao inicio do loop do arquivo
					LD 		NAO_CONFERE 			; Se não for 0, houve algum erro e coloco o valor do erro de checksum na sáida
					MM 		LOADER_OUT
					JP 		LOADER_FIM              ; Com o erro, pulo direto para o fim da subrotina

LOADER_FIM_OK  	 	LD 		LOADER_GD				; Antes de terminar, pego o endereço da primeira instrução executável e coloco na saída
					MM      LOADER_GET_EXE				
LOADER_GET_EXE		K		/0000					
					MM 		LOADER_OUT

LOADER_FIM			LD 		LOADER_OUT	
					RS 		LOADER	
					#	LOADER	
	
	
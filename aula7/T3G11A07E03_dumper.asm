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

PD_VAZIA_D		PD 		/300 		; Put Data apenas com o tipo disco especificado 

; Variáveis de DUMPER ================================================================
DUMP_INI 		K 		/0000			; Endereço onde começa o dump
DUMP_TAM 		K 		/0000			; Numero total de palavras a serem "dumpadas"
DUMP_UL 		K 		/0000			; Unidade logica do disco a ser usado
DUMP_BL 		K 		/0000			; Tamanho do bloco
DUMP_EXE 		K 		/0000			; Endereço onde começaria a execução (valor dummy, apenas para manter o formato)
DUMP_END_ATUAL	K 		/0000			; Endereço atual que será "dumpado"
DUMP_CONTADOR	K 		/0000
DUMP_PD			K 		/0000
DUMP_CHECKSUM	K		/0000
DUMP_BL_ATUAL	K		/0000

DUMPER 			K 		/0000
				LD 		DUMP_INI		; Pego o Endereço inicial e guardo como o endereço atual
				MM 		DUMP_END_ATUAL
				
				LD 		DUMP_TAM		; Pego o numero de palavras e guardo como contador atual
				MM 		DUMP_CONTADOR

				LD 		DUMP_UL			; Crio a instrução de PD com a Unidade Lógica atual
				+		PD_VAZIA_D	
				
				MM 		DUMP_PD         ; Salvo em todos os lugares em que ela é usada
				MM 		DUMP_PD_LOOP	


				MM 		DUMP_SAVE_INI    ; DUMP da posição inicial	
				LD 		DUMP_INI
DUMP_SAVE_INI	K 		/0000			
				
				LD 		DUMP_PD				; DUMP do numero total de palavras	
				MM 		DUMP_SAVE_TAM    
				LD 		DUMP_TAM
DUMP_SAVE_TAM	K 		/0000		

										

DUMP_LOOP_DUMP  LD		DUMP_CONTADOR 	; Pego o CONTADOR atual e verifico se é igual a 0. Se é igual, então acabou e vai para o final da Subrotina		
				JZ 		DUMP_FIM		

				LV		/0000			; Se não acabou, zero o CHECKSUM
				MM 		DUMP_CHECKSUM

				LD 		DUMP_PD			; Dou dump no endereço atual (endereço inicial do bloco)
				MM 		DUMP_SAVE_ADDR    
				LD 		DUMP_END_ATUAL
DUMP_SAVE_ADDR	K 		/0000
				+		DUMP_CHECKSUM 	; Somo o valor do endereço atual com CHECKSUM e salvo o novo CHECKSUM
				MM 		DUMP_CHECKSUM 

				LD 		DUMP_CONTADOR		; Se contador < tamanho do bloco (DUMP_BL) o tamanho é o proprio contador. Se não, é o tamanho max DUMP_BL
				- 		DUMP_BL
				JN		DUMP_BMIN	
				
				LD 		DUMP_PD			; Se estou aqui, contador > bloco e dumpo o tamanho do bloco max
				MM 		DUMP_SAVE_BMAX    				
				LD 		DUMP_BL
DUMP_SAVE_BMAX	K 		/0000
				
				+		DUMP_CHECKSUM 	; Somo esse valor do tamanho do bloco com CHECKSUM e salvo o novo CHECKSUM
				MM 		DUMP_CHECKSUM 

				LD 	 	DUMP_BL
				MM 		DUMP_BL_ATUAL
				JP		DUMP_BLK_LOOP	

DUMP_BMIN 		LD 		DUMP_PD			; Se estou aqui, contador < bloco e dumpo o tamanho do contador e o salvo como tamanho do bloco
				MM 		DUMP_SAVE_BMIN    
				LD 		DUMP_CONTADOR
DUMP_SAVE_BMIN	K 		/0000

				+		DUMP_CHECKSUM 	; Somo o valor do tamanho do bloco com CHECKSUM e salvo o novo CHECKSUM
				MM 		DUMP_CHECKSUM 

				LD 		DUMP_CONTADOR
				MM 		DUMP_BL_ATUAL

DUMP_BLK_LOOP	LD 		DUMP_BL_ATUAL 		; Se DUMP_BL_ATUAL for 0, já li todo o bloco, então salvo o checksum e volto para iniciar outro bloco		
				JZ		DUMP_CSUM_LOAD
				JP		DUMP_VALOR_DUMP		; Senão pulo para continuação
DUMP_CSUM_LOAD	LD 		DUMP_PD				; Se estou aqui,  dumpo o CHECKSUM
				MM 		DUMP_SAVE_CSUM    
				LD 		DUMP_CHECKSUM
DUMP_SAVE_CSUM	K 		/0000			
				JP		DUMP_LOOP_DUMP

DUMP_VALOR_DUMP	LD		DUMP_END_ATUAL	; Pego no valor presente no endereço atual (com a ajuda de um load criado dinamicamente)
				+		LD_VAZIA
				MM 		DUMP_GET_VALOR
DUMP_GET_VALOR	K		/0000		
DUMP_PD_LOOP	K		/0000			; Salvo esse valor no disco com a instrução gerada no início

				+		DUMP_CHECKSUM 	; Somo esse valor com CHECKSUM e salvo o novo CHECKSUM
				MM 		DUMP_CHECKSUM 	

				LD		DUMP_END_ATUAL  ; Incremento o endereço atual
				+		INC_ADDRESS
				MM 		DUMP_END_ATUAL

				LD 		DUMP_BL_ATUAL	; Decremento o tamanho do bloco 
				-		INCREASE
				MM      DUMP_BL_ATUAL

				LD 		DUMP_CONTADOR	; Decremento o contador geral e volto ao início
				-		INCREASE 	
				MM 		DUMP_CONTADOR
				
				JP 		DUMP_BLK_LOOP

DUMP_FIM		LD 		DUMP_PD			; Antes do fim, dou dump no endereço da primeira instrução executável
				MM 		DUMP_SAVE_EXE    
				LD 		DUMP_EXE
DUMP_SAVE_EXE 	K 		/0000				
				RS 		DUMPER
				#		DUMPER
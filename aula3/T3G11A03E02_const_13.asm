				& 		/0000
;Exportando as constantes ================================================================
SHIFT1			>
SHIFT2			>
TRATA_NEG		>
VOLTA_NEG 		>
MM_VAZIA		>
LD_VAZIA		>
INC_ADDRESS 	>
INCREASE		>
INVALID_ADDR	>
CHECK_DIGITO	>
DIGITO_TO_HEX	> 		
LETRA_TO_HEX	>		
;Definição e valores das contantes =============================================================
SHIFT1			K		/0010		; Constante que desloca em 1 posição os bits das palavras
SHIFT2			K 		/0100		; Constante que desloca em 2 posições os bits das palavras
TRATA_NEG		K		/8000		; Constante utilizada para passar um numero negativo para um positivo
VOLTA_NEG		K		/0080		; Constante utilizada para voltar o número para negativo
MM_VAZIA		MM      /0000		; Move to memory vazia para criação de instrução dinamicamente
LD_VAZIA    	LD 		/0000		; Load vazia para criação de intruções dinamicamente
INC_ADDRESS		K		/0002		; Constante de incremento de endereço
INCREASE		K 		/0001		; Constante de decremento de contagem
INVALID_ADDR	K		/1000       ; Constante de endereço invalido. Qualquer endereço igual ou maior que ele é inválido
CHECK_DIGITO	K 		/000A		; Constante utilizada para checar se é digito (se você subtrair e for positivo, é letra)
DIGITO_TO_HEX	K 		/0030		; Constante que, somada com um digito, dá o seu código ASCII
LETRA_TO_HEX	K		/0037		; Constante que, somada com uma letra, dá o seu código ASCII
				# 		SHIFT2      ; Pseudo-código de fim de arquivo

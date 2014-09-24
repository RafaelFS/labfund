				& 		/0000
;Exportando as constantes ================================================================
SHIFT2			>
TRATA_NEG		>
VOLTA_NEG 		>
MM_VAZIA		>
LD_VAZIA		>
INC_ADDRESS 	>
INCREASE		>
INVALID_ADDR	>
CH_1			>
CH_2			>
CH_3			>
CH_4			>
CH_5			>
CH_6			>
CH_E			>


;Definição e valores das contantes =============================================================
SHIFT2			K 		/0100		; Constante que desloca em 2 posições os bits das palavras
TRATA_NEG		K		/8000		; Constante utilizada para passar um numero negativo para um positivo
VOLTA_NEG		K		/0080		; Constante utilizada para voltar o número para negativo
MM_VAZIA		MM      /0000		; Move to memory vazia para criação de instrução dinamicamente
LD_VAZIA    	LD 		/0000		; Load vazia para criação de intruções dinamicamente
INC_ADDRESS		K		/0002		; Constante de incremento de endereço
INCREASE		K 		/0001		; Constante de decremento de contagem
INVALID_ADDR	K		/1000       ; Constante de endereço invalido. Qualquer endereço igual ou maior que ele é inválido
; Constantes para a rotina CHTOI
CH_1			K		/0040
CH_2			K		/0006
CH_3			K		/0007
CH_4			K		/0010
CH_5			K		/0100
CH_6 			K 		/1000
CH_E			K		/FFFF
				# 		SHIFT2      ; Pseudo-código de fim de arquivo

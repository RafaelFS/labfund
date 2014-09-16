			& 		/0000
;Exportando as constantes ================================================================
DESLOCADOR	>
TRATANEG	>
VOLTANEG 	>
MMVAZIA		>
LDVAZIA		>
INC_ADDRESS >
INCREASE	>

;Definição e valores das contantes =============================================================
DESLOCADOR	K 		/0100		; Constante que desloca em 2 posições os bits das palavras
TRATA_NEG	K		/8000		; Constante utilizada para passar um numero negativo para um positivo
VOLTA_NEG	K		/0080		; Constante utilizada para voltar o número para negativo
MM_VAZIA	MM      /0000		; Move to memory vazia para criação de instrução dinamicamente
LD_VAZIA    LD 		/0000		; Load vazia para criação de intruções dinamicamente
INC_ADDRESS	K		/0002		; Constante de incremento de endereço
INCREASE	K 		/0001		; Constante de decremento de contagem

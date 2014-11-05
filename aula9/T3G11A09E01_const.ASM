;Exportando as constantes ================================================================
SHIFT1			>
SHIFT2			>
TRATA_NEG		>
VOLTA_NEG		>
MM_VAZIA		>
LD_VAZIA    	>
INC_ADDRESS		>
INCREASE		>
INVALID_ADDR	>
CHECK_DIGITO	>
DIGITO_TO_HEX	>
LETRA_TO_HEX	>
CH_1			>
CH_2			>
CH_3			>
CH_4			>
CH_5			>
CH_6			>
CH_E			>
EOL				>
EOF				>
EOS				>
GD_VAZIA_D		>
PD_VAZIA_D		>
FALSE			>
TRUE			>
DBAR 			>
DSPACE 			>
BARSTAR 		>
JB 				>
LO 				>
DU 				>

				& 		/0000

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


; Constantes para a rotina CHTOI
CH_1			K		/0040
CH_2			K		/0006
CH_3			K		/0007
CH_4			K		/0010
CH_5			K		/0100
CH_6 			K 		/1000
CH_E			K		/FFFF

; Constantes para a rotina GETLINEF
EOL				K		/0D0A		; Fim da linha (codigo em ASCII)
EOF				K		/FFFF		; Fim do arquivo
EOS				K		/0000		; Fim da string
GD_VAZIA_D		GD 		/0300		; Get Data (do disco) vazia para criação de instrução dinamicamente
PD_VAZIA_D		PD 		/0300		; Put Data (do disco) vazia para criação de instrução dinamicamente
FALSE			K		/0000		;
TRUE			K		/0001		;

				# 		SHIFT1      ; Pseudo-código de fim de arquivo

; Constantes para a rotina MBS
DBAR 			K  		/2F2F 		; Caracteres ASCII "//"
DSPACE 			K 		/2020		; Caracteres ASCII "  "
BARSTAR 		K 		/2F2A 		; Caracteres ASCII "/*"
JB 				K 		/4A42 		; "JB"
LO 				K 		/4C4F 		;
DU 				K 		/4455 		;
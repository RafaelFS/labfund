				
; Coloque aqui seus imports
GD_VAZIA_D <
DBAR 	   <
DSPACE 	   <
BARSTAR    <
JB 		   <
EOL 	   <
EOF 	   <
DU 		   <
LO 		   <

LEITURA_UL <
L_UL 	   <
L_WORD 	   <

CHTOI				<			
CHTOI_IN1		 	<           ; Endereço de entrada da primeira palavra
CHTOI_IN2 			<       	; Endereço de entrada da segunda palavra
CHTOI_WORD	     	<       	; Word final
CHTOI_AUX 			<			
CHTOI_D 			<			
CHTOI_D1          	<       	; Digito 1 
CHTOI_D2  	     	<       	; Digito 2 
CHTOI_D3  	     	<       	; Digito 3 
CHTOI_D4  	     	<       	; Digito 4 

LOADER 		<  
LOADER_UL 	<	

DUMPER 		<  
DUMP_INI 	<	; Endereço onde começa o dump
DUMP_TAM 	<	; Numero total de palavras a serem "dumpadas"
DUMP_UL 	<	; Unidade logica do disco a ser usado
DUMP_BL 	<	; Tamanho do bloco
DUMP_EXE 	<	; Endereço onde começaria a execução (valor dummy, apenas para manter o formato)

				& 			/0000
MAIN			JP 			INI		; salta para o início do programa
UL				K 			/0000 	; parâmetro: UL onde está o arquivo de batch
WORD_1 			K 			/0000 	; variavel da palavra lida na UL
WORD_2 			K 			/0000
		
INI				LD 			UL				;
				MM 			L_UL 			;
				SC 			LEITURA_UL
				-			DBAR 			;
				JZ 			OUTRA_LEITURA 	;
OUTRA_LEITURA 	SC 			LEITURA_UL		;
				- 			JB 				;
				JZ 			INICIO_JOB 		;
				JP 			ERRO_1			;
INICIO_JOB		SC 			LEITURA_UL 		;
				- 			EOL 			;
				JZ			LOOP_COMANDO
				JP			ERRO_2
LOOP_COMANDO 	SC 			LEITURA_UL
				- 			DBAR
				JZ 			VERIFICA_COMANDO
				+ 			DBAR
				- 			EOF
				JZ 			ERRO_4
				+ 			EOF
				- 			BARSTAR
				JZ 			FIM_JOB
				JP 			ERRO_5

VERIFICA_COMANDO SC 		LEITURA_UL 		;
				- 			DU
				JZ			COMANDO_DU
				LD 			L_WORD
				- 			LO
				JZ 			COMANDO_LO
				JP 			ERRO_2

COMANDO_DU 		SC 			LEITURA_UL
				- 			EOL
				JZ 			CONTINUA_DU
				JP 			ERRO_5
CONTINUA_DU 	SC 			LEITURA_UL
				MM 			WORD_1
				LV 			WORD_1
				MM 			CHTOI_IN1
				SC 			LEITURA_UL
				MM 			WORD_2
				LV 			WORD_2
				MM 			CHTOI_IN2
				SC 			CHTOI
				LD 			CHTOI_WORD
				MM 			DUMP_BL
				SC 			LEITURA_UL
				-			DSPACE
				JZ 			CONTINUA_ARG2
				JP 			ERRO_3
CONTINUA_ARG2	SC 			LEITURA_UL
				MM 			WORD_1
				LV 			WORD_1
				MM 			CHTOI_IN1
				SC 			LEITURA_UL
				MM 			WORD_2
				LV 			WORD_2
				MM 			CHTOI_IN2
				SC 			CHTOI
				LD 			CHTOI_WORD
				MM 			DUMP_INI
				SC 			LEITURA_UL
				-			DSPACE
				JZ 			CONTINUA_ARG3
				JP 			ERRO_3
CONTINUA_ARG3	SC 			LEITURA_UL
				MM 			WORD_1
				LV 			WORD_1
				MM 			CHTOI_IN1
				SC 			LEITURA_UL
				MM 			WORD_2
				LV 			WORD_2
				MM 			CHTOI_IN2
				SC 			CHTOI
				LD 			CHTOI_WORD
				MM 			DUMP_TAM
				SC 			LEITURA_UL
				-			DSPACE
				JZ 			CONTINUA_ARG4
				JP 			ERRO_3
CONTINUA_ARG4	SC 			LEITURA_UL
				MM 			WORD_1
				LV 			WORD_1
				MM 			CHTOI_IN1
				SC 			LEITURA_UL
				MM 			WORD_2
				LV 			WORD_2
				MM 			CHTOI_IN2
				SC 			CHTOI
				LD 			CHTOI_WORD
				MM 			DUMP_EXE
				SC 			LEITURA_UL
				-			DSPACE
				JZ 			CONTINUA_ARG5
				JP 			ERRO_3
CONTINUA_ARG5	SC 			LEITURA_UL
				MM 			WORD_1
				LV 			WORD_1
				MM 			CHTOI_IN1
				SC 			LEITURA_UL
				MM 			WORD_2
				LV 			WORD_2
				MM 			CHTOI_IN2
				SC 			CHTOI
				LD 			CHTOI_WORD
				MM 			DUMP_UL
				SC 			DUMPER
				SC 			LEITURA_UL
				-			EOL
				JZ 			LOOP_COMANDO
				JP 			ERRO_5						

COMANDO_LO 		SC 			LEITURA_UL
				-  			EOL
				JZ 			CONTINUA_LO
				JP 			ERRO_5
CONTINUA_LO 	SC 			LEITURA_UL
				MM 			WORD_1
				LV 			WORD_1
				MM 			CHTOI_IN1
				SC 			LEITURA_UL
				MM 			WORD_2
				LV 			WORD_2
				MM 			CHTOI_IN2
				SC 			CHTOI
				LD 			CHTOI_WORD
				MM 			LOADER_UL
				SC 			LOADER
				SC 			LEITURA_UL
				- 			EOL
				JZ			LOOP_COMANDO
				JP 			ERRO_5


				
ERRO_1 			LV 			/0001			;
				OS 			/0EE 			;
				JP 			FIM 			;

ERRO_2 			LV 			/0002			;
				OS 			/0EE 			;
				JP 			FIM 			;

ERRO_3 			LV 			/0003			;
				OS 			/0EE 			;
				JP 			FIM 			;

ERRO_4 			LV 			/0004			;
				OS 			/0EE 			;
				JP 			FIM 			;

ERRO_5 			LV 			/0005			;
				OS 			/0EE 			;
				JP 			FIM 			;

FIM_JOB 		SC 			LEITURA_UL
				- 			EOF
				JZ 			SEM_ERRO
				JP 			ERRO_5

SEM_ERRO 		LV 			/0000			;
				OS 			/0EE 			;
				JP 			FIM 			;

FIM 	HM	FIM		; fim do programa

# MAIN

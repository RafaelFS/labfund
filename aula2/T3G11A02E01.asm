		@ /0000 			; Inicio
INI 	JP MAIN				; Pula para a label MAIN
	IN1 	K /00FA			; Entrada 1
	IN2 	K /0010			; Entrada 2
	OUT 	K /0000			; Saida
MAIN	LV 		IN1			; Recebe o endereco de memoria de IN1
		MM 		PACK_VAR1	; Salva o endereco na memoria PACK_VAR1
		LV 		IN2			; Recebe o endereco de memoria de IN2
		MM 		PACK_VAR2	; Salva o endereco na memoria PACK_VAR2
		SC 		PACK 		; Chama a sub-rotina PACK
		MM 		OUT			; Salva o resultado na saida (OUT)
		# 		MAIN		; Indica o fim do programa (Pseudo-comando)
FIM		HM 		FIM			; FIM

	PACK_VAR1 K /0000		; Variavel do programa
	PACK_VAR2 K /0000		; Variavel do programa
PACK K /0000				; Sub-rotina PACK
		LD 		PACK_VAR1	; Recebe o endereco de IN1 (conteudo de PACK_VAR1)
		+  		R 			; Soma com (8000H)
		MM 		X			; Salva no proximo endereco de memoria
X		K 		/0000		; Executa a instrucao recem-montada
		* 		C0			; Multiplica por 100H
		MM 		PACK_VAR1	; Salva na memoria PACK_VAR1
		LD 		PACK_VAR2	; Recebe o endereco de IN2 (conteudo de PACK_VAR2)
		+ 		R 			; Soma com (8000H)
		MM 		Y			; Salva no proximo endereco de memoria
Y		K 		/0000		; Executa a instrucao recem-montada
		+ 		PACK_VAR1	; Soma com o conteudo de PACK_VAR1
		RS 		PACK 		; Fim da sub-rotina
	C0		K  /0100 		;
	R 		LD /0000 		; 
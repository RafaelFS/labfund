/**
 * Escola Politécnica da Universidade de São Paulo
 * Departamento de Engenharia de Computação e Sistemas Digitais
 * Copyright© 2001..2011, todos os direitos reservados.
 * 
 * Este programa é de uso exclusivo das disciplinas de Laboratório de
 * Fundamentos de Engenharia de Computação (PCS2024 e PCS2302) e Linguagens
 * e Compiladores (PCS2056 e PCS2508).
 * É vetada a utilização e/ou distribuição deste código sem a autorização
 * dos docentes responsáveis pela disciplina ou do departamento responsável.
 */
package mvn;


import mvn.dispositivo.Rand;

/**
 * Classe que inicia a MVN.
 * 
 * @author PSMuniz
 * @author Diego Queiroz
 * @version 1.0 - PCS/EPUSP
 * @version 2.0 - PCS/EPUSP (MVN 4.0)
 */
public class MvnPcs{
	
	
	
	/**
	 * Método principal do programa. Responsável por inicializar o controlador
	 * e anexá-lo à um Painel de Controle.<br/>
	 * <br/>
	 * <b>Pré-condição</b>: Nenhuma.<br/>
	 * <b>Pós-condição</b>: O terminal da MVN é exibido.
	 * 
	 * @param args
	 *          Parâmetros do programa. Não utilizado.
	 */
	public static void main(String args[]){
            Rand randteste = new Rand();
            byte[] bytes;
            try {
                System.out.println(randteste.podeEscrever());
                System.out.println(randteste.podeLer());
                System.out.println(randteste.position());
                System.out.println(randteste.size());
                System.out.println(randteste.ler());
                System.out.println(randteste.ler());
                System.out.println(randteste.ler());
                System.out.println(randteste.ler());
                System.out.println(randteste.ler());
                randteste.escrever(new Bits8(10));
                System.out.println(randteste.ler());
                System.out.println(randteste.ler());
                System.out.println(randteste.ler());
                System.out.println(randteste.ler());
                System.out.println(randteste.ler());
                randteste.reset();
                System.out.println(randteste.ler());
                System.out.println(randteste.ler());
                System.out.println(randteste.ler());
                System.out.println(randteste.ler());
                System.out.println(randteste.ler());
                randteste.reset();
                System.out.println(randteste.ler());
                System.out.println(randteste.skip(new Bits8(3)));
                
                } catch (Exception e) {
                }
        }
	
} // Fim da Classe MvnPcs
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package mvn.dispositivo;

import java.util.Random;
import mvn.Bits8;
import mvn.Dispositivo;
import mvn.controle.MVNException;

/**
 * @author PCS/EPUSP
 */
public class Rand implements Dispositivo{
    private Random s;
    
    //Construtor: inicializa objeto (nenhum parametro recebido)
    public Rand(){
        //...
         s.setSeed(0);
        
    }
    
    

    @Override
    public void escrever(Bits8 in) throws MVNException {
        s.setSeed(in.toByte());
    }

    @Override
    public Bits8 ler() throws MVNException {
        byte[] bytegerado = new byte[1];
        s.nextBytes(bytegerado);
        return (Bits8)bytegerado[0];
    }

    @Override
    public boolean podeLer() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean podeEscrever() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void reset() throws MVNException {
        s.setSeed(0);

    }

    @Override
    public Bits8 skip(Bits8 val) throws MVNException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Bits8 position() throws MVNException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Bits8 size() throws MVNException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
}

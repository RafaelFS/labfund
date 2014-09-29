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
    public Random s = new Random();
    
    //Construtor: inicializa objeto (nenhum parametro recebido)
    public Rand(){
        //...
        s.setSeed(0);
    }
    
    @Override
    public void escrever(Bits8 in) throws MVNException {
        s.setSeed(in.toInt());
    }

    @Override
    public Bits8 ler() throws MVNException {
        byte[] bytearray = new byte[1];
        s.nextBytes(bytearray);
        Bits8 bytegerado= new Bits8(bytearray[0]);
        return bytegerado;
    }

    @Override
    public boolean podeLer() {
        return true;
    }

    @Override
    public boolean podeEscrever() {
        return true;
    }

    @Override
    public void reset() throws MVNException {
        s.setSeed(0);

    }

    @Override
    public Bits8 skip(Bits8 val) throws MVNException {
        Bits8 byte_saida = new Bits8();
        for (int i = 0; i < val.toInt(); i++) {
            byte_saida = this.ler();
        }
        return byte_saida;
    }

    @Override
    public Bits8 position() throws MVNException {
        Bits8 byte_saida = new Bits8(0);
        return  byte_saida;
    }

    @Override
    public Bits8 size() throws MVNException {
        Bits8 byte_saida = new Bits8(0);
        return  byte_saida;
    }
}

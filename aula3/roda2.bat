java -cp MLR.jar montador.MvnAsm T3G11A03E02_main_13.asm
java -cp MLR.jar montador.MvnAsm T3G11A03E02_rotinas_13.asm
java -cp MLR.jar montador.MvnAsm T3G11A03E02_const_13.asm
java -cp MLR.jar linker.MvnLinker T3G11A03E02_main_13.mvn T3G11A03E02_rotinas_13.mvn T3G11A03E02_const_13.mvn -s final.mvn
java -cp MLR.jar relocator.MvnRelocator final.mvn finalrelocado.mvn 0000 0000
java -jar MVN.jar
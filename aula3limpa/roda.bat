java -cp MLR.jar montador.MvnAsm T3G11A03E01_main_12.asm
java -cp MLR.jar montador.MvnAsm T3G11A03E01_rotinas_12.asm
java -cp MLR.jar montador.MvnAsm T3G11A03E01_const_12.asm
java -cp MLR.jar linker.MvnLinker T3G11A03E01_main_12.mvn T3G11A03E01_rotinas_12.mvn T3G11A03E01_const_12.mvn -s final.mvn
java -cp MLR.jar relocator.MvnRelocator final.mvn finalrelocado.mvn 0000 0000
java -jar MVN.jar
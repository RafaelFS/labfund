java -cp MLR.jar montador.MvnAsm T3G11A03E01_main_12.asm
java -cp MLR.jar montador.MvnAsm T3G11A03E01_rotinas_12.asm
java -cp MLR.jar montador.MvnAsm T3G11A03E01_const_12.asm
java -cp MLR.jar linker.MvnLinker T3G11A03E01_main_12.mvn T3G11A03E01_rotinas_12.mvn T3G11A03E01_const_12.mvn -s final.mvn
java -cp MLR.jar relocator.MvnRelocator final.mvn recl_final.mvn 0000 000
java -jar MVN.jar 
p recl_final.mvn
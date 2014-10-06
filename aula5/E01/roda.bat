java -cp MLR.jar montador.MvnAsm T3G11A05E01_MAIN_12.asm
java -cp MLR.jar montador.MvnAsm T3G11A05E01_rotinas_12.asm
java -cp MLR.jar montador.MvnAsm T3G11A05E01_const_12.asm
java -cp MLR.jar linker.MvnLinker T3G11A05E01_MAIN_12.mvn T3G11A05E01_rotinas_12.mvn T3G11A05E01_const_12.mvn -s pararelocar.mvn
java -cp MLR.jar relocator.MvnRelocator pararelocar.mvn final.mvn 0000 0000
java -jar MVN.jar
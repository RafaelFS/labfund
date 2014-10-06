java -cp MLR.jar montador.MvnAsm T3G11A05E01_MAIN.asm
java -cp MLR.jar montador.MvnAsm T3G11A05E01_rotinas.asm
java -cp MLR.jar montador.MvnAsm T3G11A05E01_const.asm
java -cp MLR.jar linker.MvnLinker T3G11A05E01_MAIN.mvn T3G11A05E01_rotinas.mvn T3G11A05E01_const.mvn -s pararelocar.mvn
java -cp MLR.jar relocator.MvnRelocator pararelocar.mvn final.mvn 0000 0000
java -jar MVN.jar
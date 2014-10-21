java -cp MLR.jar montador.MvnAsm T3G11A08E03_main.asm
java -cp MLR.jar montador.MvnAsm T3G11A08E03_loader.asm
java -cp MLR.jar linker.MvnLinker T3G11A08E03_main.mvn T3G11A08E03_loader.mvn  -s faltarelocar.mvn
java -cp MLR.jar relocator.MvnRelocator faltarelocar.mvn final.mvn 0000 0000
java -jar MVN.jar
PAUSE
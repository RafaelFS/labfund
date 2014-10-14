java -cp MLR.jar montador.MvnAsm T3G11A07E02_main.asm
java -cp MLR.jar montador.MvnAsm T3G11A07E02_dumper.asm
java -cp MLR.jar linker.MvnLinker T3G11A07E02_main.mvn T3G11A07E02_dumper.mvn  -s faltarelocar.mvn
java -cp MLR.jar relocator.MvnRelocator faltarelocar.mvn final.mvn 0000 0000
java -jar MVN.jar
PAUSE
java -cp MLR.jar montador.MvnAsm T3G11A09E01_main.asm
java -cp MLR.jar montador.MvnAsm T3G11A09E01_rotinas.asm
java -cp MLR.jar montador.MvnAsm T3G11A09E01_const.asm
java -cp MLR.jar montador.MvnAsm T3G11A09E01_dumper.asm
java -cp MLR.jar montador.MvnAsm T3G11A09E01_loader.asm
java -cp MLR.jar linker.MvnLinker T3G11A09E01_main.mvn T3G11A09E01_rotinas.mvn T3G11A09E01_const.mvn T3G11A09E01_dumper.mvn T3G11A09E01_loader.mvn -s relocado.mvn
java -cp MLR.jar relocator.MvnRelocator relocado.mvn final.mvn 0000 000
java -jar mvn.jar
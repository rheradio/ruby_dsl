import org.jruby.embed.ScriptingContainer;
import java.io.File;
import java.io.IOException;
import java.util.Scanner;

public class TestJRuby {

    public static String readFile(String pathname) throws IOException {

        File file = new File(pathname);
        StringBuilder fileContents = new StringBuilder((int) file.length());
        Scanner scanner = new Scanner(file);
        String lineSeparator = System.getProperty("line.separator");

        try {
            while (scanner.hasNextLine()) {
                fileContents.append(scanner.nextLine() + lineSeparator);
            }
            return fileContents.toString();
        } finally {
            scanner.close();
        }
    } // readFile

    public static void main(String[] args) throws IOException{
        ScriptingContainer interpreteRuby = new ScriptingContainer();
        String codigoSPL = readFile(".\\spl.rb");
        interpreteRuby.put("$dsl", ".\\dsl_libro.rb");
        interpreteRuby.runScriptlet(codigoSPL);
        Lector lector = (Lector) interpreteRuby.runScriptlet("LectorLibros.new");
        lector.leerFichero(".\\ejemplo_libros.txt");
        lector.imprimir();
    }

}

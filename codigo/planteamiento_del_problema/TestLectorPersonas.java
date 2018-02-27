import java.io.*;

public class TestLectorPersonas {
    public static void main(String[] args) throws Exception {
        LectorPersonas lector = new LectorPersonas();
        lector.leerFichero(".//ejemplo_personas.txt");
        lector.imprimir();
    }
}

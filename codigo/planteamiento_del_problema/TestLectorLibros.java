import java.io.*;

public class TestLectorLibros {
    public static void main(String[] args) throws Exception {
        LectorLibros lector = new LectorLibros();
        lector.leerFichero(".//ejemplo_libros.txt");
        lector.imprimir();
    }
}

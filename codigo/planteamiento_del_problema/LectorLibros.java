import java.io.*;
import java.util.*;

public class LectorLibros {
    private ArrayList<Libro> datos = new ArrayList<Libro>();;
    public ArrayList<Libro> leerFichero(String ficheroDatos) {
        String linea;
        try {
            BufferedReader buffer = new BufferedReader(new FileReader(ficheroDatos));
            linea = buffer.readLine();
            while (linea != null) {
                procesarLinea(linea);
                linea = buffer.readLine();
            }
        } catch (FileNotFoundException ex) {
            ex.printStackTrace();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        return datos;
    }
    private void procesarLinea(String linea) {
        Scanner scanner = new Scanner(linea).useDelimiter("\\s*,\\s*");
        String autor = scanner.next();
        String titulo = scanner.next();
        int precio = scanner.nextInt();
        datos.add(new Libro(autor, titulo, precio ));
    }
    public void imprimir() {
        for( Libro Libro : datos ) {
            System.out.println(Libro);
        }
    }
}
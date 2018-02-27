import java.io.*;
import java.util.*;

public class LectorPersonas {
    private ArrayList<Persona> datos = new ArrayList<Persona>();;
    public ArrayList<Persona> leerFichero(String ficheroDatos) {
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
        String nombre = scanner.next();
        int edad = scanner.nextInt();
        datos.add(new Persona(nombre, edad));
    }
    public void imprimir() {
        for( Persona persona : datos ) {
            System.out.println(persona);
        }
    }
}
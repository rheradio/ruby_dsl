public class Libro {
    private String autor;
    private String titulo;
    private int precio;
    public Libro(String autor, String titulo, int precio) {
        this.autor = autor;
        this.titulo = titulo;
        this.precio = precio;
    }
    public String toString() {
        return "autor = " + autor + "\n" +
                "titulo = " + titulo + "\n" +
                "precio = " + precio + "\n" +
                "---------------------------------";
    }
}

require 'java'
include Java


# ModeloSemantico
class ModeloSemantico
  attr_accessor :nombre_clase, :campos
  def initialize()
    @campos = Array.new
  end
end

# Analizador
def clase(nombre)
  modelo_semantico = ModeloSemantico.new
  modelo_semantico.nombre_clase = nombre
  define_method :campo do |nombre, tipo|
    modelo_semantico.campos << [nombre, tipo]
  end
  yield
  modelo_semantico
end
modelo_semantico = eval File.read('E:\ruben\ANECA\plaza_titular\memorias_ruben\presentaciones\ejemplo_ejercicio2\spl4_ruby_ruby_jruby\src\dsl_libro.rb')

# Generador
# Clase que almacena los datos
eval "class #{modelo_semantico.nombre_clase} end"
clase_datos = Object.const_get(modelo_semantico.nombre_clase)
clase_datos.class_eval do
  define_method :initialize do |*parametros|
    i = 0
    while i<parametros.length
      self.instance_variable_set("@#{modelo_semantico.campos[i][0]}".to_sym, parametros[i])
      i += 1
    end
  end
  define_method :to_s do
    resultado = ''
    modelo_semantico.campos.each do |nombre, tipo|
      resultado += "#{nombre} = " +
          self.instance_variable_get("@#{nombre}".to_sym).to_s + "\n"
    end
    resultado +  "---------------------------------"
  end

end

# Clase lectora
eval "class Lector#{modelo_semantico.nombre_clase}s < Java::Lector\n end"
clase_lectora = Object.const_get("Lector#{modelo_semantico.nombre_clase}s")
clase_lectora.class_eval do
  attr_reader :datos
  define_method :initialize do |*parametros|
    @datos = Array.new
  end
  define_method :leerFichero do |ficheroDatos|
    File.readlines(ficheroDatos).each { |linea|
      procesar_linea(linea)
    }
  end
  define_method :procesar_linea do |linea|
    valores = linea.split(/\s*,\s*/)
    valores.map! {|valor| valor.strip}
    @datos << clase_datos.new(*valores)
  end
  def imprimir
    @datos.each { |dato|
      puts dato
    }
  end
end


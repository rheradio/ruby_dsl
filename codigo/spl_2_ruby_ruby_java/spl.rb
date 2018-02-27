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
modelo_semantico = eval File.read('dsl_libro.rb')

# Generador
require 'erb'
File.open('plantilla_clase_datos.erb' ) { |plantilla|
  erb = ERB.new( plantilla.read )
  File.open("#{modelo_semantico.nombre_clase}.java", 'w') { |fichero_obj|
    fichero_obj.write(erb.result( binding ))
  }
}
File.open('plantilla_lector.erb' ) { |plantilla|
  erb = ERB.new( plantilla.read )
  File.open("Lector#{modelo_semantico.nombre_clase}s.java", 'w') { |fichero_obj|
    fichero_obj.write(erb.result( binding ))
  }
}



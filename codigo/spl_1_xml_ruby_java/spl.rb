# ModeloSemantico
class ModeloSemantico
  attr_accessor :nombre_clase, :campos
  def initialize()
    @campos = Array.new
  end
end

# Analizador
require 'rexml/document'
modelo_semantico = ModeloSemantico.new
doc = REXML::Document.new(File.open("dsl_personas.xml"))
modelo_semantico.nombre_clase = doc.root.attributes['clase']
doc.root.each_element('campo') { |campo|
  modelo_semantico.campos << [campo.attributes['nombre'], campo.attributes['tipo']]
}

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

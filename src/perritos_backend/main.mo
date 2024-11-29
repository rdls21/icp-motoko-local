import Text "mo:base/Text";
import Iter "mo:base/Iter";
import Debug "mo:base/Debug";
import HashMap "mo:base/HashMap";

actor Crud {
  type Nombre = Text;
  type Perro = {
    nombre: Text;
    raza: Text;
    edad: Nat8;
    adoptado: Bool;
  };

  let perritos = HashMap.HashMap<Nombre, Perro>(0, Text.equal, Text.hash);

  public func crearRegistro(nombre: Nombre, raza: Text, edad: Nat8) {
    let perrito = {nombre; raza; edad; adoptado= false};
    perritos.put(nombre, perrito);
    Debug.print("Registro creado exitosamente.");
  };

  public query func leerRegistro(nombre: Nombre): async ?Perro {
    perritos.get(nombre);
  };

  public query func leerRegistros(): async [(Nombre, Perro)] {
    let primerPaso: Iter.Iter<(Nombre, Perro)> = perritos.entries();
    let segundoPaso: [(Nombre, Perro)] = Iter.toArray(primerPaso);

    return segundoPaso;
  };

  public func actualizarRegistro(nombre: Nombre): async Bool {
    let perrito: ?Perro = perritos.get(nombre);
    switch(perrito) {
      case (null) {
        Debug.print("No se encontró el registro solicitado.");
        false
      };
      case (?perritoOk) {
        let nuevoPerrito = {nombre; raza = perritoOk.raza; edad= perritoOk.edad; adoptado= true};
        perritos.put(nombre, nuevoPerrito);
        true
      };
    };
  };

  public func borrarRegistro(nombre: Nombre): async Bool {
    let perrito: ?Perro = perritos.get(nombre);

    switch(perrito){
      case (null) {
        Debug.print("No se encontró ese perrito en los registros.");
        false
      };
      case (_) {
        ignore perritos.remove(nombre);
        Debug.print("Perrito borrado correctamente.");
        true
      };
    };
  };
};

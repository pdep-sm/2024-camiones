class Camion {
  const carga = []
  const cargaMaxima

  /** pto 1 y 3 */
  method cargar(coso) {
    if (self.puedeAceptar(coso)) 
      carga.add(coso)
  }

  /** pto 2 */
  method puedeAceptar(coso) = //TODO chequear disponible para carga
    (coso.peso() + self.cargaActual()) <= cargaMaxima
  
  method cargaActual() = carga.sum{ coso => coso.peso() }

  //TODO pto 4

  /** pto 5 */
  method puedePartir() = //TODO disponible para carga
    self.cargaActual() >= cargaMaxima * 0.75
  
  //TODO pto 6

  /** pto 7 */
  method elementosCargados() =
    carga.map{ coso => coso.elemento() }.asSet()

  method tieneElemento(elemento) = self.elementosCargados().contains(elemento)

  /** pto 9 */
  method elementosCompartidos(camion) =
    camion.elementosCargados().intersection(self.elementosCargados())
    //self.elementosCargados().filter{ elemento => camion.tieneElemento(elemento) }

  /** pto Messi */
  method cosoMasLiviano() = carga.fold(carga.anyOne(),{ liviano, coso => 
                            cosoComparador.masLivianoEntre(liviano, coso) })
                            //carga.min{ coso => coso.peso() }

method laskdlkas() = collection.list()
}

object cosoComparador {
  method masLivianoEntre(coso, otroCoso) = if (coso.peso() < otroCoso.peso()) coso else otroCoso
}

class Caja {
  const property peso
  const property elemento
  
}

class Bulto {
  const pesoPallet
  const caja
  const cantidadCajas

  method peso() = caja.peso() * cantidadCajas + pesoPallet

  method elemento() = caja.elemento()

}

class Bidon {
  const litros
  const liquido

  method peso() = litros * liquido.densidad()

  method elemento() = liquido.nombre()
}

class Liquido {
  const property densidad
  const property nombre
}

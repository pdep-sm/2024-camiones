import cosos.*
import errores.*
class Camion {
  const carga = []
  const cargaMaxima
  var property estado = disponibleParaCarga

  /** pto 1 y 3 */
  method cargar(coso) {
    if (not self.puedeAceptar(coso)) 
      throw new NoSePuedeCargarException(message = "Error al cargar un coso")
      //Fail Fast
    
    carga.add(coso)
  }

  /** pto 2 */
  method puedeAceptar(coso) = estado.puedeAceptar(coso, self)

  method puedeAceptarPeso(coso) = 
    (coso.peso() + self.cargaActual()) <= cargaMaxima

  method cargaActual() = carga.sum{ coso => coso.peso() }

  /** pto 4.a */
  method salirDeReparacion() {
    estado.salirDeReparacion(self)
  }

  /** pto 4.b */
  method entrarEnReparacion() {
    estado.entrarEnReparacion(self)
  }

  /** pto 4.c */
  method salirDeViaje() {
    estado.salirDeViaje(self)
  }

  /** pto 4.d */
  method volverDeViaje() {
    estado.volverDeViaje(self)
  }

  /** pto 5 */
  method puedePartir() = estado.puedePartir(self)

  method completoParaPartir() = self.cargaActual() >= cargaMaxima * 0.75
  
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

}

class Estado {
  method puedeAceptar(coso, camion) = false

  method salirDeReparacion(camion) {
     throw new NoEstaEnReparacionException(message = "Estado incorrecto!")
  }

  method entrarEnReparacion(camion) {
    camion.estado(enReparacion)
  }

  method salirDeViaje(camion) {
    camion.estado(enViaje)
  }

  method volverDeViaje(camion) {
    throw new NoEstaEnViajeException(message = "Estado incorrecto!")
  }

  method puedePartir(camion) = false

}

object disponibleParaCarga inherits Estado {

  override method puedeAceptar(coso, camion) = camion.puedeAceptarPeso(coso)

  override method puedePartir(camion) = camion.completoParaPartir()

}

object enReparacion inherits Estado {

  override method salirDeReparacion(camion) {
    camion.estado(disponibleParaCarga)
  }

  override method entrarEnReparacion(camion) {
    throw new YaEstaEnReparacionException(message="El camion ya esta en reparación!")
  }

}

object enViaje inherits Estado {

  override method salirDeViaje(camion) {
    throw new YaEstaEnViajeException(message="El camion ya está de viaje!")
  }

  override method volverDeViaje(camion) {
    camion.estado(disponibleParaCarga)
  }

}
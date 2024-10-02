import camiones.*
class Deposito {
    const camiones = #{}

    /** pto 8 */
    method camionesCargando(elemento) = //TODO cargando
        camiones.filter{ camion => camion.tieneElemento(elemento) }

}
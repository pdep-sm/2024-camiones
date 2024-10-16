
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
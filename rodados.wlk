import wollok.game.*

class Corsa {
    var color
    var position = new Position(x =4, y= 7)
    var posicionesRecorridas = []

    method initialize(){
        posicionesRecorridas.add(position)
    }
    method capacidad() = 4
    method velocidad() = 150 
    method peso() = 1300

    method color() = color

    method pintarDe(unColor) {
        color = unColor
    }

    method position() = position

    method position(p){
        position = p
        posicionesRecorridas.contains(p)
    }

    method pasoPor(posicion){
        posicionesRecorridas.contains(posicion)
    }
    method pasoPorFila(numero){
        posicionesRecorridas.any({ p => p.x() == numero }) //pero en el enunciado dice q fila de (3,5) asi que no se si es x o y??
    }
    method recorrioFilas(lista){
        lista.all({ fila => self.pasoPorFila(fila) })
    }
}

class Kwid {
    var tieneTanqueAdicional

    method color() = "azul"

    method capacidad() = if(tieneTanqueAdicional) 3 else 4

    method velocidad() = if(tieneTanqueAdicional) 110 else 120

    method peso() = 1200 + (if(tieneTanqueAdicional) 150 else 0)

    method agregarTanqueAdicional() {
        tieneTanqueAdicional = true
    }

    method quitarTanqueAdicional() {
        tieneTanqueAdicional = false
    }
}

object trafic {
    var interior = comodo
    var motor = bataton

    method cambiarInterior(nuevoInterior) {
        interior = nuevoInterior
    }

    method cambiarMotor(nuevoMotor) {
        motor = nuevoMotor
    }

    method capacidad() = interior.capacidad()

    method velocidad() = motor.velocidad()

    method peso() = 4000 + interior.peso() + motor.peso()

    method color() = "blanco"
}

object comodo {
    method capacidad() = 5
    method peso() = 700
}

object popular {
    method capacidad() = 12
    method peso() = 1000
}

object bataton {
    method velocidad() = 80
    method peso() = 500
}

object pulenta {
    method velocidad() = 130
    method peso() = 800
}

class AutoEspecial {
    const capacidad
    const velocidad
    const peso
    var color

    method capacidad() = capacidad
    method velocidad() = velocidad
    method peso() = peso
    method color() = color

    method pintarDe(unColor) {
        color = unColor
    }
}

class Pedido {
    const distancia
    var tiempoMaximo 
    var pasajeros
    const coloresIncompatibles = #{}

    method tiempoMaximo() = tiempoMaximo

    method cantidadPasajeros() = pasajeros

    method velocidadRequerida() {
        return distancia / tiempoMaximo
    }

    method puedeSatisfacerlo(unAuto) {
        return unAuto.velocidad() >= self.velocidadRequerida() + 10
        && unAuto.capacidad() >= pasajeros
        && !coloresIncompatibles.contains(unAuto.color())
    }

    method agregarColorIncompatible(unColor) {
        return coloresIncompatibles.add(unColor)
    }

    method tieneColorIncompatible(unColor) {
        return coloresIncompatibles.contains(unColor)
    }

    method cambiarCantidadDePasajeros(unaCantidad) {
    pasajeros = unaCantidad
}

method acelerar() {
    tiempoMaximo = tiempoMaximo - 1
}

method relajar() {
    tiempoMaximo = tiempoMaximo + 1
}
}

class Dependencia {
    const empleados
    const flota = []
    const pedidos = []

    method agregarAFlota(unRodado) {
        flota.add(unRodado)
    }

    method quitarDeFlota(unRodado) {
        flota.remove(unRodado)
    }

    method agregarPedido(unPedido) {
        pedidos.add(unPedido)
    }

    method quitarPedido(unPedido) {
        pedidos.remove(unPedido)
    }

    method pesoTotalFlota() {
        return flota.sum({ r => r.peso() })
    }

    method todosVanA(unaVelocidad) {
        return flota.all({ r => r.velocidad() >= unaVelocidad })
    }

    method estaBienEquipada() {
        return flota.size() >= 3
            && self.todosVanA(100)
    }

    method flotaDeColor(unColor) {
        return flota.filter({ r => r.color() == unColor })
    }

    method capacidadTotalEnColor(unColor) {
        return self.flotaDeColor(unColor).sum({ r => r.capacidad() })
    }

    method rodadoMasRapido() {
        return flota.max({ r => r.velocidad() })
    }

    method colorDelRodadoMasRapido() {
        return self.rodadoMasRapido().color()
    }

    method capacidadFlota() {
        return flota.sum({ r => r.capacidad() })
    }

    method capacidadFaltante() {
        return empleados - self.capacidadFlota()
    }

    method esGrande() {
        return empleados >= 40
            && flota.size() >= 5
    }

    method totalPasajerosDePedidos() {
        return pedidos.sum({ p => p.cantidadPasajeros() })
    }

    method algunAutoSatisface(unPedido) {
        return flota.any({ a => unPedido.puedeSatisfacerlo(a) })
    }

    method pedidosNoSatisfechos() {
        return pedidos.filter({ p => !self.algunAutoSatisface(p) })
    }

    method todosLosPedidosTienenColorIncompatible(unColor) {
        return pedidos.all({ p => p.tieneColorIncompatible(unColor) })
    }

    method relajarTodosLosPedidos() {
        pedidos.forEach({ p => p.relajar() })
    }
}
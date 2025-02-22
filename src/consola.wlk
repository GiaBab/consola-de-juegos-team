import wollok.game.* 
import juego.*
import gameManager.*

object consola {

	const juegos = [
		new Juego(color = "Amarillo", juego = new JuegoSnake(dificultad=1)),
		new Juego(color = "Verde", juego = new JuegoSnake(dificultad=2)),
		new Juego(color = "Rojo", juego = new JuegoSnake(dificultad=3)),
		new Juego(color = "Azul", juego = new JuegoSnake(dificultad=4)),
		new Juego(color = "Naranja", juego = new JuegoSnake(dificultad=5)),
		new Juego(color = "Violeta", juego = new JuegoSnake(dificultad=6))
	]
	var menu 
	
	method initialize(){
		game.height(32)
		game.width(32)
		game.cellSize(16)
		game.title("Consola de juegos")
	}
	
	method iniciar(){
		menu = new MenuIconos(posicionInicial = game.center().left(2))	
		game.addVisual(menu)
		juegos.forEach{juego=>menu.agregarItem(juego)}
		menu.dibujar()
		keyboard.enter().onPressDo{self.hacerIniciar(menu.itemSeleccionado())}
		
	}
	
	method hacerIniciar(juego){
		game.clear()
		keyboard.q().onPressDo{self.hacerTerminar(juego)}
		juego.iniciar()
	}
	method hacerTerminar(juego){
		juego.terminar()
		game.clear()
		self.iniciar()
	}
}


class MenuIconos{
	var seleccionado = 1
	const ancho = 3
	const espaciado = 2
	const items = new Dictionary() 
	var posicionInicial
	
	method initialize(){
		keyboard.up().onPressDo{self.arriba()}
		keyboard.down().onPressDo{self.abajo()}
		keyboard.right().onPressDo{self.derecha()}
		keyboard.left().onPressDo{self.izquierda()}
	}
	
	method agregarItem(item){
		items.put(items.size()+1, item)
	}

	method dibujar(){
		items.forEach{indice,visual => 
			visual.position(self.posicionDe(indice))
			game.addVisual(visual)
		}
	}
	
	method horizontal(indice) = (indice-1)% ancho * espaciado
	method vertical(indice) = (indice-1).div(ancho) * espaciado
	
	method posicionDe(indice) =
		posicionInicial
			.up(self.vertical(indice))
			.right(self.horizontal(indice))

	method itemSeleccionado() = items.get(seleccionado)
	method image() = "cursor.png"
	method position() = self.posicionDe(seleccionado)

	method abajo(){
		if(seleccionado > ancho) seleccionado = seleccionado - ancho	
	}
	method arriba(){
		if(seleccionado + ancho <= items.size()) seleccionado = seleccionado + ancho	
	}
	method derecha(){
		seleccionado = (seleccionado + 1).min(items.size())
	}
	method izquierda(){
		seleccionado = (seleccionado - 1).max(1)
	}
}



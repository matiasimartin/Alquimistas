object alquimista {
  
  var itemsDeCombate = []
  var itemsDeRecoleccion = []
  
  method tieneCriterio() {	/* _1_ */
    return self.cantidadDeItemsDeCombateEfectivos() >= self.cantidadDeItemsDeCombate() / 2
  }
  
  method cantidadDeItemsDeCombate() {
    return itemsDeCombate.size()
  }
  
  method cantidadDeItemsDeCombateEfectivos() {
    return itemsDeCombate.count({ itemDeCombate =>
      itemDeCombate.esEfectivo()
    })
  }
  
  method esBuenExplorador(){	/* _2_ */
  	return self.cantidadDeItemsDeRecoleccion() >= 3
  }
  
  method cantidadDeItemsDeRecoleccion(){
  	return itemsDeRecoleccion.size()
  }
  
  method capacidadOfensiva(){	/* _3_ */
  	return itemsDeCombate.sum({capacidadDeItem => capacidadDeItem.capacidad()})
  }
  
  method esProfesional(){	/* _4_ */
  	return self.calidadPromedioDeSusItems() > 50 and self.todosSusItemsDeCombateSonEfectivos() and self.esBuenExplorador()
  }
  
  method calidadPromedioDeSusItems(){
  	return self.calidadDeItems() / self.cantidadDeItems()
  }
  
  method cantidadDeItems(){
  	return self.cantidadDeItemsDeCombate() + self.cantidadDeItemsDeRecoleccion()
  }
  
  method calidadDeItems(){
  	return self.calidadDeItemsDeCombate() + self.calidadDeItemsDeRecoleccion()
  }
  
  method calidadDeItemsDeCombate(){
  	return itemsDeCombate.sum({calidadDeItem => calidadDeItem.calidad()})
  }
  
  method calidadDeItemsDeRecoleccion(){
  	return itemsDeRecoleccion.sum({calidadDeItem => calidadDeItem.calidad()})
  }
  
  method  todosSusItemsDeCombateSonEfectivos(){
  	return itemsDeCombate.all({itemDeCombate => itemDeCombate.esEfectivo()})
  }
  
  method agregarItemDeCombate(item){
  	itemsDeCombate.add(item)
  }
  
  method agregarItemDeRecoleccion(item){
  	itemsDeRecoleccion.add(item)
  }
}


object bomba {
  
  var materiales = []
  var danio = 0
  
  method esEfectivo() {
    return danio > 100 
  }
  
  method cambiarDanio(nuevoDanio){
   	danio = nuevoDanio
  }
  
  method capacidad(){
  	return danio/2
  }
 
  method calidad(){
 	return materiales.min({material => material.calidad()}).calidad()
  }
  
  method agregarMateriales(material){
  	materiales.add(material)
  }
}


object pocion {
	
  var materiales = []
  var poderCurativo = 70
  
  method esEfectivo() {
    return poderCurativo > 50 and self.fueCreadaConAlgunMaterialMistico()
  }
  
  method fueCreadaConAlgunMaterialMistico() {
    return materiales.any({ material => material.esMistico()})
  }
  
  method capacidad(){
  	return poderCurativo + self.cantidadDeMaterialesMisticos()*10
  }
  
  method cantidadDeMaterialesMisticos(){
  	return materiales.count({material => material.esMistico()})
  }
  
  method calidad(){
  	return self.primerMaterialMisticoOno().calidad()
  }
  
  method primerMaterialMisticoOno(){
  	return materiales.findOrElse({material => material.esMistico()}, {materiales.first()})	
  }
  
  method agregarMateriales(material){
  	materiales.add(material)
  }
}


object debilitador {
	
  var materiales = []
  var potencia = 20
  
  method esEfectivo() {
    return potencia > 0 and self.fueCreadoPorAlgunMaterialMistico().negate()
  }
  
  method fueCreadoPorAlgunMaterialMistico() {
    return materiales.any({ material =>material.esMistico()})
  }
  
  method calidad(){
  	return self.promedio2MaterialesMayorCalidad()/2
  }
  
  method promedio2MaterialesMayorCalidad(){
  	return self.dosMaterialesMayorCalidad().sum({material=>material.calidad()})
  }
  
  method dosMaterialesMayorCalidad(){
  	return self.materialesOrdenadosPorCalidad().take(2)
  }
  
  method materialesOrdenadosPorCalidad(){
  	return materiales.sortedBy({material1, material2 => material1.calidad() > material2.calidad()})
  }
  
  method cantidadDeMaterialesMisticos(){
  	return materiales.count({material => material.esMistico()})
  }
  
  method capacidad(){
  	if(self.fueCreadoPorAlgunMaterialMistico()){
  		return self.cantidadDeMaterialesMisticos()*12
   	}else{
   		return 5
 	 }
  }
	
	method agregarMateriales(material){
  	materiales.add(material)
  }
}

object itemDeRecoleccion {
	
	var materiales = []
	
	method calidad(){
		return 30 + self.calidadDeMateriales() /10
	}
	
	method calidadDeMateriales(){
		return materiales.sum({material => material.calidad()})
	}
	
	method agregarMateriales(material){
  	materiales.add(material)
    }
}


object materialMistico {
	
	var calidad=0
	method esMistico(){
		return true
	}
	
	method calidad(){
		return calidad
	}
	
	method cambiarCalidad(unaCalidad){
		calidad = unaCalidad
	}	
}

object materialNoMistico{
	
	var calidad=0
	method esMistico(){
		return false
	}
	
	method calidad(){
		return calidad
	}
	
	method cambiarCalidad(unaCalidad){
		calidad = unaCalidad
	}
}


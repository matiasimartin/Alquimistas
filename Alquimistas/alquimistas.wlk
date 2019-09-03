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
  
  method capacidadOfensiva(){	/* _4_ */
  	return itemsDeCombate.sum({capacidadDeItem => capacidadDeItem.capacidad()})
  }
  
  method esProfesional(){	/* _3_ */
  	return self.calidadPromedioDeSusItems() > 50 and self.todosSusItemsDeCombateSonEfectivos() and self.esBuenExplorador()
  }
  
  method  todosSusItemsDeCombateSonEfectivos(){
  	return itemsDeCombate.all({itemDeCombate => itemDeCombate.esEfectivo()})
  }
  
  method calidadPromedioDeSusItems(){
  	return self.calidadDeItems()/self.cantidadDeItems()
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
  	return itemsDeCombate.sum({calidadDeItem => calidadDeItem.calidad()})
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
  var danio = 15
  
  method esEfectivo() {
    return danio > 100
  }
  
  method capacidad(){
  	return danio/2
  }
 
 method calidad(){
 	return materiales.min({material => material.calidad()})
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
    return materiales.any({ material =>
      material.esMistico()
    })
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
  
  method calidadDelPrimerMaterialMistico(){
  	return self.materialesMisticos().first()
  }
  
  method materialesMisticos(){
  	return materiales.filter({material => material.esMistico()})
  }
  
  method calidadDelPrimerMaterial(){
  	return materiales.first()
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
    return materiales.any({ material =>
      material.esMistico()
    })
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



object florRoja{
	
	var calidad =20
	
	method esMistico(){
		return true
	}
	
	method calidad(){
		return calidad
	}
	
	
}

object unUni{
	
	var calidad =50
	
	method esMistico(){
		return true
	}
	
	method calidad(){
		return calidad
	}
}

object polvora{
	
	var calidad =15
	
	method esMistico(){
		return false
	}
	
	method calidad(){
		return calidad
	}
}
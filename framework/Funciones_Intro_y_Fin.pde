void introJuego (){    
    
  // La imagen inicial siempre sera la primera que sale, ya que por esta funcion solamente se pasa una vez (al iniciar el juego) la imagen cambiara en el menu pero la felicitacion nueva
  //se verá al salir
  
  image (fondo_elegido,0,0);
  
  /* Mientras no hayan pasado 5 segundos se mostrara en pantalla la Felicitación. Con la funcion que nos facilita
  Processing millis() que cuenta las milisegundos desde que compienza el programa hasta que termina*/
  
  if (millis() >= 5000) {  
    mode = 2;
  }
  print (millis()/1000); // para comprobar los segundos que tarda. 
}

// Esta función aparece de nuevo el mensaje navideño de inicio y luego se cerrara el programa. 
void finJuego(){
  
  image (fondo_elegido,0,0);

  // Volvemos ha hacer el contador para que en 5 segundos se cierre
  
  if (tiempo_anterior == 0){
    tiempo_anterior = millis();
  }
  
  if (millis() - tiempo_anterior >= 5000){
    exit(); //Acabamos cerrando el programa despues de 5 segundos  
    print (tiempo_anterior, millis());
  }  
}

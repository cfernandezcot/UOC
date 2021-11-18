void menuJuego (){
  
  image (fondo_elegido_menu,0,0);
 
  /*Los botones que nos llevaran a las diferentes partes, que hemos creado en el setup. Es decir, cp5Grup1 lo volvermos a activar en esta funcion, ya que este grupo serán los botones 
  del menu. */
  
  cp5Grup1.setVisible(true);
  cp5Grup1.setBroadcast(true);
  
}

// Haremos una funcion para cada uno de los botones y que al clicar cambie de el mode y asi cambiar de pantalla

public void jugar(int value){
  if (value== 3){
    mode= 3;
    cp5Grup1.setVisible(false);
   
    // Aqui se inicializan las variables para que cuando se pierda se pueda volver a jugar
    enemigos= new ArrayList();
    vel= 1;
    dificultad= 1;
    disparo= false;
    puntos= 0;
    derrota= false;
    tiempo_juego= 0;
  }
}
public void opciones(int value){
  if (value== 4){
    mode= 4;
    cp5Grup1.setVisible(false);
  }
}
public void salir(int value){
  if (value== 5){
    mode= 5;
    cp5Grup1.setVisible(false);
  }
}

void opcionesJuego(){
  
  image (fondo_elegido_juego,0,0);
  
  fill (255,255,0);
  textSize(30);
  
  text("- Selecciona la musica: ", 200, 120);

  text("- Selecciona la imagen: ", 200, 270);
  
  //La interfaz del menu.
  
  cp5Grup2.setVisible(true);
  cp5Grup2.setBroadcast(true);
  
}

public void Musica(int value){
  if (value == 0){
    cancion_2.pause(); //Para que no suenen a la vez.
    cancion_1.rewind(); // Para que se reinicie al cambiarlo
    cancion_1.loop();
  } else {
    cancion_1.pause();
    cancion_2.rewind();// Para que se reinicie al cambiarlo
    cancion_2.loop();
  }
}

public void Fondo(int value){
  if (value == 0){
    fondo_elegido= feliz_1;
    fondo_elegido_menu= menu_1;
    fondo_elegido_juego= fondo_juego;
  } else {
    fondo_elegido= feliz_2;
    fondo_elegido_menu= menu_2;
    fondo_elegido_juego= fondo_juego2;
  }
}

// Controla que cuando se pulse se vuelva al menu haciendo que el mode sea dos si se pulsa
public void menu(int value){
  if (value == 2){
    mode= 2;
    cp5Grup2.setVisible(false);
    cp5Grup3.setVisible(false);
    
  }
}

//Esta sera la funcion principal, donde llamaremos a las demas funciones que haremos a contiuación
void jugarJuego (){
  
  image (fondo_elegido_juego,0,0);
  noCursor();
  
  // AQUI ESTA EL CONTADOR DEL TIEMPO (se puede hacer en una funcion o en una clase separada pero asi es como lo hice en la practica anterior)
  
  if (tiempo_anterior == 0){
    tiempo_anterior = millis();
  }

  if (millis() - tiempo_anterior >= 1000){
    tiempo_juego ++;
    tiempo_anterior = millis();
  }
 

// Aqui haremos el codigo principal del juego con un if donde si se pierde aparecera un boton para volver al menu y te dira los puntos que tienes

  if (!derrota){
    
    dificultadJuego(); // Primero para que sepa a la dificultad que comenzamos la partida
    aparicion(); // El siguiente para que vayan haciendo aparicion los enemigos
    movimientoNaves(); // se vayan moviendo
    ataqueDado(); // se se da a un enemigo que se eliminen
    mostrarJuego(); // se muestren en pantalla las imagenes y movimientos
    derrotaJuego(); // para que compruebe si se a perdido la partida
    // finalmente que aparezca en pantalla el contador de tiempo y de puntos
    fill(0,0,0);
    textSize(15);
    text("Tiempo: " + tiempo_juego, 50, 20);
    text("Puntos: " + puntos, 500,550);

  } else {

    fill (250,150,0);
    textSize(40);
    text("HAS PERDIDO :(", 255,150);
    textSize(25);
    text("Tu puntuación es de " + puntos, 255, 250);
    cp5Grup3.setVisible(true);
    cp5Grup3.setBroadcast(true);
    cursor();

  }
  disparo= false; // Para que una vez dado el clic no se quede para siempre en true debemos volver a ponerlo en false
}

//Comenzare haciendo una class de los enemigos

class Enemigo{
  
  PImage enemigo;
  int ancho;
  int movx;
  int movy;
  int vida;
  float velocidad;
  
  Enemigo (int new_movx, int new_movy, int golpes, float new_vel){
    
    enemigo= loadImage ("enemigo.png");
    movx= new_movx;
    movy= new_movy;
    vida= golpes;
    velocidad= new_vel;
  
  }
  
  // Hacemos una funcion que serà el movimiento de los enemigos
  
  void movimientoEn(){
    //Solamente se moveran de arriba abajo. Por eso sumaremos el la posicion de y (movy) con la velociadad que sera lo que determina el mocimiento 
    
    movy += velocidad;   
  }
  
  void naveEn(){
    // Esta funcion será donde aparece el enemigo en la pantalla. 
    image (enemigo,movx, movy);
  }
}

// Una vez acabado la calse de enemigo, haremos una funcion que será para hacer que vayan apareciendo.

void aparicion(){
  
  // Con la ayuda del contador, creado en la practica anterior, haremos que cuando el tiempo sea modulo de 5 aparezcan nuevas naves y se ajuste la dificultad
  
  if ((tiempo_juego % 5) == 0 ){
    
    Enemigo nave= new Enemigo(int(random(0,505)), int(random(10,20)), 1, vel); // Aqui lo que hacemos es crear de forma aleatoria donde apareceran las naves
    enemigos.add(nave); // Aqui vamos añadiendo las naves en la array que hemos creado con la posicion donde apareceran.
    nave= null;
    dificultad++; // vamos aumentando progresivamente la dificultad 
  }
}

// Ahora creamos una funcion que movera las naves enemigas, si se pasan del alto de la pantalla.

void movimientoNaves(){
  
  /* Este for lo hacemos para tener el control de donde esta la nave cada momento y asi poder hacer que vaya avanzando con el .movimientoEn*/
  for (int i = 0; i < enemigos.size(); i++){
    
    Enemigo nave= (Enemigo)enemigos.get(i);
    nave.movimientoEn();
    
    // Este if lo que hace es que una vez las naves han llegado al final de la pantalla las pondra de nuevo en la parte superior de la pantalla y elegira un numero de x aleatorio
    if (nave.movy > 600){
      nave.movy=0;
      nave.movx= int(random(0,505)); 
    }
    nave= null;
  }
}

/* Una funcion que hara que cuando se haga clic se dispare, es decir que si se da click el boleano disparo será true y disparara y
tambien saldra un sonido, processing ya tiene esta funcion y se llama mousePressed() lo que haré es dare las condiciones por si esto pasa*/

void mousePressed(){
  
  disparo= true; 

}

// Esta funcion mostrara las naves enemigas, al jugador, los disparos
void mostrarJuego(){
  
  // Aqui volveremos a usar un for para controlar la posicion de la nave y mostrarla donde toca
  
  for (int i = 0; i < enemigos.size(); i ++){
  
    Enemigo nave= (Enemigo)enemigos.get(i);
    nave.naveEn();
    nave= null;
  }
  
  image (jugador, mouseX-50,mouseY-128); // Asi hacemos que donde este la imagen estara el raton.
  
  if (disparo==true){
  sonido_disparo.rewind();
  sonido_disparo.play();
  
  // El disparo es ahora una linea recta hacia arriba, que simula el fuego.
  
  stroke (200,128,0);
  strokeWeight(5);
  line(mouseX,0,mouseX,mouseY-52); // para que el rayo salga de la cerilla.
  }
}
  
// A continuacion hacemos una funcion que sera la que cuente la vida de los enemigos que solo es uno, es decir que eliminara a los enemigos si han sido alcanzados por un ataque.

void ataqueDado(){
  
  if (disparo){
    
    // Haremos un for, de nuevo, para ver controlar la posicion de los enemigos. 
    
    for (int i= 0; i< enemigos.size(); i++){
      
      Enemigo nave= (Enemigo) enemigos.get(i);
      
      if (mouseX < nave.movx + 101 && mouseX > nave.movx && nave.movy < mouseY){ // el ancho de las naves de 101px 
         
         nave.vida = nave.vida - 1;
         
         if (nave.vida <= 0){
           
           nave= null; // igualamos a 0 como hemos estado haciendo.
           enemigos.remove(i);// eliminamos al enemigo que esta en i ya que no tiene vida
           puntos= puntos+ int(vel); //sumamos los puntos segun la velocidad
         }
      puntos ++;
      } 
    }
  }
}


// Ahora comprobamos si nuestro jugador a perdido es decir si las naves enemigas han conseguido darle

void derrotaJuego(){ 
  double distancia_naves;

   for (int i = 0; i < enemigos.size(); i++){
   
       print(" hola ");

     Enemigo nave= (Enemigo) enemigos.get(i);
     
     print("\nnave.movy: "+ nave.movy);
     print("\nnave.movx: "+ nave.movx);
     
     
      distancia_naves = Math.sqrt(Math.pow((mouseX - nave.movx), 2) + Math.pow((mouseY - nave.movy), 2));
     
     //kk = ((nave.movx + mouseX) / 2, (nave.movy + mouseY) / 2);
     
     print("\ndnave: "+ i);
      print("\ndistancia: "+ distancia_naves);
      print("\nd: ");
     
     if(distancia_naves<100) {
       derrota= true;
       sonido_muerte.rewind();
       sonido_muerte.play(); 
     }
   }
}

// Ahora hacemos una que incremente la dificultad que en realidad aumenta la velicdad de los enemigos

void dificultadJuego(){

  if (vel < 40 && dificultad >=20){
  
    vel= dificultad/5;
  }
}

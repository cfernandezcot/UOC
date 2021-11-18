boolean empezamos; //(con valor true o false, para empezar el juego).
float x; //posicion x de la bola
float y; //posicion y de la bola
float vx; //componente x de la velocidad de la bola
float vy; //componente y de la velocidad de la bola
float vp;
float yp;
int diametre; //diametro de la bola
int midapala; //longitud de la pala
int puntos;// cantidad de puntos que tienes "veces que has conseguido evitar que la pelota de a la pared".
int max_puntos; // puntuacion maxima conseguida  
float col1; // color de la porteria
float col2; // color de la porteria
float col3; // color de la porteria

void setup() {
  size(500, 500);
  x = 150;
  y = 150;
  vx = random(3, 5); // vx y vy son las coordenadas de la velocidad.
  vy = random(-3, -5); //Random da un valor aleatorio entre los valores propuestos
  col1 = random(0, 250);
  col2 = random(0, 250);
  col3 = random(0, 250);
  diametre = 20; // Diametro de la bola
  midapala = 120; // Medida de la pala
  puntos = 0;
  max_puntos= 0;
}

void draw (){
  background(0);
  fill(0,25,255);
  rect (480,mouseY-midapala/2,diametre-5,midapala); // Creacion de la pala con el mouseY-mipala hacemos que el raton sea la coordenada y de la pala.
  
  textSize (15);
  fill(255);
  text("Puntos: "+ puntos, 20,25);
  fill(255);
  text("Puntuación más alta: "+ max_puntos,320,480);
  // Creamos la pelota fuera del if para que se mueva cuando le damos click y no antes
  ellipse (x,y,20,20);
  
  fill (col1,col2,col3);
  rect (0,0,15,495);
  
  if (empezamos) {

    noCursor(); // Para que no aparezca el cursor mientras juegamos.
    // Vamos cambiando la velocidad de la pelota
    x = x + vx;
    y = y + vy;
    
    // si la bola choca con la pala, se invierte el sentido en el eje x
    if( x > width-30 && x < width -20 && y > mouseY-midapala/2 && y < mouseY+midapala/2 ) {
       // Aqui hacemos que la velocidad cambie de signo para que cambie la dirección, es decir que se mueva para el lado contrario y esto hace que al tocar la pala cambie de dirección.
      vx = vx * -1;
      x = x + vx; 

    }
    // Aqui hacemos que rebote contra la parte de arriba y abajo del suelo, usando el mismo principio que con el anterior, (y<0 es porque para la parte de arriba la y será 0, ya que esta invertido el eje y en processing)
    else if (y > height-10 || y <= 10) { 
      // Hacemos lo mismo pero esta vez con el vector y
      vy= vy* -1;
      y= y+vy;
    
    }
    // Aqui hacemos que rebote con la pared de la izquierda y que sume uno a la puntuación
    else if (x < 25){
      vx = vx * -1;
      x = x + vx;
      puntos++;
      // Que vaya cambiando el color de la porteria cada vez que le damos
      col1 = random(0, 250);
      col2 = random(0, 250);
      col3 = random(0, 250);
      // Si quisieramos más dificultad podriamos hacer que cada vez que le damos aumente la velocidad de la pelota.
      vx++;
      vy++;
      print("velocidad x: " + vx);
      print("velocidad y: " + vy);
    } 
    dificultadPong();
    puntuacionMaxima();
  }
  
  derrotaPong();
}

// Aqui ponemos los puntos maximos conseguidos, una vez se reinicie el programa los puntos maximos tambien.
void puntuacionMaxima(){
  
  if (max_puntos < puntos){
    max_puntos = puntos;
  
  }
}

//Aqui controlamos que la velocidad no supere 13, porque sino atraviesa la pala y porque más haría que fuera imposible darle a la pelota.
void dificultadPong(){
  
  if (vx >= 13.0){
    vx--;
  }

}

// Controlamos la derrota si a la derecha no da la pala y inicializaremos las variables a los valores originales.
void derrotaPong(){
  if (x > width){
    cursor(); // para que vuelva a aprecer el cursor cuando perdemos
    empezamos= !empezamos; // Hacemos que el juego se pause
    //Volvemos a poner las variables a su estado original 
    x= 150; 
    y= 150;
    vx = random(3, 5); 
    vy = random(-3, -5);
    puntos= 0;
    
  }
  
}

void mousePressed() {
empezamos = !empezamos;
}

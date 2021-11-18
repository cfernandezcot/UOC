import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import controlP5.*;
/*  VARIABLES  */

int mode; // La variable que controla donde estamos del juego. (1= Intro 2= Menu 3= Juego 4= Configuración 5= Salir)
int tiempo_juego; //el tiempo juego 
int tiempo_anterior;//el tiempo antes

// Variales para el juego
ArrayList enemigos;
int vel;
int puntos;
int dificultad;
boolean disparo;
boolean derrota;

//Libreria ControlP5
ControlP5 cp5Grup1;
Button jugar_juego;
Button opciones_juego;
Button salir_juego;
Button volver_menu;
ControlP5 cp5Grup2;
Button menu_juego;
DropdownList opciones1;
DropdownList opciones2;
ControlP5 cp5Grup3;
//Libreria Minim
Minim myMinim;
AudioPlayer cancion_1;
AudioPlayer cancion_2;
AudioPlayer sonido_disparo;
AudioPlayer sonido_muerte;

/* Imagenes Variables */
PImage feliz_1; //Imagen de felicitación 1
PImage feliz_2;
PImage menu_1; // Primmera imagen del menu, hasta que se cambie.
PImage menu_2;
PImage fondo_juego; // El fondo del juego simple
PImage fondo_juego2; 
PImage boton_juego; // Imagen del boton juego
PImage boton_opciones; // Imagen del boton opciones 
PImage boton_salir; // Imagen del boton salir
PImage boton_menu; // Imagen boton menu
PImage boton_jugar2;
PImage boton_salir2;
PImage boton_opciones2;
PImage boton_menu2;
PImage jugador;
PImage explosion;
PImage fondo_elegido;// Elegira la imagen que saldra cuando se cambie en el menu.
PImage fondo_elegido_menu;// Cambiara con las opciones a la vez que el menu
PImage fondo_elegido_juego;
/*  FIN VARIABLES  */

void setup(){
  background(51);
  size(600,600);
  textSize(30);
  textAlign(CENTER);
  frameRate (20);
  
// DECLARACIÓN DE VARIABLES
  mode=1;
  tiempo_juego = 0;
  tiempo_anterior = 0;


//Declaracion de las imagenes
  feliz_1 = loadImage ("felicitacion_1.png");
  feliz_2 = loadImage("felicitacion_2.png");
  menu_1= loadImage("fondo_menu1.png");
  menu_2= loadImage("fondo_menu2.png");
  fondo_juego= loadImage("fondo_juego.png");
  fondo_juego2= loadImage("fondo_juego2.png");
  boton_juego= loadImage("boton_Jugar.png");
  boton_jugar2= loadImage("boton_jugar_llamas.png");
  boton_opciones= loadImage("boton_Opciones.png");
  boton_opciones2= loadImage("boton_opciones_llamas.png");
  boton_salir= loadImage("boton_Salir.png");
  boton_salir2= loadImage("boton_salir_llamas.png");
  boton_menu= loadImage("boton_Menu.png");
  boton_menu2= loadImage("boton_menu_llamas.png");
  jugador= loadImage("jugador.png");
  explosion= loadImage("explosion.png");
  
  
  fondo_elegido= feliz_1;
  fondo_elegido_menu= menu_1;
  fondo_elegido_juego= fondo_juego;
//Declaracion de las variables de la libreria Control, la cpGrup1 son los botones del menu principal, el grupo2 será del menu de opciones
  cp5Grup1= new ControlP5(this); // primer grupo
  cp5Grup1.setBroadcast(false);
  
  jugar_juego= cp5Grup1.addButton("jugar")
  .setValue(3).setPosition(235,240).setSize(150,50).setImages(boton_juego,boton_jugar2,boton_jugar2); //boton para jugar
  
  opciones_juego= cp5Grup1.addButton("opciones")
  .setValue(4).setPosition(235,360).setSize(150,50).setImages(boton_opciones,boton_opciones2,boton_opciones2); // boton para opciones
  
  salir_juego= cp5Grup1.addButton("salir")
  .setValue(5).setPosition(235,480).setSize(150,50).setImages(boton_salir,boton_salir2,boton_salir2); // boton para salir
  cp5Grup1.setVisible(false);
  
  cp5Grup2= new ControlP5 (this);// segundo grupo
  cp5Grup2.setBroadcast(false);
  
  menu_juego= cp5Grup2.addButton("menu")
  .setValue(2).setPosition(350,450).setSize(150,50).setImages(boton_menu,boton_menu2,explosion); //boton para menu
  
  opciones1= cp5Grup2.addDropdownList ("Musica").setPosition(370,100).setOpen(false)
  .setBarHeight(30).setItemHeight(30).setHeight(100).setWidth(150);
  String [] opciones1Items = {"Cancion 1", "Cancion 2"};
  float [] opciones1Value= {0,1};
  opciones1.addItems(opciones1Items).setArrayValue(opciones1Value); //Lista de opciones de la musica
  
  opciones2= cp5Grup2.addDropdownList ("Fondo").setPosition(370,250).setOpen(false)
  .setBarHeight(30).setItemHeight(30).setHeight(100).setWidth(150);
  String [] opciones2Items = {"Fondo 1", "Fondo 2"};
  float [] opciones2Value= {0,1};
  opciones2.addItems(opciones2Items).setArrayValue(opciones2Value); // Lista de opciones del fondo 
  cp5Grup2.setVisible(false);
  
  cp5Grup3= new ControlP5 (this);// segundo grupo
  cp5Grup3.setBroadcast(false);
  volver_menu= cp5Grup3.addButton("menu")
  .setValue(2).setPosition(350,450).setSize(150,50).setImages(boton_menu,boton_menu2,explosion);
  cp5Grup3.setVisible(false);
  
  
// Declaracion de las variables de la LIBRERIA MINIM
  myMinim = new Minim(this);
  cancion_1= myMinim.loadFile("christmasIsHere.mp3");
  cancion_2= myMinim.loadFile("magicalChristmas.mp3");
  sonido_disparo= myMinim.loadFile("sonido_disparo.mp3");
  sonido_muerte= myMinim.loadFile("sonido_muerte.wav");
  
  cancion_1.loop();
}

void draw (){
  
  switch(mode){
    case 1:
    introJuego();
    break;
    
    case 2:
    menuJuego();
    break;
    
    case 3:
    jugarJuego();
    break;
    
    case 4:
    opcionesJuego();
    break;
    
    case 5:
    finJuego();
    break;
    
    default:
    mode= 1;
    break;
  }
}

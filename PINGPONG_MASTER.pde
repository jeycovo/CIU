// Juego parecido al PING-PONG
// Minimo rebote, marcador, sonido , movimiento inicial aleatorio
//Aportaciones adicionales, introducción, golpe pefecto (más rápido y fuerte), ganador/perdedor, Ranking, Dificultad
import processing.sound.*;

// Medida de la raqueta
  int raquetaAlto = 100;
  int raquetaAncho = 20;
  
//Posiciones
  int pcX = 100;
  int pcVel = 4;
  int pcY;
  int jugY;
  int jugX;
//bola
  int bolX;
  int bolY;
  int bola_Ancho = 25;
  int bola_Alto = 25;
  float dirX = 0;
  float dirY = 0;
  int bVel = 5;
  
//cosas
  float seg;
  int jugMarcador = 0;
  int pcMarcador = 0;
  int timerGol = 0;
  boolean jugadorGol;
  int pantalla = 1;
  int timer = 0;
  int opacidad = 255;
  int sentidoOpacidad = 1;
  SoundFile sonidoGol;
  SoundFile sonidoRaqueta;
  
void setup(){
  size(1000,1000);
  stroke(255);
  textAlign(CENTER);
  saque();
  //Inicio de variables
  sonidoGol = new SoundFile(this,"Alesis-Sanctuary-QCard-Crotales-C6.wav");
  sonidoRaqueta  = new SoundFile(this,"Bass-Drum-1.wav");
  textSize(16);
}

//He dividido las distintas tareas en métodos para simplificar el código
void draw(){
  if(pantalla == 1){
    pantalla_inicio();
  }else if(pantalla == 2){
    background(0);
    stroke(255);
    fill(255);
    jugador();
    rival();
    pelota();
    textoMarcador();
  }else{
    ganar_perder();
  }
}

//Movimiento de la pelota
void pelota(){
  bolX += dirX*bVel;
  bolY += dirY*bVel;
  ellipse(bolX, bolY, bola_Ancho, bola_Alto);
  println("Pos pelota: X "+bolX+"Y "+bolY + "Pos PC: X " + pcX + "Y "+pcY);
  rebote();
}

//Movimiento de la raqueta rival
void rival(){
  if(bolY > pcY+pcVel){
    pcY = pcY + pcVel;
  }else if (bolY < pcY-pcVel){
    pcY = pcY - pcVel;
  }
  rect(pcX,pcY-raquetaAlto/2,raquetaAncho,raquetaAlto);
}
void jugador(){
  //jugX= mouseX;
  jugY= mouseY;
  rect(jugX,jugY-raquetaAlto/2,raquetaAncho,raquetaAlto);
}

//Mecanicas de rebote
void rebote(){
  //limites del cuadrado (campo)
  if (bolX > width){
    bolX = width;
    dirX = -dirX;
    sonidoGol.play();
    marcador(false);
  }
  if (bolY > height){
    bolY = height;
    dirY = -dirY;
  }
  if (bolX < 0){
    bolX = 0;
    dirX = -dirX;
    sonidoGol.play();
    marcador(true);
  }
  if (bolY < 0){
    bolY = 0;
    dirY = -dirY;
  }
  //choque contra raquetas
  if (((bolX > jugX-(raquetaAncho/2)-bVel) && (bolX < jugX+(raquetaAncho/2)+bVel)) && ((bolY > jugY-(raquetaAlto/2)-bVel) && (bolY < jugY+(raquetaAlto/2)+bVel))){
    bolX = jugX-(raquetaAncho/2);
    dirY = round(random(-1,1));
    dirX *= -1;
    sonidoRaqueta.play();
  }
  if(((bolX < pcX+(raquetaAncho/2)+bVel) && (bolX > pcX-(raquetaAncho/2)-bVel)) && ((bolY > pcY-(raquetaAlto/2)-bVel) && (bolY < pcY+(raquetaAlto/2)+bVel))){
    bolX = pcX+(raquetaAncho/2);
    dirY = round(random(-1,1));
    dirX *= -1;
    sonidoRaqueta.play();
  }
}

//Estado inicial de saque, con movimiento aleatorio
void saque(){
  background(255);
  rect(pcX,pcY,raquetaAncho,raquetaAlto);
  rect(width-pcX,pcY,raquetaAncho,raquetaAlto);
  bolX=width/2;
  bolY=height/2;
  pcY = bolY;
  jugX = width-pcX;
  
  //movimiento de la bola
  dirY = 0;
  dirX = aleatorio();
}
//Devuelve 1 o -1 de forma aleatoria, sirve para elegir la dirección de saque
int aleatorio(){
  if (random(10) > 5){
    return 1;
  }else{
    return -1;
  }
}
//metodo para llevar la cuenta de los goles, tambien se decide cuando se gana o pierde
void marcador(boolean golJugador){
  if(golJugador){
    jugMarcador ++;
    timerGol = 70;
    jugadorGol = true;
  }else{
    pcMarcador ++;
    timerGol = 70;
    jugadorGol = false;
  }
  if(jugMarcador == 3){
    pantalla = 3;
  }else if (pcMarcador == 3){
    pantalla = 3;
  }else{
    saque();
  }
}
//Pantalla inicial, animaciones y demás
void pantalla_inicio(){
    timer++;
    fill(255,255);
    background(0);
    strokeWeight(5);
    textSize(20);
    rect(200,pcY-raquetaAlto/2,raquetaAncho*3,raquetaAlto*3);
    strokeWeight(2);
    if(timer<200){
      line (230,400,200,90);
      text("¿Así que deseas enfrentarte a mi?...",200,50);
    }else if(timer<400){
      line (230,400,200,110);
      text("¡¡¡A PongMaster!!!...",200, 75);
    }else if(timer<600){
      line (230,400,200,130);
      text("Preparate, a ser destruido!!!...",200, 100);
    }else if(timer>600){
      fill(255,opacidad);
      text("Pulsa cualquier tecla para continuar...",width/2,height-100);
      if (opacidad <= 0 || opacidad >= 255){
        sentidoOpacidad = -sentidoOpacidad;
      }
          opacidad += 10 * sentidoOpacidad;
    }
    if (keyPressed){
      pantalla = 2;
    }
 }
//Cuando ganas o pierdes
void ganar_perder(){
  background(0);
  noStroke();
  fill(255);
  if(jugMarcador == 3){
    text("¿Has vencido a Pong-Master? \n ¡¡¡Eso te convierte en el Pong Master!!!",width/2,height/2);
  }else{
    text("¿Has perdido? \n ¡¡¡Eso te convierte en un perdedor!!!",width/2,height/2);
  }
  fill(255,opacidad);
  text("Pulsa una tecla para volver a jugar...",width/2, height-50);
  if (opacidad <= 0 || opacidad >= 255){
        sentidoOpacidad = -sentidoOpacidad;
      }
  opacidad += 10 * sentidoOpacidad;
  if (keyPressed){
    pantalla = 2;
    jugMarcador = 0;
    pcMarcador = 0;
    timerGol= 0;
    saque();
  }
}
//Actualizador del marcador
void textoMarcador(){
  if (timerGol > 0){
    if(jugadorGol){
      text("GOOOOOL Jugador", width/2,height-50);
    }else{
      text("GOOOOOL PONG-MASTER", width/2,height-50);
    }  
    timerGol--;
  }
  text(pcMarcador,(width/2)-25,50);
  line(width/2,20,width/2,80);
  text(jugMarcador,(width/2)+25,50);
}

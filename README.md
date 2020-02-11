# Practica P1 Ping-Pong
Autor: Jacobo Placeres Cabrera

# Trabajo:
  El trabajo resultante consiste en un pequeño juego de Pong, donde como se indica en la escena inicial, uno debe ganar a PongMaster, el maestro del Ping Pong, y marcarle al menos 3 goles, en el caso de que uno gane o pierda, el juego salta a otra pantalla donde se le muestra un texto que dependera del resultado (victoria o derrota) y se le dará la posibilidad de volver a jugar contra PongMaster.
  -La pelota rebota en las paredes superiores e inferiores y en las raquetas.
  
  -El marcador que se muestra en la parte superior se actualiza solo con cada gol.
  
  -Los goles reinician el punto, dejando la pelota en el medio.
  
  -Los goles y golpes de las raquetas tienen sonido propio.
  
# Decisiones:
  Durante el desarrollo de la práctica he tenido que tomar varias decisiones, a continuación enumero algunas de ellas.

  1. Al principio tenía pensado que la pelota rebotara en direcciones aleatorias pero esto causaba que se quedara trabada en algunos puntos de la pared, así que decidi que fuera aleatorio pero dentro de un rango de valores (haciendo que las variables de dirección del eje Y pudieran ser (-1,1,0) y del eje X (-1,1)).
  2. El rebote al principio iba a rebotar en la dirección contraria de donde viniera pero esto causaba que en algunos momentos el juego entrada en bucle (solo rebotes horizontales...).
  3. La velocidad de seguimiento del rival tuvo que ser reducida porque alcanzaba la pelota en el 95% de los casos.
  4. Cambie un timer que empleaba la función seconds() por uno que decrementa su valor con cada ciclo ya que este daba mejor resultado.

# Referencias:
  Para los sonidos he empleado esta página, indicada en el guion de la práctica.
https://freewavesamples.com/

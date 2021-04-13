# CIU_Piano
Por Alejandro García Sosa

## Controles:
**H** - Muestra los controles

**2-6** - Cambia la octava central del piano. Por defecto es la 4, que contiene el *LA440*.

**P** - Cambia la forma de la onfa generada por el instrumento. Por defecto es *Waves.SINE*.

**MouseLeft** - Toca la nota seleccionada.

## Descripción del proyecto:
En esta tarea, el objetivo era combinar gráficos y generación de audio. Para ello, se ha optado por hacer un piano virtual. Por cuestión de tamaño de la pantalla, se ha limitado a solo 3 octavas de forma simultánea en pantalla. Por defecto, la octava central es la que contiene el *LA440*. EL piano tiene distintas formas de onda de salida, y se muestra la onda actual encima del teclado. Al pulsar una tecla, esta cambiará de color para indicar que está siendo pulsada. Las teclas que corresponden a *DO* tienen un círculo negro con la octava a la que pertenecen.

## Desarrollo:
En primer lugar, utilizamos un instrumento de Minim para generar las notas. Para la interfaz gráfica, utilizamos el método *drawPiano()*, que genera un teclado con la colocación correcta de teclas blancas y negras. Este método también se encarga de pintar de gris la tecla seleccionada. En cuanto a la ayuda, se dibuja sobre la base del teclado en el *draw()*.

Las notas están alamcenadas en un array de strings, el cual tiene todas las octavas ordenadas de forma que simplifique su uso. Las notas están en notación anglosajona, y los bemoles y sostenidos están representados como sostenidos. Todas las notas están en el mismo array.
```
"C4", "D4", "E4", "F4", "G4", "A4", "B4","C#4", "D#4", "F#4","G#4", "A#4"
```

Para calcular la nota que se debe tocar, en primer lugar usamos la posición del ratón para saber si está sobre el teclado, y sobre que tecla blanca. Una vez obtenida la nota bas, comprobamos si el color del pixel donde está ell ratón es negro. En ese caso, comprobamos si estamos por la izquierda o por la derecha, y le sumamos posiciones a la variable donde se almacena que telca está siendo pulsada para que coincida con el sostenido o bemol correspondiente. Por último, y antes de reproducir el sonido, ajustamos la escala a la seleccionada. Sobre la onda utilizada, se le pasa como parámetro al instumento, y están almacenadas en un array de Wavwtables.
```
void mousePressed() {
  if(mouseY > 150 && mouseY < 350){
    tecla = (int)((mouseX-25)/50) % 7;
  if(get(mouseX, mouseY) == color(0)){
    if(tecla < 3){
      if((mouseX-25) % 50 > 10){
        tecla += 7;
      }else{
        tecla += 6;
      }
    }else{
    if((mouseX-25) % 50 > 10){
        tecla += 6;
      }else{
        tecla += 5;
      }
    }
  }
  if(mouseX < 375){
    tecla -= 12;
  }
  if (mouseX > 725){
    tecla += 12;
  }
  tecla += 12*(afin-1);
  out.playNote( 0.0, 0.9, new ToneInstrument( Frequency.ofPitch( notas[tecla] ).asHz(), wav[inst] ) ); 
  }
}
```

## Bibliografía:
- Diapositivas de la asignatura de CIU.
- Guion de prácticas de la asignatura de CIU.
- https://www.openprocessing.org/
- Minim: http://code.compartmental.net/tools/minim/
- Notas: https://es.wikipedia.org/wiki/Frecuencias_de_afinaci%C3%B3n_del_piano

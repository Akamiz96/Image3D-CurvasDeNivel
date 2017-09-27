class Render2D {
  Data data;
  /*
    Tamanio donde se dibujaran las curvas de nivel
   Tiene que ser divisible entre 2
   */
  int tam = 750;
  /*
    Variable para escalar los puntos
   */
  int scale = 2;

  Render2D(Data dat) {
    data = dat;
  }

  void render() {
    pushMatrix();
    translate((width/2)-((tam * scale)/2), (height/2)-((tam * scale)/2));
    noFill();
    stroke(0);
    rect(0, 0, tam * scale, tam * scale);
    translate(0, tam * scale);
    /*fill(255, 0, 0);
     ellipse(0, 0, 10, 10);*/
    noFill();
    for (int i = 0; i < data.valoresAdyacentes.size(); i++) {  
      for (int j = 0; j < data.valoresAdyacentes.get(i).size(); j++) {
        float xValue = 0;
        float yValue = 0;
        float zValue = 0;
        xValue = map(data.valoresAdyacentes.get(i).get(j).x, data.maximoX, data.minimoX, 0, tam*scale);
        yValue = map(data.valoresAdyacentes.get(i).get(j).y, data.maximoY, data.minimoY, 0, tam*scale);
        zValue = data.valoresAdyacentes.get(i).get(j).z;
        color Stroke = color(map(zValue, data.minimoZ, data.maximoZ, 0, 255), map(zValue, data.minimoZ, data.maximoZ, 255, 0), 250);
        fill(Stroke,200);
        ellipse(xValue, -yValue, 10, 10);
      }
    }

    for (int i = 0; i < data.valoresAdyacentes.size(); i++) { 
      color Stroke = color(map(data.valoresAdyacentes.get(i).get(0).z, data.minimoZ, data.maximoZ, 0, 255), map(data.valoresAdyacentes.get(i).get(0).z, data.minimoZ, data.maximoZ, 255, 0), 250);
      for (int j = 0; j < data.valoresAdyacentes.get(i).size()-1; j++) {
        PVector Origen = data.valoresAdyacentes.get(i).get(j);
        PVector Destino = data.valoresAdyacentes.get(i).get(j+1);
        float xValue = map(Origen.x, data.maximoX, data.minimoX, 0, tam*scale);
        float yValue = map(Origen.y, data.maximoY, data.minimoY, 0, tam*scale);
        float xValue2 = map(Destino.x, data.maximoX, data.minimoX, 0, tam*scale);
        float yValue2 = map(Destino.y, data.maximoY, data.minimoY, 0, tam*scale);
        stroke(Stroke);
        line(xValue, -yValue, xValue2, -yValue2);
      }
    }

    popMatrix();
  }
}
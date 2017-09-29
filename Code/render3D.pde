class Render3D {
  Data data;
  //Tamanio de la presentacion en 3D
  float squareSize = 500;
  Render3D(Data dat) {
    data = dat;
  }
  void render() {
    noFill();
    stroke(0);
    box(squareSize);
    pushMatrix();
    translate(-squareSize/2,squareSize/2,squareSize/2);
    pushMatrix();
    rotateX(PI/2);
    for (int i = 0; i < data.valoresAdyacentes.size(); i++) {  
      for (int j = 0; j < data.valoresAdyacentes.get(i).size(); j++) {
        float xValue = 0;
        float yValue = 0;
        float zValue = 0;
        xValue = map(data.valoresAdyacentes.get(i).get(j).x, data.minimoX, data.maximoX, 0, squareSize);
        yValue = map(data.valoresAdyacentes.get(i).get(j).y, data.minimoY, data.maximoY, 0, squareSize);
        zValue = map(data.valoresAdyacentes.get(i).get(j).z, data.minimoZ, data.maximoZ, 0, squareSize);
        color Stroke = color(map(data.valoresAdyacentes.get(i).get(0).z,data.minimoZ, data.maximoZ, 0, 255), map(data.valoresAdyacentes.get(i).get(0).z,data.minimoZ, data.maximoZ, 255, 0), 250);
        fill(Stroke);
        noStroke();
        pushMatrix();
        translate(xValue, -yValue, zValue);
        sphere(2);
        popMatrix();
      }
    }
  
    for (int i = 0; i < data.valoresAdyacentes.size(); i++) { 
      color Stroke = color(map(data.valoresAdyacentes.get(i).get(0).z,data.minimoZ, data.maximoZ, 0, 255), map(data.valoresAdyacentes.get(i).get(0).z,data.minimoZ, data.maximoZ, 255, 0), 250);
      for (int j = 0; j < data.valoresAdyacentes.get(i).size()-1; j++) {
        PVector Origen = data.valoresAdyacentes.get(i).get(j);
        PVector Destino = data.valoresAdyacentes.get(i).get(j+1);
        float xValue = map(Origen.x, data.minimoX, data.maximoX, 0, squareSize);
        float yValue = map(Origen.y, data.minimoY, data.maximoY, 0, squareSize);
        float zValue = map(Origen.z, data.minimoZ, data.maximoZ, 0, squareSize);
        float xValue2 = map(Destino.x, data.minimoX, data.maximoX, 0, squareSize);
        float yValue2 = map(Destino.y, data.minimoY, data.maximoY, 0, squareSize);
        float zValue2 = map(Destino.z, data.minimoZ, data.maximoZ, 0, squareSize);
        stroke(Stroke);
        line(xValue, -yValue, zValue, xValue2, -yValue2, zValue2);
      }
    }
    popMatrix();

    popMatrix();
  }
}
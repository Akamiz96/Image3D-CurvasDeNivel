class Data {
  //Variable para guardar los valores obtenidos
  ArrayList<PVector> values;
  /*
    Variable para organizar los datos 
   por valores iguales de z
   */
  ArrayList<ArrayList<PVector>> valoresOrdenados;
  /*
    Variables que contienen los valores 
   maximos y minimos para las 3 componentes 
   de los datos. 
   */
  float maximoX;
  float maximoY;
  float maximoZ;
  float minimoX;
  float minimoY;
  float minimoZ;
  /*
    area de encuentro de puntos adyacentes
   */
  float maxDistance = 50;
  /*
    Variable para organizar los datos adyacentes a valoresOrdenados
   por valores iguales de z
   */
  ArrayList<ArrayList<PVector>> valoresAdyacentes;

  Data() {
    values = new ArrayList<PVector>();
    valoresOrdenados = new ArrayList<ArrayList<PVector>>();
    valoresAdyacentes = new ArrayList<ArrayList<PVector>>();
  }

  void setValues(ArrayList<PVector> nValues) {
    values = nValues;
    maxX();
    maxY();
    maxZ();
    minX();
    minY();
    minZ();
    organizar();
    organizarAdyacentes();
  }

  void maxX() {
    float max = 0;
    for (int i = 0; i < values.size(); i++) {
      if (data.values.get(i).x > max)
        max = data.values.get(i).x;
    }
    maximoX = max;
  }

  void minX() {
    float min = maximoX;
    for (int i = 0; i < values.size(); i++) {
      if (data.values.get(i).x < min)
        min = data.values.get(i).x;
    }
    minimoX = min;
  }

  void maxY() {
    float max = 0;
    for (int i = 0; i < values.size(); i++) {
      if (data.values.get(i).y > max)
        max = data.values.get(i).y;
    }
    maximoY = max;
  }

  void minY() {
    float min = maximoY;
    for (int i = 0; i < data.values.size(); i++) {
      if (data.values.get(i).y < min)
        min = data.values.get(i).y;
    }
    minimoY = min;
  }

  void maxZ() {
    float max = 0;
    for (int i = 0; i < values.size(); i++) {
      if (data.values.get(i).z > max)
        max = data.values.get(i).z;
    }
    maximoZ = max;
  }

  void minZ() {
    float min = maximoZ;
    for (int i = 0; i < values.size(); i++) {
      if (data.values.get(i).z < min)
        min = data.values.get(i).z;
    }
    minimoZ = min;
  }

  void organizar() {
    println("Organizar");
    ArrayList<PVector> newZ = new ArrayList<PVector>();
    boolean encontrado = false;
    newZ.add(data.values.get(0));
    valoresOrdenados.add(newZ);
    for (int i = 1; i < values.size(); i++) {
      encontrado = false;
      for (int j = 0; j < valoresOrdenados.size(); j++) {
        if (data.values.get(i).z == valoresOrdenados.get(j).get(0).z) {
          valoresOrdenados.get(j).add(data.values.get(i));
          encontrado = true;
        }
      }
      if (!encontrado) {
        newZ = new ArrayList<PVector>();
        newZ.add(data.values.get(i));
        valoresOrdenados.add(newZ);
      }
    }
    for (int j = 0; j < valoresOrdenados.size(); j++) {
      print(j);
      print("->");
      println(valoresOrdenados.get(j));
    }
  }

  void organizarAdyacentes() {
    println("Organizar Adyacentes");
    for (int i = 0; i < valoresOrdenados.size(); i++) {
      ArrayList<PVector> Ordenado = new ArrayList<PVector>();

      float minDist = maxDistance;
      PVector minimo = new PVector(-1, -1);
      for (int j = 0; j < valoresOrdenados.get(i).size(); j++) {
        PVector Origen = valoresOrdenados.get(i).get(j);
        if (dist(0, 0, Origen.x, Origen.y) < minDist) {
          minimo = Origen;
          minDist = dist(0, 0, Origen.x, Origen.y);
        }
      }
      
      println(minimo);
      
      if (valoresOrdenados.get(i).size() == 1) {
        Ordenado.add(minimo);
        valoresOrdenados.get(i).remove(minimo);
        valoresAdyacentes.add(Ordenado);
      } else {
        while (valoresOrdenados.get(i).size() > 0) {
          float minDist2 = maxDistance;
          PVector minimo2 = new PVector(-1, -1);
          for (int j = 0; j < valoresOrdenados.get(i).size(); j++) {
            PVector Origen = valoresOrdenados.get(i).get(j);
            if (dist(minimo.x, minimo.y, Origen.x, Origen.y) < minDist2) {
              minimo2 = Origen;
              minDist2 = dist(minimo.x, minimo.y, Origen.x, Origen.y);
            }
          }
          Ordenado.add(minimo2);
          valoresOrdenados.get(i).remove(minimo2);
        }

        valoresAdyacentes.add(Ordenado);
      }
      println(valoresAdyacentes);
    }
  }
}
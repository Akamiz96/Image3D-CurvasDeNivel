char separador = '\t';
//Variable para guardar los valores obtenidos
Data data;
//
Render2D render2d;
//
Render3D render3d;
/*
  Variable para decidir si el archivo 
 fue seleccionado de manera correcta
 */
boolean selected = false;
/*
  Variable para controlar el modo de operacion
 ->false: 3d
 ->true: 2d
 */
boolean mode = false;
//Color del fondo para la presentacion de datos
color bcolor = color(51);
//Variable para el control de rotacion
float rotX = 0;
float rotY = 0;
//variable para el control de movimiento
float distance = 0;

//Funcion cuya ejecucion es unica
void setup() {
  size(1000, 800, P3D);
  background(bcolor);
  colorMode(HSB);
  data = new Data();
  selectInput("Select a file to process:", "fileSelected");
  render2d = new Render2D(data);
  render3d = new Render3D(data);
}

/*
  Funcion para la seleccion del archivo donde 
 se encuentran los datos
 */
void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
  }
  if (selection != null) {
    ArrayList<PVector> values = new ArrayList<PVector>();
    String[] lines = loadStrings(selection.getAbsolutePath());
    for (int i = 0; i < lines.length; i++) {
      String[] numbers = split(lines[i], separador);
      if (!numbers[0].contains("#")) {
        PVector newValue = new PVector(Float.valueOf(numbers[0].trim()), Float.valueOf(numbers[1].trim()), Float.valueOf(numbers[2].trim()));
        values.add(newValue);
        print("X: ");
        print(newValue.x);
        print(" Y: ");
        print(newValue.y);
        print(" Z: ");
        println(newValue.z);
      }
    }
    selected = true;
    data.setValues(values);
  }
}

//Funcion ejecutado en un ciclo infinito
void draw() {
  if (selected) {
    if (!mode) {
      pushMatrix();
      translate(width/2, height/2, -distance);
      rotateX(rotY);
      rotateY(rotX);
      background(bcolor);
      render3d.render();
      popMatrix();
    } else {
      pushMatrix();
      translate(rotX, rotY, -distance);
      background(bcolor);
      render2d.render();
      popMatrix();
    }
  }
}

/*
  Funcion para el control de rotacion dado 
 por el mouse
 */
void mouseDragged() {
  if (!mode) {
    rotX += (mouseX-pmouseX)*0.01;
    rotY -= (mouseY-pmouseY)*0.01;
  } else {
    rotX += (mouseX-pmouseX);
    rotY += (mouseY-pmouseY);
  }
}

/*
  Funcion para el control de rotacion dado 
 por el teclado
 */
void keyPressed() {
  if (keyCode == UP) {
    distance -= 10;
  }
  if (keyCode == DOWN) {
    distance += 10;
  }
  if (keyCode == RIGHT) {
    if (!mode)
      rotX += 0.1;
    else
      rotX += 1;
  }
  if (keyCode == LEFT) {
    if (!mode)
      rotX -= 0.1;
    else
      rotX -= 1;
  }
  if (keyCode == 'C' || keyCode == 'c') {
    mode = !mode;
    rotX = 0;
    rotY = 0;
    distance = 0;
  }
  if (keyCode == 'R' || keyCode == 'r') {
    rotX = 0;
    rotY = 0;
    distance = 0;
  }
  if (keyCode == 'W' || keyCode == 'w') {
    distance -= 50;
  }
  if (keyCode == 'S' || keyCode == 's') {
    distance += 50;
  }
  if (keyCode == 'D' || keyCode == 'd') {
    if (!mode)
      rotX += 0.5;
    else
      rotX += 10;
  }
  if (keyCode == 'A' || keyCode == 'a') {
    if (!mode)
      rotX -= 0.5;
    else
      rotX -= 10;
  }
}
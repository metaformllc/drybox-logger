// Need G4P library
import g4p_controls.*;

import processing.serial.*;

Configuration config = new Configuration();

int ARDUINO_COM_PORT = -1;
String ARDUINO_COM_PORT_NAME = "";

Arduino arduino = new Arduino(this);


public void setup() {
  size(600, 400, JAVA2D);
  createGUI();
  customGUI();
  // Place your setup code here

  if (config.ARDUINO_PORT ==  "") {
    drop_arduino_serial.setItems(Serial.list(), 0);
    ARDUINO_COM_PORT = drop_arduino_serial.getSelectedIndex();
  } else {
    drop_arduino_serial.setItems(new String[]{config.ARDUINO_PORT}, 0);
    ARDUINO_COM_PORT = Arrays.asList(Serial.list()).indexOf(config.ARDUINO_PORT);
  }
}

public void draw()
{

  arduino.update();

  updateGUI();

  background(230);
}

public void updateGUI()
{
  
}

// Use this method to add additional statements
// to customise the GUI controls
public void customGUI() {
}

import java.util.Arrays;
import java.util.Queue;
import java.util.List;
import java.util.LinkedList;

public class Arduino
{
  private String recordingPath = "testout";
  private PrintWriter output;
  
  private Queue<Long> receivedData = new LinkedList<Long>();
  private long lastReading = 0;

  int totalReadings = 0;
  boolean isEnabled = true;

  PApplet parent;
  Serial com;
  String port;

  Arduino(PApplet p) {
    this.parent = p;

    String timestamp = UtilityMethods.getFormattedYMD() + "_" + UtilityMethods.getFormattedTime(false);
    //output = createWriter(recordingPath + "/fts"+ timestamp + ".csv");
    println("Created: " + config.ROOT_DIR + "/drybox_"+ timestamp + ".csv");
    output = createWriter(config.ROOT_DIR + "/drybox_"+ timestamp + ".csv");
    output.println( UtilityMethods.createLine("temp", "humidity") );
  }

  Arduino(PApplet p, String port) {
    this.parent = p;
    this.port = port;
    open(port);
    
    String timestamp = UtilityMethods.getFormattedYMD() + "_" + UtilityMethods.getFormattedTime(false);
    //output = createWriter(recordingPath + "/fts"+ timestamp + ".csv");
    output = createWriter(config.ROOT_DIR + "/drybox_"+ timestamp + ".csv");
    println("Created: " + config.ROOT_DIR + "/drybox_"+ timestamp + ".csv");
    output.println( UtilityMethods.createLine("temp", "humidity") );
  }

  Arduino(Serial s) {
    com = s;
  }

  public boolean open(String port)
  {
    try {
      println("Opening Arduinno port: " + port);
      com = new Serial(this.parent, port, 1000000);
      return true;
    }
    catch(Exception e) {
      return false;
    }
  }

  public void update()
  {
    if ( com != null && com.available() > 0) 
    {  // If data is available,
      String val = trim(com.readStringUntil('\n'));         // read it and store it in val
      if (val != null) {
        try {
          output.println( val );
          txtbox_series_results.setText(val);
          //List<String> stringList = Arrays.asList(val.split(","));
          //if (isEnabled) {
          //receivedData.add(newReading);
          //}
        }
        catch(Exception e) {
        }
      }
    }
  }

  public boolean isDataAvailable()
  {
    return !receivedData.isEmpty();
  }

  public Queue<Long> getData()
  {
    return receivedData;
  }

  public long getLastReading()
  {
    return this.lastReading;
  }

  public void clearData()
  {
    if (!receivedData.isEmpty()) {
      receivedData.clear();
    }
  }

  public void enable()
  {
    clearData();
    this.isEnabled = true;
  }

  public void disable()
  {
    this.isEnabled = false;
    clearData();
  }

  public boolean isEnabled()
  {
    return this.isEnabled;
  }

  public void close()
  {
    com.stop();
    if (output != null) {
      output.flush(); // Writes the remaining data to the file
      output.close();
    }
  }
}

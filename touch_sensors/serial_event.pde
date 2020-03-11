//This is the function that receives and parses the data
//it executes whenever data is received 
void serialEvent(Serial arduinoPort) {
  rawIncomingValues = arduinoPort.readStringUntil('\n');
  
  //if there actually is a valid incoming value, we use the splitTokens
  //this splits the incoming string into an array of integers that is easy to work with
  if (rawIncomingValues != null) {
    incomingValues = int(trim(splitTokens(rawIncomingValues, ",")));
    //println(incomingValues);
  }
}

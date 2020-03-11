//This is the function that receives and parses the data
//it executes whenever data is received 
void serialEvent(Serial arduinoPort) {
  rawIncomingValues = arduinoPort.readStringUntil('\n');
  
  //if there actually is a valid incoming value, we use the splitTokens
  //this splits the incoming string into an array of integers that is easy to work with
  if (rawIncomingValues != null) {
    int[] vals = int(trim(splitTokens(rawIncomingValues, ",")));
    if(vals.length != 2) { return; }
    //println(vals);
    incomingValuesX.add(vals[0]);
    incomingValuesY.add(vals[1]);
    if(incomingValuesX.size() > 5) { incomingValuesX.remove(0); }
    if(incomingValuesY.size() > 5) { incomingValuesY.remove(0); }
  }
}

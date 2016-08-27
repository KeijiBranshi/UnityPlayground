#pragma strict
     
 function OnTriggerEnter(col : Collider) {
 	Debug.Log("Trigger Detected");
    GetComponent.<Renderer>().sharedMaterial.SetVector("_ShieldColor", Vector4(0.7, 1, 1, 0.05));
             
    GetComponent.<Renderer>().sharedMaterial.SetVector("_Position", Vector4(1,1,1,1);
 }
 
  function OnTriggerExit(col : Collider) {
 	Debug.Log("Trigger Exited");
    GetComponent.<Renderer>().sharedMaterial.SetVector("_ShieldColor", Vector4(0.7, 1, 1, 0.05));
             
    GetComponent.<Renderer>().sharedMaterial.SetVector("_Position", Vector4(1,1,1,1);
 }
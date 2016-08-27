#pragma strict

var leftBoundCol : Color;
var rightBoundCol : Color;

var leftBound : float;
var rightBound : float;


function Start () {

}

function Update () {
var lerpParam = Mathf.InverseLerp(leftBound, rightBound, transform.position.z);
GetComponent.<Renderer>().material.color = Color.Lerp(leftBoundCol, rightBoundCol, lerpParam);
}
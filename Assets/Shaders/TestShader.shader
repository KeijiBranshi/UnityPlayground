 Shader "Custom/TestShader" {
     Properties {
         [PerRendererData] _Color ("Color (RGBA)", Color) = (0.7, 1, 1, 0.2)
         
         _Normal ("Normal Vector (of Plane)", Vector) = (0,0,0,0)
		 _PlanePosition("Position of Viewing Plane", Vector) = (0,0,0,0)
		 _Distance ("Distance (Between Planes)", Float) = 0
     } 
     SubShader {
         Tags { "Queue" = "Transparent" "RenderType" = "Transparent"}
         ZWrite Off
         LOD 2000
         Cull Off
         
       
         CGPROGRAM
           #pragma surface surf Lambert alpha
           #pragma target 3.0
       
          struct Input {
             float4 mycolor : COLOR;
             float3 worldPos;
           };
       
           float _Amount;
           float4 _Color;  
           float4 _Position;
           float _MaxDistance;  
           float myDist;  
           
           //My Additions
		uniform float4 _Normal;
		uniform float4 _PlanePosition;
		uniform float _Distance;
       
       
           void surf (Input IN, inout SurfaceOutput o) {
            o.Albedo = _Color.rgb;
             float4 unitNorm = _Normal / length(_Normal);
			float3 relativePos = IN.worldPos - _PlanePosition;
			float projection = dot(relativePos, unitNorm);
			
			if (projection < _Distance && projection > -1*_Distance) {
				o.Alpha = 1;
			} else
				o.Alpha = 0;
           }
       
           ENDCG
     } 
     Fallback "Transparent/Diffuse"
 }
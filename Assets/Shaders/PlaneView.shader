Shader "Custom/PlaneView" {
	Properties {
		_Color ("Default Color", Color)
		_Normal ("Normal Vector (of Plane)", Vector) = (0,0,0,0)
		_PlanePosition("Position of Viewing Plane", Vector) = (0,0,0,0)
		_Distance ("Distance (Between Planes)", Float) = 0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		
		#pragma vertex vert
		#pragma target 3.0

		uniform float4 _Normal;
		uniform float4 _PlanePosition;
		uniform float _Distance;
		
		//Input needed to calculate if membrane should be transparent
		struct Input {
			float4 pos : POSITION;
			float4 col : COLOR0;
		};
		struct Output {
			float4 pos : SV_POSITION;
			float4 col : COLOR0;
		};
		
		Output vert (Input IN) {
			Output o;
			
			float4 unitNorm = _Normal / length(_Normal);
			float4 relativePos = IN.pos - _PlanePosition;
			float projection = dot(relativePos, unitNorm);
			
			if (projection < _Distance) {
				o.col.a = 1;
			} else
				o.col.a = .1;
	
			return o;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}

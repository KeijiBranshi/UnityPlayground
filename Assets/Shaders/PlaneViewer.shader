Shader "Custom/PlaneViewer" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
		
		_Normal ("Normal Vector (of Plane)", Vector) = (0,0,0,0)
		_PlanePosition("Position of Viewing Plane", Vector) = (0,0,0,0)
		_Distance ("Distance (Between Planes)", Float) = 0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
			float4 pos : TEXCOORD;
		};

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;
		
		//My Additions
		uniform float4 _Normal;
		uniform float4 _PlanePosition;
		uniform float _Distance;

		void surf (Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = c.a;
			
			float4 unitNorm = _Normal / length(_Normal);
			float4 relativePos = IN.pos - _PlanePosition;
			float projection = dot(relativePos, unitNorm);
			
			if (projection < _Distance) {
				o.Alpha = c.a;
			} else
				o.Alpha = 0.1;
		}
		
		
		//Input needed to calculate if membrane should be transparent
		struct vertexInput {
			float4 pos : POSITION;
			float4 col : COLOR0;
		};
		struct vertexOutput {
			float4 pos : SV_POSITION;
			float4 col : COLOR0;
		};
		
		vertexOutput vert (vertexInput IN) {
			vertexOutput o;
			
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

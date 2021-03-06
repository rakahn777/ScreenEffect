﻿Shader "Wrathlust/Distortion"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_DistortionTex ("Distortion", 2D) = "white" {}
		_Strength ("Strength", Range(0, 1)) = 1.0
	}
	SubShader
	{
		Pass
		{
			CGPROGRAM
			#pragma vertex vert_img
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			sampler2D _MainTex;
			sampler2D _DistortionTex;
			float _Strength;
			
			fixed4 frag (v2f_img i) : SV_Target
			{
				fixed2 rg = tex2D(_DistortionTex, i.uv);
				fixed2 shifted = rg * 2 - 1;
				i.uv += shifted * sin(_Time.y) * _Strength;
				i.uv = saturate(i.uv);

				fixed4 col = tex2D(_MainTex, i.uv);

				return col;
			}
			ENDCG
		}
	}
}

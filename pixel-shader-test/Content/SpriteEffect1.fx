#if OPENGL
	#define SV_POSITION POSITION
	#define VS_SHADERMODEL vs_3_0
	#define PS_SHADERMODEL ps_3_0
#else
	#define VS_SHADERMODEL vs_4_0_level_9_1
	#define PS_SHADERMODEL ps_4_0_level_9_1
#endif

Texture2D SpriteTexture;
sampler s0;
float epsilon = 0.001f;

sampler shadow_sampler;


sampler2D SpriteTextureSampler = sampler_state
{
	Texture = <SpriteTexture>;
};

struct VertexShaderOutput
{
	float4 Position : SV_POSITION;
	float4 Color : COLOR0;
	float2 TextureCoordinates : TEXCOORD0;
};


bool colorMatches(float4 color, float red, float green, float blue) 
{
	float normalizedRed = red / 255.0f;
	float normalizedGreen = green / 255.0f;
	float normalizedBlue = blue / 255.0f;

	float difRed = abs(color.r - normalizedRed);
	float difGreen = abs(color.g - normalizedGreen);	
	float difBlue = abs(color.b - normalizedBlue);	

	bool matches = false;
	if(color.a && difRed < epsilon && difGreen < epsilon && difBlue < epsilon)
		matches = true;

	return matches;

}


float4 MainPS(VertexShaderOutput input) : COLOR
{
	float4 color = tex2D(s0, input.TextureCoordinates);
	float4 shadow_color = tex2D(shadow_sampler, input.TextureCoordinates);

	if( shadow_color.a && colorMatches(shadow_color, 85.0f, 255.0f, 85.0f))
	{
		if(color.a && colorMatches(color, 255, 71, 58))
		{
			color.r = 119.0f / 255.0f;
			color.g = 255.0f / 255.0f;
			color.b = 133.0f / 255.0f;
		}
		else {
			color.rgb = 0.2;				
		}

	}

	// color.r = 119.0f / 255.0f;
	// color.g = 255.0f / 255.0f;
	// color.b = 133.0f / 255.0f;


	
  	return color;

}




technique SpriteDrawing
{
	pass P0
	{
		PixelShader = compile PS_SHADERMODEL MainPS();
	}
};
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
float2 testFloat2Array[2];

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



float4 MainPS(VertexShaderOutput input) : COLOR
{
	float4 color = tex2D(s0, input.TextureCoordinates);
	float4 shadow_color = tex2D(shadow_sampler, input.TextureCoordinates);


	float refRed = 85.0f / 255.0f;
	float refGreen = 1.0f;
	float refBlue = 85.0f / 255.0f;

	float difRed = abs(shadow_color.r - refRed);
	float difGreen = abs(shadow_color.g - refGreen);	
	float difBlue = abs(shadow_color.b - refBlue);	

	if(shadow_color.a && difRed < epsilon && difGreen < epsilon && difBlue < epsilon)
		color.rgb = 0.8;	


	// if (color.a)
 //    	return shadow_color;
    // else
    	return color;

}


// float4 MainPS(VertexShaderOutput input) : COLOR
// {
// 	float4 color = tex2D(s0, input.TextureCoordinates);

// 	float refRed = 86.0f / 255.0f;
// 	float refGreen = 1.0f;
// 	float refBlue = 92.0f / 255.0f;

// 	float difRed = abs(color.r - refRed);
// 	float difGreen = abs(color.g - refGreen);	
// 	float difBlue = abs(color.b - refBlue);	

// 	if(color.a && difRed < epsilon && difGreen < epsilon && difBlue < epsilon)
// 		color.rgb = 0.8;	


// 	float pixelToSetX =  testFloat2Array[0].x;
// 	float pixelToSetY =  testFloat2Array[0].y;

// 	float diff1 = abs(input.TextureCoordinates.x - pixelToSetX);
// 	float diff2 = abs(input.TextureCoordinates.y - pixelToSetY);

// 	if( (diff1 < epsilon) && (diff2 < epsilon) ) {
// 		color.b = 1.0f;
// 		color.rg = 0.0f;
// 	}


// 	return color;
// }


technique SpriteDrawing
{
	pass P0
	{
		PixelShader = compile PS_SHADERMODEL MainPS();
	}
};
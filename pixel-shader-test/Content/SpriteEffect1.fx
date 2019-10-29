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
float epsilon = 0.0001f;

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

	float refRed = 86.0f / 255.0f;
	float refGreen = 1.0f;
	float refBlue = 92.0f / 255.0f;

	float difRed = abs(color.r - refRed);
	float difGreen = abs(color.g - refGreen);	
	float difBlue = abs(color.b - refBlue);	

	if(color.a && difRed < epsilon && difGreen < epsilon && difBlue < epsilon)
		color.rgb = 0.8;	

	return color;
}


technique SpriteDrawing
{
	pass P0
	{
		PixelShader = compile PS_SHADERMODEL MainPS();
	}
};
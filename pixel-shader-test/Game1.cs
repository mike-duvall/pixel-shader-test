using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Graphics;
using Microsoft.Xna.Framework.Input;

namespace PixelShaderTest
{
    /// <summary>
    /// This is the main type for your game.
    /// </summary>
    public class Game1 : Game
    {
        GraphicsDeviceManager graphics;
        SpriteBatch spriteBatch;

        Texture2D surgeTexture;
        Texture2D backgroundTexture2D;
        private Texture2D shadowTexture2D;

        private Effect effect;

        public Game1()
        {
            graphics = new GraphicsDeviceManager(this);
            Content.RootDirectory = "Content";
        }



        /// <summary>
        /// Allows the game to perform any initialization it needs to before starting to run.
        /// This is where it can query for any required services and load any non-graphic
        /// related content.  Calling base.Initialize will enumerate through any components
        /// and initialize them as well.
        /// </summary>
        protected override void Initialize()
        {
            // TODO: Add your initialization logic here

            base.Initialize();
        }

        /// <summary>
        /// LoadContent will be called once per game and is the place to load
        /// all of your content.
        /// </summary>
        protected override void LoadContent()
        {
            // Create a new SpriteBatch, which can be used to draw textures.
            spriteBatch = new SpriteBatch(GraphicsDevice);
            surgeTexture = Content.Load<Texture2D>("surge2");
            backgroundTexture2D = Content.Load<Texture2D>("background2");
            shadowTexture2D = Content.Load<Texture2D>("shadow2");
            effect = Content.Load<Effect>("SpriteEffect1");

            // TODO: use this.Content to load your game content here
        }

        /// <summary>
        /// UnloadContent will be called once per game and is the place to unload
        /// game-specific content.
        /// </summary>
        protected override void UnloadContent()
        {
            // TODO: Unload any non ContentManager content here
        }

        /// <summary>
        /// Allows the game to run logic such as updating the world,
        /// checking for collisions, gathering input, and playing audio.
        /// </summary>
        /// <param name="gameTime">Provides a snapshot of timing values.</param>
        protected override void Update(GameTime gameTime)
        {
            if (GamePad.GetState(PlayerIndex.One).Buttons.Back == ButtonState.Pressed || Keyboard.GetState().IsKeyDown(Keys.Escape))
                Exit();

            // TODO: Add your update logic here

            base.Update(gameTime);
        }



        /// <summary>
        /// This is called when the game should draw itself.
        /// </summary>
        /// <param name="gameTime">Provides a snapshot of timing values.</param>
        protected override void Draw(GameTime gameTime)
        {
            GraphicsDevice.Clear(Color.CornflowerBlue);

            spriteBatch.Begin(SpriteSortMode.Immediate, BlendState.AlphaBlend);
            effect.Parameters["shadow_sampler"].SetValue(shadowTexture2D);
            effect.CurrentTechnique.Passes[0].Apply();
//            spriteBatch.Draw(backgroundTexture2D, new Vector2(0, 0), Color.White);
//            spriteBatch.Draw(surgeTexture, new Vector2(0, 0), Color.White);
            spriteBatch.Draw(shadowTexture2D, new Vector2(0, 0), Color.White);


            spriteBatch.End();

            base.Draw(gameTime);
        }


        //        /// <summary>
        //        /// This is called when the game should draw itself.
        //        /// </summary>
        //        /// <param name="gameTime">Provides a snapshot of timing values.</param>
        //        protected override void Draw(GameTime gameTime)
        //        {
        //            GraphicsDevice.Clear(Color.CornflowerBlue);
        //
        //            Vector2[] testFloat2Array = new Vector2[2];
        //
        //
        //            float widthOfOnePixel = 1.0f / surgeTexture.Width;
        //            float widthOfHalfPixel = widthOfOnePixel / 2.0f;
        //
        //            float heightOfOnePixel = 1.0f / surgeTexture.Height;
        //            float heighOfHalfPixel = heightOfOnePixel / 2.0f;
        //
        //
        //            float textureCoordianteX = (15.0f * widthOfOnePixel) + widthOfHalfPixel;
        //            float textureCoordianteY = (16.0f * heightOfOnePixel) + heighOfHalfPixel;
        //
        //
        //            testFloat2Array[0] = new Vector2(textureCoordianteX, textureCoordianteY);
        //            testFloat2Array[1] = new Vector2(5, 7);
        //
        //            //            spriteBatch.Begin();
        //            spriteBatch.Begin(SpriteSortMode.Immediate, BlendState.AlphaBlend);
        //            effect.Parameters["testFloat2Array"].SetValue(testFloat2Array);
        //            effect.CurrentTechnique.Passes[0].Apply();
        //            spriteBatch.Draw(backgroundTexture2D, new Vector2(0, 0), Color.White);
        //            spriteBatch.Draw(surgeTexture, new Vector2(0, 0), Color.White);
        //
        //            spriteBatch.End();
        //
        //            base.Draw(gameTime);
        //        }
    }
}

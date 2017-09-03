package com.mygdx.game;
import com.badlogic.gdx.ApplicationAdapter;
import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.graphics.GL20;
import com.badlogic.gdx.graphics.OrthographicCamera;
import com.badlogic.gdx.graphics.g2d.Animation;
import com.badlogic.gdx.graphics.g2d.Animation.PlayMode;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.badlogic.gdx.graphics.g2d.TextureAtlas;
import com.badlogic.gdx.graphics.g2d.TextureAtlas.AtlasRegion;
import com.badlogic.gdx.graphics.g2d.TextureRegion;
import com.badlogic.gdx.utils.Array;
import com.badlogic.gdx.utils.viewport.FitViewport;
import com.badlogic.gdx.utils.viewport.Viewport;
import java.util.Comparator;

public class MyGdxGame extends ApplicationAdapter {

	private int dameByRow = 0;
	private int dameByCol = 0;
	private int dameByField = 0;

	private float WORLD_TO_SCREEN = 1.0f / 100.0f;
	private float SCENE_WIDTH;
	private float SCENE_HEIGHT;
	private static final float FRAME_DURATION = 1.0f / 20.0f;

	//Row
	private TextureAtlas textureAtlasRow;
	private Animation animationRow;
	private float animationRowTime;

	//Col
	private TextureAtlas textureAtlasCol;
	private Animation animationCol;
	private float animationColTime;

	//Field
	private TextureAtlas textureAtlasField;
	private Animation animationField;
	private float animationFieldTime;


	private OrthographicCamera camera;
	public Viewport viewport;
	public SpriteBatch batch;


	public void MyShowLog(){
		Gdx.app.log("clgtGDX", "width"+SCENE_WIDTH+"  --- "+SCENE_HEIGHT);

	}

	public void dameBossByRow(int dame){
		this.dameByRow = dame;

	}

	public void dameBossByCol(int dame){

		this.dameByCol = dame;

	}

	public void dameBossByField(int dame){


		this.dameByField = dame;
	}

	private void animByRowInit(){
		animationRowTime = 0.0f;
		textureAtlasRow = new TextureAtlas(Gdx.files.internal("data/CaptainAmerica.txt"));
		Array<TextureAtlas.AtlasRegion> techmanRegions = new Array<TextureAtlas.AtlasRegion>(textureAtlasRow.getRegions());
		techmanRegions.sort(new RegionComparator());
		animationRow = new Animation(FRAME_DURATION, techmanRegions, PlayMode.NORMAL);
		//camera.position.set(0.0f, 0.0f, 0.0f);

	}


	private void animByColInit(){
		animationColTime = 0.0f;
		textureAtlasCol = new TextureAtlas(Gdx.files.internal("data/CaptainAmerica.txt"));
		Array<TextureAtlas.AtlasRegion> techmanRegions = new Array<TextureAtlas.AtlasRegion>(textureAtlasCol.getRegions());
		techmanRegions.sort(new RegionComparator());
		animationCol = new Animation(FRAME_DURATION, techmanRegions, PlayMode.NORMAL);


	}

	private void animByFieldInit(){
		animationFieldTime = 0.0f;
		textureAtlasField = new TextureAtlas(Gdx.files.internal("data/CaptainAmerica.txt"));
		Array<TextureAtlas.AtlasRegion> techmanRegions = new Array<TextureAtlas.AtlasRegion>(textureAtlasField.getRegions());
		techmanRegions.sort(new RegionComparator());
		animationField = new Animation(FRAME_DURATION, techmanRegions, PlayMode.NORMAL);


	}


	private void animByRowDame(){
		animationRowTime += Gdx.graphics.getDeltaTime();
		camera.update();
		batch.setProjectionMatrix(camera.combined);
		batch.begin();
		TextureRegion techmanFrame = (TextureRegion) animationRow.getKeyFrame(animationRowTime);
		int width = techmanFrame.getRegionWidth();
		int height = techmanFrame.getRegionWidth();
		float originX = width * 0.5f;
		float originY = height * 0.5f;

		//batch.draw(techmanFrame,1.0f - originX, 3.70f - originY,originX, originY,width, height,WORLD_TO_SCREEN, WORLD_TO_SCREEN,0.0f);
		batch.draw((TextureRegion) animationRow.getKeyFrame(animationRowTime), 0.0f-width/2, 0.0f-height/2);
		batch.end();
		if (animationRow.isAnimationFinished(animationRowTime)) {
			Gdx.app.log("clgtGDX", "Dame  Row "+dameByRow);
			dameByRow = 0;
			animationRowTime = 0;
		}

	}


	private void animByColDame(){
		animationColTime += Gdx.graphics.getDeltaTime();
		camera.update();
		batch.setProjectionMatrix(camera.combined);
		batch.begin();
		TextureRegion techmanFrame = (TextureRegion) animationCol.getKeyFrame(animationColTime);
		int width = techmanFrame.getRegionWidth();
		int height = techmanFrame.getRegionWidth();
		float originX = width * 0.5f;
		float originY = height * 0.5f;

		//batch.draw(techmanFrame,1.0f - originX, 3.70f - originY,originX, originY,width, height,WORLD_TO_SCREEN, WORLD_TO_SCREEN,0.0f);
		batch.draw((TextureRegion) animationCol.getKeyFrame(animationColTime), 0.0f-width/2, 0.0f-height/2);
		batch.end();
		if (animationCol.isAnimationFinished(animationColTime)) {
			Gdx.app.log("clgtGDX", "Dame  Col "+dameByCol);
			dameByCol = 0;
			animationColTime = 0;
		}


	}

	private void animByFieldDame(){
		animationFieldTime += Gdx.graphics.getDeltaTime();
		camera.update();
		batch.setProjectionMatrix(camera.combined);
		batch.begin();
		TextureRegion techmanFrame = (TextureRegion) animationField.getKeyFrame(animationFieldTime);
		int width = techmanFrame.getRegionWidth();
		int height = techmanFrame.getRegionWidth();
		float originX = width * 0.5f;
		float originY = height * 0.5f;

		//batch.draw(techmanFrame,1.0f - originX, 3.70f - originY,originX, originY,width, height,WORLD_TO_SCREEN, WORLD_TO_SCREEN,0.0f);
		batch.draw((TextureRegion) animationField.getKeyFrame(animationFieldTime), 0.0f-width/2, 0.0f-height/2);
		batch.end();
		if (animationField.isAnimationFinished(animationFieldTime)) {
			Gdx.app.log("clgtGDX", "Dame  Field "+dameByField);
			dameByField = 0;
			animationFieldTime = 0;
		}
	}




	@Override
	public void create(){
		SCENE_WIDTH = Gdx.app.getGraphics().getWidth();
		SCENE_HEIGHT = Gdx.app.getGraphics().getHeight();

		camera = new OrthographicCamera();
		viewport = new FitViewport(Gdx.graphics.getWidth(),        Gdx.graphics.getHeight(), camera);
		batch = new SpriteBatch();
		camera.position.set(0.0f, 0.0f, 0.0f);
		animByRowInit();
		animByColInit();
		animByFieldInit();


	}

	@Override
	public void dispose(){
		batch.dispose();
		textureAtlasRow.dispose();
	}

	@Override
	public void render(){


		Gdx.gl.glClearColor(0, 0, 0, 1);
		Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT);
		if (dameByRow>0){
			animByRowDame();

		}
		if (dameByCol>0){
			animByColDame();

		}
		if (dameByField>0){
			animByFieldDame();

		}


	}
	@Override
	public void resize(int width, int height){
		viewport.update(width, height, false);
	}

	private static class RegionComparator implements Comparator<AtlasRegion>     {
		@Override
		public int compare(AtlasRegion region1, AtlasRegion region2){
			return region1.name.compareTo(region2.name);
		}
	}

}




//old

/*

public class MyGdxGame extends ApplicationAdapter {
	SpriteBatch batch;
	Texture img;
	private BitmapFont font;

	int width;
	int height;

	@Override
	public void create () {
		width = Gdx.app.getGraphics().getWidth();
		height = Gdx.app.getGraphics().getHeight();
		batch = new SpriteBatch();
		img = new Texture("badlogic.jpg");
		font = new BitmapFont();
		font.setColor(Color.BLUE);

		Gdx.app.log("MyTag1", "width"+width);
		Gdx.app.log("MyTag2", "height"+height);
	}

	@Override
	public void render () {
		Gdx.gl.glClearColor(0, 0, 0, 0);
		Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT);

		batch.begin();

		//batch.draw(img, 0, 0);
		font.getData().setScale(6.0f);
		font.draw(batch, "Hello World from libgdx running in a fragment! :)", 10, height/2);

		batch.end();
	}

	@Override
	public void dispose () {
		batch.dispose();
		img.dispose();
	}
}
*/
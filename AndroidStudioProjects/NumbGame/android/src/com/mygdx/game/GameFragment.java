package com.mygdx.game;

/**
 * Created by phungnam on 2017/01/30.
 */
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.badlogic.gdx.backends.android.AndroidFragmentApplication;

public class GameFragment extends AndroidFragmentApplication{
    MyGdxGame mygdxGame;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState)
    {
        this.mygdxGame = new MyGdxGame();
        // return the GLSurfaceView on which libgdx is drawing game stuff
        return initializeForView(mygdxGame);
    }
}
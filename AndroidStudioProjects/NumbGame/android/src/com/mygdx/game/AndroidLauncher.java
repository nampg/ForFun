package com.mygdx.game;

import android.graphics.Color;
import android.os.Bundle;
import android.support.v4.app.FragmentActivity;
import android.util.Log;
import android.view.View;
import android.widget.TextView;

import com.badlogic.gdx.backends.android.AndroidFragmentApplication;

import java.util.ArrayList;

public class AndroidLauncher extends FragmentActivity implements  AndroidFragmentApplication.Callbacks {
	public static boolean isDame = false;
	public GameFragment libgdxFragment;

	public TextView currentTextView;

	public int[][] dataNum = new int[][]{
			{8,5,3,4,2,1,9,7,6},
			{2,1,7,8,9,6,4,5,3},
			{6,4,9,7,3,5,1,8,2},
			{3,8,2,6,4,9,7,1,5},
			{4,6,5,1,7,8,3,2,9},
			{9,7,1,3,5,2,6,4,8},
			{1,9,6,5,8,4,2,3,7},
			{7,2,8,9,1,3,5,6,4},
			{5,3,4,2,6,7,8,9,1}
	};


	public int[][] dataVisible = new int[][]{
			{0,1,1,1,1,1,0,1,1},
			{1,0,0,1,1,1,1,1,1},
			{1,1,1,1,1,1,1,1,1},
			{1,1,1,1,0,1,1,1,1},
			{1,1,1,1,1,1,1,0,1},
			{1,1,1,1,1,0,1,1,1},
			{1,1,1,1,1,1,1,1,1},
			{1,1,1,1,1,1,1,1,1},
			{1,1,1,1,1,1,1,1,1}

	};

	public int[][] currentDataNum = new int[][]{
			{0,5,3,4,2,1,9,7,6},
			{2,0,0,8,9,6,4,5,3},
			{6,4,9,7,3,5,1,8,2},
			{3,8,2,6,4,9,7,1,5},
			{4,6,5,1,7,8,3,2,9},
			{9,7,1,3,5,2,6,4,8},
			{1,9,6,5,8,4,2,3,7},
			{7,2,8,9,1,3,5,6,4},
			{5,3,4,2,6,7,8,9,1}
	};

	public int[][] dataField = new int[][]{
			{1,1,1, 2,2,2, 3,3,3},
			{1,1,1, 2,2,2, 3,3,3},
			{1,1,1, 2,2,2, 3,3,3},

			{4,4,4, 5,5,5, 6,6,6},
			{4,4,4, 5,5,5, 6,6,6},
			{4,4,4, 5,5,5, 6,6,6},

			{7,7,7, 8,8,8, 9,9,9},
			{7,7,7, 8,8,8, 9,9,9},
			{7,7,7, 8,8,8, 9,9,9},

	};

//
//    public int[] indexArrField1 = new int[]{0,1,2, 10,11,12, 20,21,22};
//    public int[] indexArrField2 = new int[]{ 3, 4, 5, 13,14,15, 23,24,25};
//
//    public int[] indexArrField3 = new int[]{ 6, 7, 8, 16,17,18, 26,27,28};
//
//    public int[] indexArrField4 = new int[]{30,31,32, 40,41,42, 50,51,52};
//
//    public int[] indexArrField5 = new int[]{33,34,35, 43,44,45, 53,54,55};
//
//    public int[] indexArrField6 = new int[]{36,37,38,46,47,48, 56,57,58};
//
//    public int[] indexArrField7 = new int[]{60,61,62,70,71,72,80,81,82};
//
//    public int[] indexArrField8 = new int[]{63,64,65,73,74,75,83,84,85};
//
//
//    public int[] indexArrField9 = new int[]{66,67,68,76,77,78,86,87,88};

	public  int[][] indexArrField = new int[][]{
			{0,1,2, 10,11,12, 20,21,22},//Field 1
			{ 3, 4, 5, 13,14,15, 23,24,25},//Field 2
			{ 6, 7, 8, 16,17,18, 26,27,28},//Field 3
			{30,31,32, 40,41,42, 50,51,52},//Field 4
			{33,34,35, 43,44,45, 53,54,55},//Field 5
			{36,37,38,46,47,48, 56,57,58},//Field 6
			{60,61,62,70,71,72,80,81,82},//Field 7
			{63,64,65,73,74,75,83,84,85},//Field 8
			{66,67,68,76,77,78,86,87,88}//Field 9


	};






	public void initLayoutBtn(){

		for (int i = 1; i<=9; i++){
			for (int j = 1; j<=9; j++){

				int id = getResources().getIdentifier("txt"+i+j,"id",getPackageName());
				TextView tempText = (TextView)findViewById(id);

				if(dataVisible[i-1][j-1]!=0) {

					tempText.setText("" + dataNum[i - 1][j - 1]);
					tempText.setBackgroundColor(Color.parseColor("#1f000000"));

				}else{

					tempText.setBackgroundColor(Color.parseColor("#FF0099CC"));
					tempText.setText("");
				}
			}

		}
	}

	public void inputBtnPressed(View v){
		TextView inputBtn = (TextView)v;
		if (currentTextView!=null){
			currentTextView.setText(""+inputBtn.getTag());

			int tag = Integer.parseInt(""+currentTextView.getTag());
			int i = tag/10-1;
			int j = tag%10-1;
			currentDataNum[i][j] = Integer.parseInt(""+inputBtn.getTag());

			int index = Integer.parseInt(String.valueOf(currentTextView.getTag()));
			checkToAttackField(index);
			checkToAttackCol(index);
			checkToAttackRow(index);

		}

	}

	public void btnClicked(View v){


		int index = Integer.parseInt(String.valueOf(v.getTag()));
		Log.w("clgt", ""+index/10);
		if(dataVisible[index/10-1][index%10-1] != 1){
			if (currentTextView!=null){
				currentTextView.setBackgroundColor(Color.parseColor("#FF0099CC"));
			}
			currentTextView = (TextView)v;
			currentTextView.setBackgroundColor(Color.parseColor("#FFFF4081"));

		}
		//checkToAttackCol(index);




//            Log.w("clgt", String.valueOf(v.getTag()));
	}


	public int checkToAttackRow(int index){
		int dame = 0;
		int rowNum = index/10;
		boolean isCorrectRow = true;
		ArrayList<Integer> rowArrayList = new ArrayList<Integer>(9);
		for(int i = 1; i<=9;i++){
			int id = getResources().getIdentifier("txt"+rowNum+i,"id",getPackageName());
			TextView tempText = (TextView)findViewById(id);
			if (tempText.getText()!="")
				rowArrayList.add(Integer.parseInt(""+tempText.getText()));
			else
				rowArrayList.add(0);

		}
		Log.w("arrrrr------",rowArrayList.toString());

		for (int i = 1; i<=9;i++){
			if (!rowArrayList.contains(i)){
				isCorrectRow = false;
				break;
			}


		}
		if (isCorrectRow){
			libgdxFragment.mygdxGame.dameBossByRow(1000);
		}

		Log.w("isCorrectRow------",""+isCorrectRow);
		return dame;

	}


	public int checkToAttackCol(int index){
		int dame = 0;
		int colNum = index%10;
		boolean isCorrectRow = true;
		ArrayList<Integer> rowArrayList = new ArrayList<Integer>(9);
		for(int i = 1; i<=9;i++){
			int id = getResources().getIdentifier("txt"+i+colNum,"id",getPackageName());
			TextView tempText = (TextView)findViewById(id);
			if (tempText.getText()!="")
				rowArrayList.add(Integer.parseInt(""+tempText.getText()));
			else
				rowArrayList.add(0);

		}
		Log.w("arrrrr------",rowArrayList.toString());

		for (int i = 1; i<=9;i++){
			if (!rowArrayList.contains(i)){
				isCorrectRow = false;
				break;
			}


		}
		if (isCorrectRow){
			libgdxFragment.mygdxGame.MyShowLog();
		}

		Log.w("isCorrectCol------",""+isCorrectRow);

		if (isCorrectRow){
			libgdxFragment.mygdxGame.dameBossByCol(2000);
		}
		return dame;

	}


	public int checkToAttackField(int index){
		int dame = 0;
		int indexi = index/10-1;
		int indexj = index%10-1;
		int numberOfField = dataField[indexi][indexj];
		Log.w("field:", ""+numberOfField);



		boolean isCorrectRow = true;
		ArrayList<Integer> rowArrayList = new ArrayList<Integer>(9);
		for(int i = 0; i<9;i++){
			int tempIndex = indexArrField[numberOfField-1][i];
			rowArrayList.add(currentDataNum[tempIndex/10][tempIndex%10]);

		}
		Log.w("arrrrr------",rowArrayList.toString());

		for (int i = 1; i<=9;i++){
			if (!rowArrayList.contains(i)){
				isCorrectRow = false;
				break;
			}


		}
		if (isCorrectRow){
			isDame = true;
		}

		Log.w("isCorrectField------",""+isCorrectRow);
		if (isCorrectRow){
			libgdxFragment.mygdxGame.dameBossByField(3000);
		}
		return dame;
	}











	@Override
	public void onCreate (Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		setContentView(R.layout.layout);
		initLayoutBtn();

		// Create libgdx fragment
		libgdxFragment = new GameFragment();


		// Put it inside the framelayout (which is defined in the layout.xml file).
		getSupportFragmentManager().beginTransaction().
				add(R.id.content_framelayout, libgdxFragment).
				commit();
	}

	@Override
	public void exit() {

	}


}
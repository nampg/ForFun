using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;


public class CanvasScript : MonoBehaviour {


	public static bool canvasTrueSpacePressed = false;


	public static int myScore = 0;
	public Text myScoreTxt;
	public Text myHearttxt;
	public static int myHeart = 500;
	
	public Scrollbar myscrollBar;
	protected int myScrollBarDirection = 1;
	protected float myScrollBarV = 0.7f;

	public Image image1;
	public Image image2;
	public Image image3;
	public Image image4;


	public Sprite myFirstImage; //Drag your first sprite here in inspector.
	public Sprite mySecondImage;

	public int[] myargs=new int[]{0, 0, 0, 0};
	public int currentIndex = 0;

	// Use this for initialization
	void Start () {

		canvasTrueSpacePressed = false;
		myargs = new int[]{0, 0, 0, 0};

		Debug.Log (myargs.Length);

		randomToRotation ();
		myscrollBar.value = 0;
		myScrollBarDirection = 1;

		myScore = 0;
		myHearttxt.text = "Heart: " + myHeart;

		
	}
	
	// Update is called once per frame
	void Update () {
		if (myHeart <= 0) {
			Application.LoadLevel("GameOver");
		}
		myScoreTxt.text = "" + myScore;

		if (myscrollBar.value == 0) {
			myScrollBarDirection = 1;
		}else if(myscrollBar.value == 1)
			myScrollBarDirection = -1;

		myscrollBar.value += myScrollBarV * myScrollBarDirection * Time.deltaTime;



		
		if (Input.anyKey && currentIndex>=0) {
			//bool isPressedTrue = false;
			int tempArg = -1;
			if(Input.GetKeyDown(KeyCode.UpArrow) || Input.GetKeyDown(KeyCode.W)){
				tempArg = 180;
			}
			if(Input.GetKeyDown(KeyCode.RightArrow) || Input.GetKeyDown(KeyCode.D)){
				tempArg = 90;
			}

			if(Input.GetKeyDown(KeyCode.LeftArrow) || Input.GetKeyDown(KeyCode.A)){
				tempArg = 270;
			}

			if(Input.GetKeyDown(KeyCode.DownArrow) || Input.GetKeyDown(KeyCode.S)){
				tempArg = 0;
			}
			if (tempArg == myargs [currentIndex]) {
				if (currentIndex == 0)
					image1.sprite = mySecondImage;
				else if (currentIndex == 1)
					image2.sprite = mySecondImage;
				else if (currentIndex == 2)
					image3.sprite = mySecondImage;
				else if (currentIndex == 3)
					image4.sprite = mySecondImage;
				
				currentIndex += 1;
				if (currentIndex > 3)
					currentIndex = -1;
			} else if(tempArg>=0){
				

					myHeart = myHeart - 100;

			}

			//typingTxt+=(string)Input.inputString;
		}
		if(Input.GetKeyDown(KeyCode.Space)){
			
			//typingTxt = "";
			//string tempTxt = "";
			if (currentIndex == -1) {
				if (myscrollBar.value <= 0.85 && myscrollBar.value >= 0.57) {
					myScore += 100;
					canvasTrueSpacePressed = true;
				} else {
					myHeart = myHeart - 100;
				}
				randomToRotation ();



			} else {
				
				canvasTrueSpacePressed = false;

			}




		}
		myHearttxt.text = "Heart: " + myHeart;
	}


	void randomToRotation(){
		for(int j = 0; j<4; j+=1){
			myargs [j] = Random.Range (0, 4) * 90;
			//Debug.Log(j);


		}

		image1.rectTransform.rotation=Quaternion.Euler(0,0,myargs[0]);
		image2.rectTransform.rotation=Quaternion.Euler(0,0,myargs[1]);
		image3.rectTransform.rotation=Quaternion.Euler(0,0,myargs[2]);
		image4.rectTransform.rotation=Quaternion.Euler(0,0,myargs[3]);

		//image1.rectTransform.rotation = Quaternion.Euler (0, 0, Random.Range (0, 4) * 90);

		//image1 = Resources.Load<Sprite>("myarrow1");
		image1.sprite = myFirstImage;
		image2.sprite = myFirstImage;
		image3.sprite = myFirstImage;
		image4.sprite = myFirstImage;
		currentIndex = 0;

	}
}

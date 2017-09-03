using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RecommandScript : MonoBehaviour {
//	↑
//	←
//	→
//	↓
	public TextMesh recommandTxt;
	public string typingTxt;

	string[] arrows = new string[] {"↑", "←", "→", "↓"};
//	public TextMesh alphabetTextMesh;

	// Use this for initialization
	void Start () {

		recommandTxt = gameObject.GetComponent ("TextMesh")as TextMesh;
		typingTxt = "";
//		recommandTxt.text = "<color=red>↑←→↓</color>";
	}
	
	// Update is called once per frame
	void Update () {



		if (Input.anyKey) {
			
			//Debug.Log ("A key or mouse click has been detected");
			//Debug.Log((string)Input.inputString);
			typingTxt+=(string)Input.inputString;
		}
		if(Input.GetKeyDown(KeyCode.Space)){
			Debug.Log (typingTxt);
			typingTxt = "";
			string tempTxt = "";
			for(int i = 0; i<4; i++){
				tempTxt += arrows[Random.Range(0,4)];

			}
			recommandTxt.text =  tempTxt;

		}
	}



}

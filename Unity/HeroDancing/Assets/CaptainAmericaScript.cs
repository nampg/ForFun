using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CaptainAmericaScript : MonoBehaviour {
	Animator anim;
	// Use this for initialization
	void Start () {
		anim = GetComponent<Animator> ();
	}
	
	// Update is called once per frame
	void Update () {
		//if(Input.GetKeyDown(KeyCode.Space))
			anim.SetBool ("isTrueSpacePressed", CanvasScript.canvasTrueSpacePressed);

		if (anim.GetCurrentAnimatorStateInfo (0).IsName ("cheering") && anim.GetCurrentAnimatorStateInfo (0).normalizedTime>1 ) {

			anim.SetBool ("isTrueSpacePressed", false);
			CanvasScript.canvasTrueSpacePressed = false;
			//Debug.Log ("clgtclgt   "+anim.GetCurrentAnimatorStateInfo (0).normalizedTime);
			Debug.Log(CanvasScript.canvasTrueSpacePressed);
		}
	}
}

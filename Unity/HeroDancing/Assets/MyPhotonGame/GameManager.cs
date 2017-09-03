using UnityEngine;
using System.Collections;

namespace PUNTutorial
{
	public class GameManager : Photon.PunBehaviour {
		public static GameManager instance;

		void Awake()
		{
			if(instance != null)
			{
				DestroyImmediate(gameObject);
				return;
			}
			DontDestroyOnLoad(gameObject);
			instance = this;
		}

		void Start()
		{
			PhotonNetwork.ConnectUsingSettings("PUNTutorial_Pt1");
		}

		public void JoinGame()
		{
			RoomOptions ro = new RoomOptions();
			ro.maxPlayers = 6;
			PhotonNetwork.JoinOrCreateRoom("Default Room",  ro, null);
		}

		public override void OnJoinedRoom ()
		{
			Debug.Log("Joined Room bbbbbbbbbb");
		}
	}
}
// Starting framework written by Ero#1111

state("HaveANiceDeath") {}

startup
{
	vars.Log = (Action<object>)(output => print("[HaND Splitter] " + output));
	vars.Unity = Assembly.Load(File.ReadAllBytes(@"Components\UnityASL.bin")).CreateInstance("UnityASL.Unity");
}

init
{
	vars.Unity.TryOnLoad = (Func<dynamic, bool>)(helper =>
	{
		vars.Log("Loading autosplitter...");
		// Singletons
		var _singletonNoEdits = helper.GetClass("MagicLib", "SingletonNoEdit`1");
		var _singletonMagic = helper.GetClass("MagicLib", "SingletonMagic`1");

		#region Loading
		var _loadingScreen = helper.GetClass("MagicUI", "LoadingScreen", 1);
		vars.Unity.Make<bool>(_loadingScreen.Static, _singletonNoEdits["_instance"], _loadingScreen["isHiden"]).Name = "loadingScreenHidden";
		#endregion

		#region NewRun
		var _levelManager = helper.GetClass("MDS.MagicRoomEditor", "LevelManager", 1);
		vars.Unity.Make<bool>(_levelManager.Static, _singletonMagic["_instance"], _levelManager["isNewRun"]).Name = "isNewRun";
		#endregion

		#region Restart
		var _list = helper.GetClass("mscorlib", "List`1");

		var _playerData = helper.GetClass("MagicGameplay", "PlayerData");
		var _playerData_Data = helper.GetClass("MagicGameplay", "Data");

		vars.Unity.MakeString(_playerData.Static, _playerData["instance"], _playerData["allPlayersData"], _list["_items"], 0x10, _playerData_Data["currentLevel"]).Name = "currentLevel";
		#endregion

		return true;
	});

	vars.Unity.Load(game);
}

update
{
	if (!vars.Unity.Loaded) return false;
	vars.Unity.Update();

	current.IsNewRun = vars.Unity["isNewRun"].Current;
	current.Loading = !(vars.Unity["loadingScreenHidden"].Current);
	current.InLobby = vars.Unity["currentLevel"].Current == "Lobby";
}

isLoading
{
	return current.Loading;
}

start
{
	return current.IsNewRun;
}

reset
{
	return current.InLobby;
}

exit
{
	vars.Unity.Reset();
}

shutdown
{
	vars.Unity.Reset();
}
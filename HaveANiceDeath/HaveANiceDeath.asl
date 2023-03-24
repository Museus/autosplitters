// Starting framework written by Ero#1111

state("HaveaNiceDeath") {}

startup
{
	vars.Log = (Action<object>)(output => print("[HaND Splitter] " + output));
	Assembly.Load(File.ReadAllBytes(@"Components/asl-help")).CreateInstance("Unity");
}

init
{
	vars.Helper.TryLoad = (Func<dynamic, bool>)(mono =>
	{
		vars.Log("Loading autosplitter...");

		#region Loading
		var _loadingScreen = mono["MagicUI", "LoadingScreen", 1];
		vars.Helper["NotLoading"] = mono.Make<bool>(_loadingScreen, "_instance", "isHiden");
		#endregion

		#region NewRun
		var _levelManager = mono["MDS.MagicRoomEditor", "LevelManager", 1];
		vars.Helper["IsNewRun"] = mono.Make<bool>(_levelManager, "_instance", "isNewRun");
		#endregion

		return true;
	});
}

isLoading
{
	return !current.NotLoading;
}

start
{
	return current.IsNewRun;
}

exit
{
	vars.Unity.Reset();
}

shutdown
{
	vars.Unity.Reset();
}
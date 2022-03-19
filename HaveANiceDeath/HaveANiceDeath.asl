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

		#region Loading
		var _loadingScreen = helper.GetClass("MagicUI", "LoadingScreen", 1);
		vars.Unity.Make<bool>(_loadingScreen.Static, _singletonNoEdits["_instance"], _loadingScreen["isHiden"]).Name = "loadingScreenHidden";
		#endregion

		return true;
	});

	vars.Unity.Load(game);
}

update
{
	if (!vars.Unity.Loaded) return false;
	vars.Unity.Update();

	current.Loading = !(vars.Unity["loadingScreenHidden"].Current);
}

isLoading
{
	return current.Loading;
}

exit
{
	vars.Unity.Reset();
}

shutdown
{
	vars.Unity.Reset();
}
// ANGER FOOT Load Remover and Auto Splitter written by Ero, Micrologist, Meta, & Marczeslaw
// Thanks to Tedder and 2838 for helping out in the Tool Development Discord.

state("Anger Foot")
{
   // int loading : "UnityPlayer.dll", 0x17C7BA0;
    float IGT : "UnityPlayer.dll", 0x17A23B8, 0xD0, 0x8, 0xD60, 0x50, 0x20, 0x18;
    string150 levelName : "UnityPlayer.dll", 0x0180E7F8, 0x48, 0x10, 0x0;
    byte levelEndScreen : "UnityPlayer.dll", 0x017A7B20, 0xCC0, 0x0, 0x30, 0x40, 0x28;
}

startup
{
    if (timer.CurrentTimingMethod == TimingMethod.RealTime)
	{        
		var timingMessage = MessageBox.Show (
			"This game uses Time without Loads (Game Time) as the main timing method.\n"+
			"LiveSplit is currently set to show Real Time (RTA).\n"+
			"Would you like to set the timing method to Game Time?",
			"LiveSplit | Anger Foot",
			MessageBoxButtons.YesNo,MessageBoxIcon.Question
		);
		
		if (timingMessage == DialogResult.Yes)
		{
			timer.CurrentTimingMethod = TimingMethod.GameTime;
		}
	}
}

init 
{
    vars.totalGameTime = 0;
}

gameTime 
{
    if (old.IGT > current.IGT) vars.totalGameTime += old.IGT;

    return TimeSpan.FromSeconds(vars.totalGameTime + current.IGT);
}

isLoading
{
    return true;
}

start
{
    if (old.levelName != current.levelName && String.IsNullOrEmpty(old.levelName))
    {
        vars.totalGameTime = 0;
        return true;
    }
}

update 
{
    if (old.levelName != current.levelName)
        print(current.levelName);
}

split { return current.levelName != old.levelName && current.levelName.Contains("End"); }

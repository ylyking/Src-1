class GD2PlayerController extends UTPlayerController;
var SoundCue attackh;
var SoundCue attackm;
var SoundCue heartb;
var SoundCue heartf;
var SoundCue level;
//Function to output debug messages
simulated private function DebugPrint(string sMessage)
{
	GetALocalPlayerController().ClientMessage(sMessage);
}
event Possess(Pawn inPawn, bool bVehicleTransition)
{
    super.Possess(inPawn, bVehicleTransition);
    SetTimer(5.51,true,'play');
    SetTimer(2.48,true,'playf');
    PlaySound(level);
    SetTimer(43,true,'levelp');
}
function levelp()
{
PlaySound(level);
}
function play()
{
if(GD2PlayerPawn(Pawn).Health > 300)
PlaySound(heartb);
}
function playf()
{
if(GD2PlayerPawn(Pawn).Health <= 300&& GD2PlayerPawn(Pawn).Health > 0)
PlaySound(heartf);
}
//combat function that exectues when z is pressed
exec function attackb()
{
local monster ai;
local actor Player_location_actor;
local int Distance;
Player_location_actor = GetALocalPlayerController().Pawn;
GD2PlayerPawn(Pawn).blockbb = false;
ForEach AllActors(class'monster',ai)
{
Distance = VSize(Player_location_actor.Location - ai.Location);
if(Distance<0)
    Distance*=-1;
if(Distance>300&&Distance<700)
{
PlaySound(attackh);
ai.monster_health-=10;
ai.dead();
}
}
PlaySound(attackm);
}
//block function that executes when c is pressed
exec function blockb()
{
local monster ai;
local actor Player_location_actor;
local int Distance;
Player_location_actor = GetALocalPlayerController().Pawn;
ForEach AllActors(class'monster',ai)
{
Distance = VSize(Player_location_actor.Location - ai.Location);
if(Distance<0)
    Distance*=-1;
if(Distance<700 && Distance<300)
{
GD2PlayerPawn(Pawn).blockbb = true;
}
else
GD2PlayerPawn(Pawn).blockbb = false;
}
}

defaultproperties
{

   CameraClass=class'GameDev2.GD2PlayerCamera'
   bCollideActors=true
   attackh =  SoundCue'Sounds.attack_hit_cue'
   attackm =  SoundCue'Sounds.attack_miss_cue'
   heartb =  SoundCue'Sounds.heart_beatc'
   heartf =  SoundCue'Sounds.heart_beat_fastc'
   level = SoundCue'Sounds.windc'
   // bBehindView=false
   // bForceBehindView=false
}
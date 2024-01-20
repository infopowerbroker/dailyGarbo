#DailyGarbo.ash
#dependent on the following scripts:
###tp-zap.ash //needs refactoring and publishing
####autobastille.ash //needs to be posted with credit
####set gingerCCS (or package CCS like in Autoscend)
###gingerbread city.ash - need to invoke arguments?
###garbo.js
###consults.ash //add check for access
###diet_elevensies
###prankfirst
###crimbo-train-exit

void main(){
notify infopowerbroker;
import <Fax2dotZero.ash>

//checking to see if someone else already farmed with this character today. 
if((get_property("_dailyGarboStage").to_int()!=1) && (get_property("_dailyGarboStage").to_int()<2) && (my_inebriety().to_int()>inebriety_limit().to_int())){
	chat_notify( "Someone else already ran adventures today", "red" );
	chat_notify( "Try again after rollover", "red" );
	set_property("_dailyGarboStage", 10);
}
//Breakfast and start of day activities
if((get_property("_dailyGarboStage").to_int()!=1) && (get_property("_dailyGarboStage").to_int()<2)){
	cli_execute("try; breakfast");
	adv1($location[An Overgrown Shrine (Southwest)], -1, ""); // Deal with pending timepranks
	if(get_property("_zapCount").to_int() == 0){
	cli_execute("try; tp-zap.ash");
	}
	set_property("_dailyGarboStage", 1);//breakfast done
}
//time to get the fax
if(get_property("_dailyGarboStage").to_int()==1){
	//check to see if we have a photocopied monster
	if (item_amount( $item[photocopied monster] ).to_int() <1){

	//parse the clan log to see what the last fax was
	string logs = visit_url("clan_log.php");
	matcher last_fax = "(\\d{2}\/\\d{2}\/\\d{2}, \\d{2}:\\d{2}(?:AM|PM): )<a [^>]+>([^<]+)<\/a>( faxed in a (.*?))<br>".create_matcher(logs);
	boolean found = last_fax.find();
	string text = last_fax.group(1) + last_fax.group(2) + last_fax.group(3);
	monster m = last_fax.group(4).to_monster();
	print("the photocopy is a " + m);
	
	//This is the monster you want to check if it's there, go ahead and grab it
	string desiredMonster = "knob goblin embezzler";
	
	if(m == to_monster(desiredMonster)){
		//This is our monster, grab the fax
		print("Grabbing the monster");
		visit_url("clan_viplounge.php?preaction=receivefax&whichfloor=2");
	}
	else{
		//ask CWBot about the fax, to bring in a new one
		//Clan Norms are that we should ask in chat
		GetClanFax(desiredMonster);
		exit;
		}
	}
	else{
	print("We've got a fax, moving on");
	}
		set_property("_dailyGarboStage", 2);
}//photocopied monster obtained

//bastille
if(get_property("_dailyGarboStage").to_int()==2){
//TODO Add check for if we have bastille*********************************************************
	if(item_amount( $item[Bastille Battalion control rig] ).to_boolean()){
		cli_execute("try; call 5x autobastille.ash");
	}
	else if(item_amount( $item[Bastille Battalion control rig loaner voucher] ).to_int() > 0){
		if(user_confirm("Use a Bastille Guest Pass today?")){
			cli_execute("use  Bastille Battalion control rig loaner voucher; call  autobastille.ash");
			}
	}
set_property("_dailyGarboStage", 3);
}//bastille cheese acquired!

//Get GingerCandy
if(get_property("_dailyGarboStage").to_int()==3){
 	if(get_property("gingerbreadCityAvailable").to_boolean()){
		//will try to change familiar to chocloate lab (if you have one)
		cli_execute("try; familiar chocolate lab");
		cli_execute("maximize sprinkle drop");
		cli_execute("outfit save Gingerbread-City");
		cli_execute("call SetGingerCCS.ash");
		cli_execute("call gingerbread city.ash");
		cli_execute("try; familiar Jill-of-All-Trades");
		//How can I use the same CCS reset script?******************************
		set_ccs("Mortar_Extract");
	}
	set_property("_dailyGarboStage", 4);
}//Gingerbread City Looted
//Visit the Spacegate
if(get_property("_dailyGarboStage").to_int()==4){
	
	if(get_property("spacegateAlways").to_boolean()){
		cli_execute("call SpaceGateWrapper.ash");
	}
set_property("_dailyGarboStage", 5);
}//end spacegate
//starting garbo
if(get_property("_dailyGarboStage").to_int()==5){
	if(my_meat().to_int() <3000000)
	{
		//add check for what happens if we don't have 3mil in the closet
		take_closet(3000000);
	}
	cli_execute("garbo.js");
	set_property("_dailyGarboStage", 6);
}//end garbo
//visiting zatara
if(get_property("_dailyGarboStage").to_int()==6){
	cli_execute("consults.ash");
	set_property("_dailyGarboStage", 7);
}//zatara
//Beginning end of day routine
if(get_property("_dailyGarboStage").to_int()==7){
	cli_execute("try; familiar stooper");
	cli_execute("try; cast ode");
	cli_execute("try; drink sac wine");
	cli_execute("try; overdrink fog murder");
	cli_execute("try; familiar tot");
	set_property("_dailyGarboStage", 8);
}//overdrunk
//endOfDayRoutine
if(get_property("_dailyGarboStage").to_int()==8){

	cli_execute("call diet_elevensies.ash");
	cli_execute("try; prankfirst.ash");
	set_property("_dailyGarboStage", 9);
}
//pajamaTime
if(get_property("_dailyGarboStage").to_int()==9){
	cli_execute("try; maximize adv");
	cli_execute("call crimbo-train-exit.ash");
	set_property("_dailyGarboStage", 10);
	exit;
}

}// void main()

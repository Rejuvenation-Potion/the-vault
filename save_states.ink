
/*
THE VAULT Save States
Author: Lochlan Belford
Date Started: 7/12/2022
Date Finished: 
Description: 
- Collection of save states used for testing
- Each save state sets the trust level, health status, availability status, and present status of each party member to particular values
- Each save state is given a unique ID
- Entering a state is controlled by a single function "EnterSaveState(stateID)" which switches on the ID integer to enter the correct state
*/


=== function EnterSaveState(stateID, debug)
{stateID:
    -0: 
        ~State0()
    -101:
        ~State101()
    -111:
        ~State111()
    -121:
        ~State121()
    -131:
        ~State131()
    -201:
        ~State201()
    -202:
        ~State202()
    -203:
        ~State203()
    - else:
        ~State0()
}

{
    - debug:
    [DEBUG:
        ~PrintStatus(rangerState)
        ~PrintStatus(rogueState)
        ~PrintStatus(clericState)
        ~PrintStatus(scholarState)
    DEBUG END]
}


/*
State0()
The default state for the start of the game.
Everyone's trust is at STARTING_TRUST constant
Everyone is healthy, present, and available
*/
=== function State0()
//Ranger
~ rangerState = (Ranger, healthy, present, available)
~ SetTrust(rangerTrust, STARTING_TRUST)
//Rogue
~ rogueState = (Rogue, healthy, present, available)
~ SetTrust(rogueTrust, STARTING_TRUST)
//Cleric
~ clericState = (Cleric, healthy, present, available)
~ SetTrust(clericTrust, STARTING_TRUST)
//Scholar
~ scholarState = (Scholar, healthy, present, available)
~ SetTrust(scholarTrust, STARTING_TRUST)



/*
State101()
"Ideal"
Possible State for beginning of Act 1
Scholar trust up 
No Injuries
*/
=== function State101()
//Ranger
~ rangerState = (Ranger, healthy, present, available)
~ SetTrust(rangerTrust, STARTING_TRUST)
//Rogue
~ rogueState = (Rogue, healthy, present, available)
~ SetTrust(rogueTrust, STARTING_TRUST)
//Cleric
~ clericState = (Cleric, healthy, present, available)
~ SetTrust(clericTrust, STARTING_TRUST)
//Scholar
~ scholarState = (Scholar, healthy, present, available)
~ SetTrust(scholarTrust, 7)

//prologue events
~ prologueEvents += trustedScholar
~ prologueEvents += trapDisarmed
~ prologueEvents += creaturesScared


/*
State111()
"Default"
Possible State for beginning of Act 1
Scholar not trusted
Cleric Disarmed (trust up 1)
*/
=== function State111()
//Ranger
~ rangerState = (Ranger, healthy, present, available)
~ SetTrust(rangerTrust, STARTING_TRUST)
//Rogue
~ rogueState = (Rogue, healthy, present, available)
~ SetTrust(rogueTrust, STARTING_TRUST)
//Cleric
~ clericState = (Cleric, healthy, present, available)
~ SetTrust(clericTrust, 6)
//Scholar
~ scholarState = (Scholar, healthy, present, available)
~ SetTrust(scholarTrust, 3)

//prologue events
~ prologueEvents += trapDisarmed
~ prologueEvents += creaturesArrived




/*
State121()
Possible State for beginning of Act 1
"Bad"
Scholar trust down 
Rogue trust down
Ranger Injured (trust - 1)
*/
=== function State121()
//Ranger
~ rangerState = (Ranger, injured, present, available)
~ SetTrust(rangerTrust, 4)
//Rogue
~ rogueState = (Rogue, healthy, present, available)
~ SetTrust(rogueTrust, 3)
//Cleric
~ clericState = (Cleric, healthy, present, available)
~ SetTrust(clericTrust, 5)
//Scholar
~ scholarState = (Scholar, healthy, present, available)
~ SetTrust(scholarTrust, 3)

//prologue events
~ prologueEvents += trapDisarmed
~ prologueEvents += creaturesArrived
~ prologueEvents += creaturesKilled

/*
State131()
Possible State for beginning of Act 1
"Worst"
Scholar trust down 
Rogue trust down
Ranger Injured (trust - 1)
Cleric Injured (trust - 1)
*/
=== function State131()
//Ranger
~ rangerState = (Ranger, injured, present, available)
~ SetTrust(rangerTrust, 4)
//Rogue
~ rogueState = (Rogue, healthy, present, available)
~ SetTrust(rogueTrust, 5)
//Cleric
~ clericState = (Cleric, injured, present, available)
~ SetTrust(clericTrust, 4)
//Scholar
~ scholarState = (Scholar, healthy, present, available)
~ SetTrust(scholarTrust, 3)

//prologue events
~ prologueEvents += creaturesArrived
~ prologueEvents += creaturesKilled
~ prologueEvents += fireSet


/*
State201() "Default"
Possible State for beginning of Act 2
Scholar Injured
Scholar at 5 trust and Humbled
Rogue at 4 Trust
Cleric at 7 trust
Ranger at 5 trust
Just found out about brothers
Just discovered ranger's past
Player has been sympathetic toward Cleric
*/
=== function State201()
//Ranger
~ rangerState = (Ranger, healthy, present, available)
~ SetTrust(rangerTrust, 5)
//Rogue
~ rogueState = (Rogue, healthy, present, available)
~ SetTrust(rogueTrust, 4)
//Cleric
~ clericState = (Cleric, healthy, present, available)
~ SetTrust(clericTrust, 7)
//Scholar
~ scholarState = (Scholar, injured, present, available)
~ SetTrust(scholarTrust, 5)

//Knowledge Chains and Variables
~ SetStateTo(scholarEndings, humbled)
~ Reach(brothersKnowledge.KNOW_ARE_BROTHERS)
~ Reach(rangerGriefStages.CLOSED_OFF)
~ playerSympatheticToCleric = true

/*
State202() "Ideal"
Possible State for beginning of Act 2
Everyone Healthy
Scholar at 10 trust and HUMBLED
Rogue at 6 Trust
Cleric at 8 trust
Ranger at 7 trust
Know about brothers' conflict
Ranger already opening up
Player has been sympathetic toward Cleric
*/
=== function State202()
//Ranger
~ rangerState = (Ranger, healthy, present, available)
~ SetTrust(rangerTrust, 7)
//Rogue
~ rogueState = (Rogue, healthy, present, available)
~ SetTrust(rogueTrust, 6)
//Cleric
~ clericState = (Cleric, healthy, present, available)
~ SetTrust(clericTrust, 8)
//Scholar
~ scholarState = (Scholar, healthy, present, available)
~ SetTrust(scholarTrust, 10)

//Knowledge Chains and Variables
~ SetStateTo(scholarEndings, humbled)
~ Reach(brothersKnowledge.KNOW_ABOUT_CONFLICT)
~ Reach(rangerGriefStages.OPENING_UP)
~ playerSympatheticToCleric = true


/*
State202() "Bad"
Possible State for beginning of Act 2
Scholar and Rogue Injured
Scholar at 0 trust and PROUD
Rogue at 2 Trust
Cleric at 3 trust
Ranger at 4 trust
Just found out about brothers
Just discovered ranger's past
Player has been harsh toward Cleric
*/
=== function State203()
//Ranger
~ rangerState = (Ranger, healthy, present, available)
~ SetTrust(rangerTrust, 4)
//Rogue
~ rogueState = (Rogue, injured, present, available)
~ SetTrust(rogueTrust, 2)
//Cleric
~ clericState = (Cleric, healthy, present, available)
~ SetTrust(clericTrust, 3)
//Scholar
~ scholarState = (Scholar, injured, present, available)
~ SetTrust(scholarTrust, 0)

//Knowledge Chains and Variables
~ SetStateTo(scholarEndings, proud)
~ Reach(brothersKnowledge.KNOW_ARE_BROTHERS)
~ Reach(rangerGriefStages.CLOSED_OFF)
~ playerSympatheticToCleric = false








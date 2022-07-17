
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


=== function EnterSaveState(stateID)
{stateID:
    0: 
        ~State0()
    - else:
        ~State0()
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

//DEBUG
~PrintStatus(rangerState)
~PrintStatus(rogueState)
~PrintStatus(clericState)
~PrintStatus(scholarState)


/*
State101()
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

//DEBUG
~PrintStatus(rangerState)
~PrintStatus(rogueState)
~PrintStatus(clericState)
~PrintStatus(scholarState)

/*
State111()
Possible State for beginning of Act 1
Scholar trust down 
Cleric Injured
*/
=== function State111()
//Ranger
~ rangerState = (Ranger, healthy, present, available)
~ SetTrust(rangerTrust, STARTING_TRUST)
//Rogue
~ rogueState = (Rogue, healthy, present, available)
~ SetTrust(rogueTrust, STARTING_TRUST)
//Cleric
~ clericState = (Cleric, injured, present, available)
~ SetTrust(clericTrust, STARTING_TRUST)
//Scholar
~ scholarState = (Scholar, healthy, present, available)
~ SetTrust(scholarTrust,3)

//DEBUG
~PrintStatus(rangerState)
~PrintStatus(rogueState)
~PrintStatus(clericState)
~PrintStatus(scholarState)


/*
State103()
Possible State for beginning of Act 1
Scholar trust down 
Rogue Injured
*/
=== function State103()
//Ranger
~ rangerState = (Ranger, healthy, present, available)
~ SetTrust(rangerTrust, STARTING_TRUST)
//Rogue
~ rogueState = (Rogue, injured, present, available)
~ SetTrust(rogueTrust, STARTING_TRUST)
//Cleric
~ clericState = (Cleric, healthy, present, available)
~ SetTrust(clericTrust, STARTING_TRUST)
//Scholar
~ scholarState = (Scholar, healthy, present, available)
~ SetTrust(scholarTrust,3)

//DEBUG
~PrintStatus(rangerState)
~PrintStatus(rogueState)
~PrintStatus(clericState)
~PrintStatus(scholarState)






/*
THE VAULT Function Library
Author: Lochlan Belford
Date Started: 7/1/2022
Last Updated: 7/18/2022
Description: 
- Main function library for the narrative mechanics, including:
-- Trust System
-- Health System
-- Availability System
- Also includes test scene to test all functions
*/

/*
NOTE ON CASES USAGE:
CapitalCamelCase = functions
lowerCamelCase = variables, paramerters, & lists
ALL_CAPS = constants
lower_snake_case = knots & stitches
*/

/*
->test_scene
*/

/// GLOBALS, CONSTANTS, FLAGS, and STATES
//TRUST SYSTEM
CONST MIN_TRUST = 0
CONST MAX_TRUST = 10
CONST STARTING_TRUST = 5
LIST  TRUST_THRESHOLDS = LOW = 0, MED = 4, HIGH = 7
VAR rangerTrust = 8
VAR rogueTrust = STARTING_TRUST
VAR clericTrust = STARTING_TRUST
VAR scholarTrust = 3

//AVAILABILITY SYSTEM
LIST healthStates = healthy, injured, unconscious, dead
LIST busyStates = available, busy
LIST presentStates = present, missing
LIST companionNames = Ranger, Rogue, Cleric, Scholar
VAR rangerState = (Ranger, healthy, available, present)
VAR rogueState = (Rogue, injured, busy, present)
VAR clericState = (Cleric, unconscious, available, present)
VAR scholarState = (Scholar, dead, available, missing)




///FUNCTIONS
//Ink Flow Control
/*
CameFrom(->x)
returns true if x was the knot/stitch IMMEDIATELY PRIOR to
the current one. Allows reaction to what player "just saw"
*/
=== function CameFrom(->x)
    ~ return TURNS_SINCE(x) == 0
//KNOWLEDGE CHAINS
VAR AllTrueStates = ()
/*
Reach(statesToSet)
Function from Ink Guide
Reaches a state in a knowledge chain, including all the states before it.
Returns true if this is the FIRST time this state is reached (i.e. the player is learning new information)
*/
=== function Reach(statesToSet)
~temp x = Pop(statesToSet)
{
    - not x:
        ~ return false
    - not Reached(x):
        ~ temp chain = LIST_ALL(x)
        ~ temp statesGained = LIST_RANGE(chain, LIST_MIN(chain), x)
        ~ AllTrueStates += statesGained
        ~ Reach(statesToSet)
        ~ return true
        
    - else:
        ~ return false || Reach(statesToSet)
}
/*
Reached(x)
Checks if a particular state has been reached in a knowledge chain
*/
=== function Reached(x)
~return AllTrueStates ? x

/*
Between(x, y)
Checks if the player is between two given states in a knowledge chain
*/
=== function Between(x, y)
~ return AllTrueStates? x && not (AllTrueStates ^ y)

/*
Pop(ref list)
Helper function for Reach function, from ink guide
*/
=== function Pop(ref list)
   ~ temp x = LIST_MIN(list) 
   ~ list -= x 
   ~ return x

//TRUST SYSTEM
/*
AlterTrust(CompanionName, delta)
- Takes in a companion name (from the list) and an amount to change trust by
- Changes trust value using private function _alterTrust
- Prints a message like "The Scholar disapproves slightly" based on value
- (positive = "approves", negative = "disapproves")
- (1 = "slightly", 3+ = "greatly")
*/
=== function AlterTrust(CompanionName, delta)
//Begin approval message
[<>
//Convert CompanionName to companionID
~temp companionID = LIST_VALUE(CompanionName)
//switch on CompanionName, print name
{companionID:
    -LIST_VALUE(Ranger):
        ~_alterTrust(rangerTrust, delta)
        The Ranger <>
    -LIST_VALUE(Rogue):
        ~_alterTrust(rogueTrust, delta)
        The Rogue <>
    -LIST_VALUE(Cleric):
        ~_alterTrust(clericTrust, delta)
        The Cleric <>
    -LIST_VALUE(Scholar):
        ~_alterTrust(scholarTrust, delta)
        The Scholar <>
    -else:
        BUG: Changing trust of unknown companion!]
        ~return
}
//Complete message based on delta value
{
    - delta <= -3: greatly disapproves.]
    - delta <= -2: disapproves.]
    - delta <= -1: disapproves slightly.]
    - delta >= 3: greatly approves!]
    - delta >= 2: approves.]
    - delta >= 1: approves slightly.]
}

/*
_alterTrust(ref trustLevel, delta)
- takes in a reference to once of the "trust level" global variables
- adds the provided delta value to the trust level
- checks if level has gone outside defined CONST max and mins for trust
- if it has, enforces bounds
*/
=== function _alterTrust(ref trustLevel, delta)

//Change trust level
~ trustLevel += delta
//Bounds checking
{ 
    - trustLevel < MIN_TRUST:
        ~ trustLevel = MIN_TRUST
    - trustLevel > MAX_TRUST:
        ~trustLevel = MAX_TRUST
}
/*
SetTrust(ref trustLevel, level)
- Sets trust for a particular character to given number (bound between 0-10)
- This should mostly/only be used for save states
*/
=== function SetTrust(ref trustLevel, level)
~ _alterTrust(trustLevel, -1000) //Bounds checked, so sets to 0
~ _alterTrust(trustLevel, level)

/*
GetTrustThreshold(trustLevel)
Takes in one of the "trust level" global variables
and compares it to the trust threshold LIST/enum values
returns "high" "med" or "low" from that list
*/
=== function GetTrustThreshold(trustLevel)
{
    - trustLevel >= LIST_VALUE(TRUST_THRESHOLDS.HIGH):
        ~ return TRUST_THRESHOLDS.HIGH
    - trustLevel >= LIST_VALUE(TRUST_THRESHOLDS.MED):
        ~ return TRUST_THRESHOLDS.MED
    - else:
        ~ return TRUST_THRESHOLDS.LOW
}


//AVAILABILITY SYSTEM
//Setting States
/*
SetStateTo(ref stateVariable, stateToReach)
helper function from the Ink guide for altering multi-state lists
*/
=== function SetStateTo(ref stateVariable, stateToReach)
//remove all states of same type as stateToReach
~ stateVariable -= LIST_ALL(stateToReach)
//put back the state we want
~ stateVariable += stateToReach

/*
SaveCompanionState(tempState)
takes a temp variabble companionState and saves it to the appropriate global state by switching on the character name field
I THINK this function is only needed in the test environment, we'll see
*/
=== function SaveCompanionState(tempState)
{
    - tempState ? (Ranger):
        ~ rangerState = tempState
    - tempState ? (Rogue):
        ~ rogueState = tempState
    - tempState ? (Cleric):
        ~ clericState = tempState
    - tempState ? (Scholar):
        ~ scholarState = tempState
}

//Boolean Checks
/*
CanGiveJob(companionState)
Returns true if companion is available to be assigned to a job
This is only true if all the following are true:
- companion is alive and conscious (i.e. not dead, not unconsicous)
- companion is present
- companion is not busy with any other job
Returns true if all are true, false otherwise
*/
=== function CanGiveJob(companionState)
~ return IsConscious(companionState) && IsPresent(companionState) && IsAvailable(companionState)

/*
IsPresent(companionState)
returns true if companionState includes "present"
*/
=== function IsPresent(companionState)
~ return companionState ? (present)

/*
IsBusy(companionState)
returns true if companionState includes "busy"
*/
=== function IsBusy(companionState)
~ return companionState ? (busy)

/*
IsAvailable(companionState)
returns true if companionState includes "available"
*/
=== function IsAvailable(companionState)
~ return companionState ? (available)

/*
IsConscious(companionState)
returns true if companionState includes "healthy" or "injured"
*/
=== function IsConscious(companionState)
~ return companionState ? (healthy) || companionState ? (injured)

/*
IsInjured(companionState)
returns true if companionState includes "injured"
*/
=== function IsInjured(companionState)
~ return companionState ? (injured)

/*
IsDead(companionState)
returns true if companionState includes "dead"
*/
=== function IsDead(companionState)
~ return companionState ? (dead)

/*
IsHealthy(companionState)
returns true if companionState includes "healthy"
*/
=== function IsHealthy(companionState)
~ return companionState ? (healthy)


//HEALTH SYSTEM
/*
HealOneStep(companionState)
If unconscious, moves to injured
If injured, moves to healthy
no change at healthy or at dead (I'm not a miracle worker!)
*/
=== function HealOneStep(ref companionState)
{
    - companionState ? (unconscious):
        ~ SetStateTo(companionState, healthStates.injured)
    - companionState ? (injured):
        ~ SetStateTo(companionState, healthStates.healthy)
    //No healing at full health or at dead
    - else:
        ~ return
}

/*
HealOneStepAll(evenIfAbsent)
Heals all companions one step
Only heals present companions unless flag parameter set to true
*/
=== function HealOneStepAll(evenIfAbsent)
{evenIfAbsent || IsPresent(rangerState): 
    ~HealOneStep(rangerState)
}
{evenIfAbsent || IsPresent(rogueState): 
    ~HealOneStep(rogueState)
}
{evenIfAbsent || IsPresent(clericState): 
    ~HealOneStep(clericState)
}
{evenIfAbsent || IsPresent(scholarState): 
    ~HealOneStep(scholarState)
}

/*
HealFull(companionState)
Heals a companion back to "healthy" unless they are dead
*/
=== function HealFull(ref companionState)
{companionState !? (dead):
        ~ SetStateTo(companionState, healthStates.healthy)
}

/*
HealFullAll(evenIfAbsent)
Heals all companions back to full, if not dead
Only heals present companions if flag is false 
Does ALL companions if flag is true
*/
=== function HealFullAll(evenIfAbsent)
{evenIfAbsent || IsPresent(rangerState): 
    ~HealFull(rangerState)
}
{evenIfAbsent || IsPresent(rogueState): 
    ~HealFull(rogueState)
}
{evenIfAbsent || IsPresent(clericState): 
    ~HealFull(clericState)
}
{evenIfAbsent || IsPresent(scholarState): 
    ~HealFull(scholarState)
}


/*
Injure(companionState)
Moves one state down the healthStatus states
healthy -> injured -> unconscious -> dead
Does nothing if companion is already at "dead"
Also reduces that companion's trust by 1
*/


=== function Injure(ref companionState)
//Checking Health State and...
{
    - companionState ? (healthy):
        //Injuring
        ~ SetStateTo(companionState, healthStates.injured)
    - companionState ? (injured):
        //Passing Out
        ~ SetStateTo(companionState, healthStates.unconscious)
    - companionState ? (unconscious):
        //Dying
        ~ SetStateTo(companionState, healthStates.dead)
    - else:
        ~ return
}
//Get correct trust variable from state and reduce by 1
{
    - companionState ? (Ranger):
        ~AlterTrust(rangerTrust, -1)
    - companionState ? (Rogue):
        ~AlterTrust(rogueTrust, -1)
    - companionState ? (Cleric):
        ~AlterTrust(clericTrust, -1)
    - companionState ? (Scholar):
        ~AlterTrust(scholarTrust, -1)
    - else:
        BUG: Accessing Unknown Companion
}

/*
Kill(companionState)
Takes a companion from any health state directly to "dead"
(Do not pass go. Do not collect 200 ancient artifact pieces.)
*/
=== function Kill(ref companionState)
~ SetStateTo(companionState, dead)

/*
Resurrect(companionState)
HERE's where the miracles happen :)
Returns a companion from "dead" to "healthy"
Don't know if this will actually be used in the game, but will be good to have around anyway
*/
=== function Resurrect(ref companionState)
{companionState ? (dead): 
    ~ SetStateTo(companionState, healthy)
}

//DEBUG
/*
PrintStatus(companionState)
Prints all relevant state info about a given companion
(presence, health, busy/available, trust)
*/

=== function PrintStatus(companionState)
~ temp trust = 0
//Get Name and trust
{
    - companionState ? (Ranger):
        ~trust = rangerTrust
        The Ranger <>
    - companionState ? (Rogue):
        ~trust = rogueTrust
        The Rogue <>
    - companionState ? (Cleric):
        ~trust = clericTrust
        The Cleric <>
    - companionState ? (Scholar):
        ~trust = scholarTrust
        The Scholar <>
    - else:
    This Unknown Companion (BUG!) <>
}
//Get present
{
    - companionState ? (present):
        is here, <>
    - companionState ? (missing):
        is not here, <>
    - else:
        is in UNKNOWN PRESENT STATUS (BUG!), <>
}
//Get health
{
    - companionState ? (healthy):
        is in full health, <>
    - companionState ? (injured):
        is injured, <>
    - companionState ? (unconscious):
        is unconscious, <>
    - companionState ? (dead):
        is dead, <>
    - else:
        is in UNKNOWN HEALTH (BUG!), <>
}
and <>
//Get busy
{
    - companionState ? (available):
        is not busy. <>
    - companionState ? (busy):
        is currently busy. <>
    - else:
        is in UNKNOWN BUSY STATUS (BUG!). <>
}
//Get Trust
Their trust level is <>
{
    - GetTrustThreshold(trust) == HIGH:
    HIGH.
    - GetTrustThreshold(trust) == MED:
    MEDIUM.
    - GetTrustThreshold(trust) == LOW:
    LOW.
    - else:
    UNKNOWN (BUG!).
}

/*
InjuryCount()
- Checks each companion for "injured" status and increments count if true
- returns total number of injured companions 
*/
=== function InjuryCount()
~ temp count = 0
{IsInjured(rangerState): 
    ~count++
}
{IsInjured(rogueState): 
    ~count++
}
{IsInjured(clericState): 
    ~count++
}
{IsInjured(scholarState): 
    ~count++
}

~ return count


===test_scene
{PrintStatus(rangerState)}
{PrintStatus(rogueState)}
{PrintStatus(clericState)}
{PrintStatus(scholarState)}

~ temp stateToChange = 0

+ [Change Ranger State]
~ stateToChange = rangerState
+ [Change Rogue States]
~ stateToChange = rogueState
+ [Change Cleric States]
~ stateToChange = clericState
+ [Change Scholar States]
~ stateToChange = scholarState
+ [Heal Everyone to full (who isn't dead)]
~ HealFullAll(true)
->test_scene

- ->test_change_states(stateToChange)

===test_change_states(companionState)
~ PrintStatus(companionState)
+ {not IsHealthy(companionState)}[Heal]
~ HealOneStep(companionState)
+ {not IsDead(companionState)} [Injure]
~ Injure(companionState)
+ {not IsDead(companionState)} [Kill :(]
~ Kill(companionState)
+ {IsDead(companionState)}  [Resurrect :)]
~ Resurrect(companionState)
+ {CanGiveJob(companionState)} [Give Job]
~SetStateTo(companionState, busy)
+[Toggle Busy]
{
    - IsBusy(companionState):
        ~ SetStateTo(companionState, available)
    - else:
        ~ SetStateTo(companionState, busy)  
}(SetStateTo(companionState, busy)
+[Toggle Present]
{
    - IsPresent(companionState):
        ~ SetStateTo(companionState, missing)
    - else:
        ~ SetStateTo(companionState, present)
}
+[Change Trust]
-> test_change_trust(companionState)
+[Done]
    ~ SaveCompanionState(companionState)
    ->test_scene

- ->test_change_states(companionState)


=== test_change_trust(companionState)
{
    - companionState ? (Ranger): ->ranger
    - companionState ? (Rogue): ->rogue
    - companionState ? (Cleric): ->cleric
    - companionState ? (Scholar): ->scholar
}
=ranger
The Ranger's trust is at {rangerTrust}
+ [Add 2 Trust]
~ AlterTrust(rangerTrust, 2)
->ranger
+ [Lose 1 Trust]
~ AlterTrust(rangerTrust, -1)
->ranger
+ [Done]
-> test_scene
=rogue
The Rogue's trust is at {rogueTrust}
+ [Add 1 Trust]
~ AlterTrust(rogueTrust, 1)
->rogue
+ [Lose 1000 Trust]
~ AlterTrust(rogueTrust, -1000)
->rogue
+ [Done]
-> test_scene
=cleric
The Cleric's trust is at {clericTrust}
+ [Add 3 Trust]
~ AlterTrust(clericTrust, 3)
->cleric
+ [Lose 2 Trust]
~ AlterTrust(clericTrust, -2)
->cleric
+ [Done]
-> test_scene
=scholar
The Scholar's trust is at {scholarTrust}
+ [Add 7 Trust]
~ AlterTrust(scholarTrust, 7)
->scholar
+ [Lose 5 Trust]
~ AlterTrust(scholarTrust, -5)
->scholar
+ [Done]
-> test_scene




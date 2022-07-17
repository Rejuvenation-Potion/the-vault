/*
THE VAULT Functional Draft
Author: Lochlan Belford
Date Started: 7/12/2022
Date Finished: 
Description: 
- Draft of the entire game, with all logic and branching implemented
- All story text is as bare and strictly functional as possible
*/

INCLUDE function_library.ink
INCLUDE save_states.ink

->SETUP_PROLOGUE

/// SAVE STATES

/****** PROLOGUE: The Vault ******

******/
///PROLOGUE Variables
LIST prologueEvents = creaturesArrived, creaturesScared, creaturesKilled, fireSet, trustedScholar

///PROLOGUE Scenes
===SETUP_PROLOGUE
~EnterSaveState(0)
->intro_prologue

===intro_prologue
You stand before a large stone structure. This is it, the ancient vault you have been searching for. 
You are in a small clearing and the vault is just ahead of you. On all other sides you are surrounded by the jungle you navigated to get here. You have travelled all day, and it is nearly sunset.
*   [Continue.]
    Set into the stone wall are two huge stone doors. Your guide, The Ranger, steps forward and studies them.
    "Those look heavy," she says, "but I should be able to get them open."
    **[Continue.]->job_001


/*** JOB PATTERN ***
A job is the main unit of gameplay in the puzzle sections of the game.
They involve assigning a party member to a particular task, who then takes some number of "turns" to complete that task.
Each turn is represented by visiting the job knot another time.
Jobs knots follow a template:

=== job_XYY
(The knot name identifies its place in the overall story. 
    X = act number, 
    Y = sequence number (i.e. identify magic -> disarm magic OR use magic are all in same sequence) 
    Z = job number)

Any job complex enough to need multiple turns should begin with a code block that checks if this is the first time visiting the knot or... not.

If the job is finished, skip to next job
If already assigned and in progress, should divert to appropriate stitch to continue adding job progress
If first visit, go to intro/assignment choice

=intro
Intro text makes clear what the job entails

=assignment
The assignment stitch presents the choice of who to assign to the job

Each choice should be conditional on the CanGiveJob(companionState) check, and possibly other conditions such as trust or past events as well.

Selected companion should be set to busy on choice selection

EXAMPLE:
* {CanGiveJob(rangerState)} [(Example choice) Assign the Ranger.]
    You assign the ranger.
    ~SetStateTo(rangerState, busy)

=ranger (or rogue, or cleric, or scholar, or possibly others...)
The stitches named for assigned characters are where the turns happen.
For now this is represented by a sequence of whatever length is appropriate for that character

=finish
This is the stitch that marks the job as finished
Should be diverted to by every companion stitch, but also possiby from other places (for example if one job completes another)
->next_job

JOB TEMPLATE
=== job_XYZ
{
    - job_XYZ.finish: ->->
    - job_XYZ.ranger: ->ranger
    - job_XYZ.rogue: ->rogue
    - job_XYZ.cleric: ->cleric
    - job_XYZ.scholar: ->scholar
    - else: ->intro
}
=intro
TODO: job intro
=assignment
TODO: job assignment
* {CanGiveJob(rangerState)} [Assign the Ranger.]
    You assign the ranger.
    ~SetStateTo(rangerState, busy)
    ->ranger
    
* {CanGiveJob(rogueState)} [Assign the Rogue.]
    You assign the rogue.
    ~SetStateTo(rogueState, busy)
    ->rogue
    
* {CanGiveJob(clericState)} [Assign the Cleric.]
    You assign the cleric.
    ~SetStateTo(clericState, busy)
    ->cleric
    
* {CanGiveJob(scholarState)} [Assign the Scholar.]
    You assign the scholar.
    ~SetStateTo(scholarState, busy)
    ->scholar

=ranger
{once:
    - starting job
    - making progress
    - done!
    ~ SetStateTo(rangerState, available)
    ->finish
}
->->

=rogue
{once:
    - starting job
    - making progress
    - done!
    ~ SetStateTo(rogueState, available)
    ->finish
}
->->

=cleric
{once:
    - starting job
    - making progress
    - done!
    ~ SetStateTo(clericState, available)
    ->finish
}
->->

=scholar
{once:
    - starting job
    - making progress
    - done!
    ~ SetStateTo(scholarState, available)
    ->finish
}
->->

=finish
TODO: Job finish text
->->

***/

//Job 001: OPEN Doors
=== job_001
Someone needs to get those doors open. You could follow the Ranger's suggestion, or assign one of your other companions to the task. ->assignment
=assignment
* {CanGiveJob(rangerState)}[Let the Ranger open the doors]
    You tell the Ranger to open the doors.
    ~SetStateTo(rangerState, busy)
    ->ranger
* {CanGiveJob(rogueState)} [Assign the Rogue to open the doors]
    You tell the Rogue to open the doors.
    ~SetStateTo(rogueState, busy)
    ->rogue
* {CanGiveJob(clericState)}[Assign the Cleric to open the doors]
    You tell the Cleric to open the doors.
    ~SetStateTo(clericState, busy)
    ->cleric
* {CanGiveJob(scholarState)}[Assign the Scholar to open the doors]
    You call out to the Scholar, but she cuts you off.
    "Bah, I have better things to do than manual labor, get one of these other cretins to do it. Isn't that why we hired them?" She doesn't even look up from her scrolls.
    ->assignment
=ranger
"No problem, boss." The Ranger moves up to the door, scanning them quickly for any obvious danger. She then places her hands on the stone surface and prepares to push.
As soon as her hands make contact however, <>
~SetStateTo(rangerState, available)
->finish
=rogue
"You know our contract didn't mention anything about manual labor, I thought you hired me for my finesse." The Rogue smirks, but he strides up the door regardless. "Well, pretty sure I get time-and-a-half for this." 
He places one hand out to lean upon the doors for a moment. 
As soon as his hand makes contact however, <>
~SetStateTo(rogueState, available)
->finish
=cleric
You call out to the Cleric, and he looks up suddenly from his prayerbook. His sad eyes meet yours for a moment. 
"If that is what you wish. I-I suppose it might be safest for me to be the first into this tomb regardless." 
He walks carefully up to the doors and places his hands upon their stone surface. 
As soon as his hands make contact however, <>
~SetStateTo(clericState, available)
->finish

=finish
 hundreds of luminous blue symbols--magical runes of some kind--appear on the surface of the doors and and scatter outward from the point of contact. They are connected by elegant arcs of white energy. You all take a small step backward, and as soon as no one is touching the doors, the glowing symbols begin to fade again.
* [Continue.]->lock

=== lock
At the first sign of this magic, the Scholar looks up from the scroll she was buried in. "Oh finally, something interesting!" 
"And potentially dangerous," adds the Ranger. "We might be dealing with a magical trap of some sort."
The Scholar takes off her reading glasses and stows them away. "Well, if you let me get a closer look, I can tell you for sure."
* [Continue]
{job_001.rogue: 
The rogue chimes in. "Look all you want, but the door is locked anyway." You turn to him where he is leaning on the door, and he points lazily upward.
}
{job_001.ranger:
    The Ranger holds up a hand. "Just hold on, the door is locked anyway. I could tell when I tried to push it."
} 
{job_001.cleric:
    "Uh, if I may," the Cleric interjects heasitantly. "Trap or no trap, from what I could tell the door is also locked."
} 
{not job_001.rogue:
    "Pff, I could have told you that," says the Rogue. "Look up there." 
    You turn to him and see that he is pointing to something high up on the wall.
}
**[Continue] ->magic

=== magic
Following his gesture, you see a stone box with several openings--presumably a large locking mechanism of some kind--high up on the wall.
"With all the vines growing over the stonework, I could climb up there no problem and get that open for you," says the rogue. "But I don't want anything to do with that magic!"
The scholar huffs. "That is why I already said that should be left to me!"

{
    - not job_001.cleric:The Cleric, who has been quiet until now, <>
    - else: The Cleric <>
}
speaks softly. "If I can be of some use here, I also have some experience with magic. if you give me a moment, I could craft a counterspell that would remove the magic regardless of its purpose."
The Scholar whirls on him. "And lose an opportunity for study?" She turns back to you. "It is possible that this magic might actually help us, but we'll never know if you don't give me a chance."
"Respectfully, we might not have time to sit here while you doodle in your notebook," the Ranger counters. "We've been travelling all day and the sun is settting. This jungle gets dangerous at night."
The Scholar looks down her nose at the Ranger. "You obviously don't understand how quickly I work."
The Ranger sighs, and then she turns back to you. "It's your call."
* [Continue]->pass_time

/*
Here is where we enter the main loop of the prologue!
After a lot of confusion regarding order, I realized the problem is I wanted to go in a different order in the initial loop than in all further iterations.
1st time: Magic -> Lock -> Animals
All further times: Lock -> Magic -> Animals

Ending with the same thing both times fortunately makes this less annoying than it could be
*/
===pass_time
+ {pass_time == 1} [DEBUG: Continue into first loop] -> magic_sequence -> lock_sequence -> animals_sequence
+ {pass_time > 1} [DEBUG: Go Into Normal Loop] -> lock_sequence -> magic_sequence -> animals_sequence

/*
-> lock_sequence -> magic_sequence -> animals_sequence -> pass_time
*/
=== lock_sequence
In Lock Sequence
{
    - not job_020.finish: ->job_020
    //This one moight exit tunnel to finale instead!
    - not job_021.finish: ->job_021
}

=== magic_sequence
In Magic Sequence
{
    //If 
    - not job_010.finish && not job_011: -> job_010
    - not job_011.finish && not job_012: -> job_011
    - job_012 && not job_012.finish: -> job_012
}

=== animals_sequence
In Animals Sequence
{
    - not job_030.finish: ->job_030->
    - else: ->job_031->
}
+ [Continue.] -> pass_time


TODO: I STOPPED HALFWAY THROUGH JOB 010

/*
Job 010: INVESTIGATE Magic
Only Ranger and Scholar investigate,
Cleric and Rogue skip immediately to job 011: DISARM Trap
*/
===job_010
{
    - job_010.finish: ->job_011
    - job_010.ranger: ->ranger
    - else: ->intro
}
=intro
Someone needs to determine the nature of the magic spell, while someone else climbs up and unlocks the doors.
What should be done about the unknown magic?
->assignment
=assignment
* {CanGiveJob(scholarState)} [Allow The Scholar to begin studying it.]
    "We should learn as much as we can," you say. You turn to the Scholar. "And this is exactly your area of expertise."
    ~SetStateTo(scholarState, busy)
    ->scholar
    
* {CanGiveJob(clericState)} [Have The Cleric begin dispelling it.]
    "Let's not take any chances," you say and turn to the Cleric. "Dispel it."
    ~SetStateTo(clericState, busy)
    ->job_011.cleric

* {CanGiveJob(rangerState)} [The Ranger has good danger sense; tell her to investigate it]
    You decide the Ranger should be the one to investigate the unknown magic.
    ~SetStateTo(rangerState, busy)
    ->ranger
    
* {CanGiveJob(rogueState)} [It's probably a trap; tell The Rogue to disarm it]
    "It is almost certainly a trap," you say. You turn to the Rogue. "And you are our trap expert; get in there and disarm it."
    ~SetStateTo(rogueState, busy)
    ->job_011.rogue
    
=ranger
{once:
    - "Makes sense I suppose," she shrugs. "I don't know much magic, but I should be able to tell if it's dangerous."
    - TODO: making progress
    - TODO: done!
    ~ SetStateTo(rangerState, available)
    ->finish
}
->->

=rogue
{once:
    - "Literally what did I just say??" he exclaims. There is a pause, and then a sigh. "Look, I'll do it, but I won't forget this."
    - making progress
    - done!
    ~ SetStateTo(rogueState, available)
    ->finish
}
->->

=cleric
{once:
    - "Very well." The Cleric opens his prayerbook and begins muttering an incantation. His voice is drowned out for a moment by the Scholar's loud protestations, but you silence her with a stern glance.
    - making progress
    - done!
    ~ SetStateTo(clericState, available)
    ->finish
}
->->

=scholar
{once:
    - "Excellent!" The Scholar produces a notebook and begins writing in it frantically.
    - making progress
    - done!
    ~ SetStateTo(scholarState, available)
    ->finish
}
->->

=finish
TODO: Job finish text
->->

/*
Job 011: DISARM/DISPELL Trap
*/
=== job_011
{
    - job_011.finish: ->->
    - job_011.ranger: ->ranger
    - job_011.rogue: ->rogue
    - job_011.cleric: ->cleric
    - job_011.scholar: ->scholar
    - else: ->intro
}
=intro
TODO: job intro
=assignment
TODO: job assignment
* {CanGiveJob(rangerState)} [Assign the Ranger.]
    You assign the ranger.
    ~SetStateTo(rangerState, busy)
    ->ranger
    
* {CanGiveJob(rogueState)} [Assign the Rogue.]
    You assign the rogue.
    ~SetStateTo(rogueState, busy)
    ->rogue
    
* {CanGiveJob(clericState)} [Assign the Cleric.]
    You assign the cleric.
    ~SetStateTo(clericState, busy)
    ->cleric
    
* {CanGiveJob(scholarState)} [Assign the Scholar.]
    You assign the scholar.
    ~SetStateTo(scholarState, busy)
    ->scholar

=ranger
{once:
    - starting job
    - making progress
    - done!
    ~ SetStateTo(rangerState, available)
    ->finish
}
->->

=rogue
{once:
    - starting job
    - making progress
    - done!
    ~ SetStateTo(rogueState, available)
    ->finish
}
->->

=cleric
{once:
    - starting job
    - making progress
    - done!
    ~ SetStateTo(clericState, available)
    ->finish
}
->->

=scholar
{once:
    - starting job
    - making progress
    - done!
    ~ SetStateTo(scholarState, available)
    ->finish
}
->->

=finish
TODO: Job finish text
->->
/*
Job 012: REPURPOSE Magic trap (Scholar only)
*/
=== job_012
{
    - job_012.finish: ->->
    - job_012.ranger: ->ranger
    - job_012.rogue: ->rogue
    - job_012.cleric: ->cleric
    - job_012.scholar: ->scholar
    - else: ->intro
}
=intro
TODO: job intro
=assignment
TODO: job assignment
* {CanGiveJob(rangerState)} [Assign the Ranger.]
    You assign the ranger.
    ~SetStateTo(rangerState, busy)
    ->ranger
    
* {CanGiveJob(rogueState)} [Assign the Rogue.]
    You assign the rogue.
    ~SetStateTo(rogueState, busy)
    ->rogue
    
* {CanGiveJob(clericState)} [Assign the Cleric.]
    You assign the cleric.
    ~SetStateTo(clericState, busy)
    ->cleric
    
* {CanGiveJob(scholarState)} [Assign the Scholar.]
    You assign the scholar.
    ~SetStateTo(scholarState, busy)
    ->scholar

=ranger
{once:
    - starting job
    - making progress
    - done!
    ~ SetStateTo(rangerState, available)
    ->finish
}
->->

=rogue
{once:
    - starting job
    - making progress
    - done!
    ~ SetStateTo(rogueState, available)
    ->finish
}
->->

=cleric
{once:
    - starting job
    - making progress
    - done!
    ~ SetStateTo(clericState, available)
    ->finish
}
->->

=scholar
{once:
    - starting job
    - making progress
    - done!
    ~ SetStateTo(scholarState, available)
    ->finish
}
->->

=finish
TODO: Job finish text
->->

/*
Job 020: UNLOCK Doors
*/
=== job_020
{
    - job_020.finish: ->->
    - job_020.ranger: ->ranger
    - job_020.rogue: ->rogue
    - job_020.cleric: ->cleric
    - job_020.scholar: ->scholar
    - else: ->intro
}
=intro
TODO: job intro
=assignment
TODO: job assignment
* {CanGiveJob(rangerState)} [Assign the Ranger.]
    You assign the ranger.
    ~SetStateTo(rangerState, busy)
    ->ranger
    
* {CanGiveJob(rogueState)} [Assign the Rogue.]
    You assign the rogue.
    ~SetStateTo(rogueState, busy)
    ->rogue
    
* {CanGiveJob(clericState)} [Assign the Cleric.]
    You assign the cleric.
    ~SetStateTo(clericState, busy)
    ->cleric
    
* {CanGiveJob(scholarState)} [Assign the Scholar.]
    You assign the scholar.
    ~SetStateTo(scholarState, busy)
    ->scholar

=ranger
{once:
    - starting job
    - making progress
    - done!
    ~ SetStateTo(rangerState, available)
    ->finish
}
->->

=rogue
{once:
    - starting job
    - making progress
    - done!
    ~ SetStateTo(rogueState, available)
    ->finish
}
->->

=cleric
{once:
    - starting job
    - making progress
    - done!
    ~ SetStateTo(clericState, available)
    ->finish
}
->->

=scholar
{once:
    - starting job
    - making progress
    - done!
    ~ SetStateTo(scholarState, available)
    ->finish
}
->->

=finish
TODO: Job finish text
->->

/*
Job 021: OPEN Doors (for real this time)
*/
=== job_021
{
    - job_021.finish: ->->
    - job_021.ranger: ->ranger
    - job_021.rogue: ->rogue
    - job_021.cleric: ->cleric
    - job_021.scholar: ->scholar
    - else: ->intro
}
=intro
TODO: job intro
=assignment
TODO: job assignment
* {CanGiveJob(rangerState)} [Assign the Ranger.]
    You assign the ranger.
    ~SetStateTo(rangerState, busy)
    ->ranger
    
* {CanGiveJob(rogueState)} [Assign the Rogue.]
    You assign the rogue.
    ~SetStateTo(rogueState, busy)
    ->rogue
    
* {CanGiveJob(clericState)} [Assign the Cleric.]
    You assign the cleric.
    ~SetStateTo(clericState, busy)
    ->cleric
    
* {CanGiveJob(scholarState)} [Assign the Scholar.]
    You assign the scholar.
    ~SetStateTo(scholarState, busy)
    ->scholar

=ranger
{once:
    - starting job
    - making progress
    - done!
    ~ SetStateTo(rangerState, available)
    ->finish
}
->->

=rogue
{once:
    - starting job
    - making progress
    - done!
    ~ SetStateTo(rogueState, available)
    ->finish
}
->->

=cleric
{once:
    - starting job
    - making progress
    - done!
    ~ SetStateTo(clericState, available)
    ->finish
}
->->

=scholar
{once:
    - starting job
    - making progress
    - done!
    ~ SetStateTo(scholarState, available)
    ->finish
}
->->

=finish
TODO: Job finish text
->->

/*
Job 030: DELAY Animals
*/
=== job_030
{
    - job_030.finish: ->->
    - job_030.ranger: ->ranger
    - job_030.rogue: ->rogue
    - job_030.cleric: ->cleric
    - job_030.scholar: ->scholar
    - else: ->intro
}
=intro
TODO: job intro
=assignment
TODO: job assignment
* {CanGiveJob(rangerState)} [Assign the Ranger.]
    You assign the ranger.
    ~SetStateTo(rangerState, busy)
    ->ranger
    
* {CanGiveJob(rogueState)} [Assign the Rogue.]
    You assign the rogue.
    ~SetStateTo(rogueState, busy)
    ->rogue
    
* {CanGiveJob(clericState)} [Assign the Cleric.]
    You assign the cleric.
    ~SetStateTo(clericState, busy)
    ->cleric
    
* {CanGiveJob(scholarState)} [Assign the Scholar.]
    You assign the scholar.
    ~SetStateTo(scholarState, busy)
    ->scholar

=ranger
{once:
    - starting job
    - making progress
    - done!
    ~ SetStateTo(rangerState, available)
    ->finish
}
->->

=rogue
{once:
    - starting job
    - making progress
    - done!
    ~ SetStateTo(rogueState, available)
    ->finish
}
->->

=cleric
{once:
    - starting job
    - making progress
    - done!
    ~ SetStateTo(clericState, available)
    ->finish
}
->->

=scholar
{once:
    - starting job
    - making progress
    - done!
    ~ SetStateTo(scholarState, available)
    ->finish
}
->->

=finish
TODO: Job finish text
->->

/*
Job 031: CONFRONT Animals
*/
=== job_031
{
    - job_031.finish: ->->
    - job_031.ranger: ->ranger
    - job_031.rogue: ->rogue
    - job_031.cleric: ->cleric
    - job_031.scholar: ->scholar
    - else: ->intro
}
=intro
TODO: job intro
=assignment
TODO: job assignment
* {CanGiveJob(rangerState)} [Assign the Ranger.]
    You assign the ranger.
    ~SetStateTo(rangerState, busy)
    ->ranger
    
* {CanGiveJob(rogueState)} [Assign the Rogue.]
    You assign the rogue.
    ~SetStateTo(rogueState, busy)
    ->rogue
    
* {CanGiveJob(clericState)} [Assign the Cleric.]
    You assign the cleric.
    ~SetStateTo(clericState, busy)
    ->cleric
    
* {CanGiveJob(scholarState)} [Assign the Scholar.]
    You assign the scholar.
    ~SetStateTo(scholarState, busy)
    ->scholar

=ranger
{once:
    - starting job
    - making progress
    - done!
    ~ SetStateTo(rangerState, available)
    ->finish
}
->->

=rogue
{once:
    - starting job
    - making progress
    - done!
    ~ SetStateTo(rogueState, available)
    ->finish
}
->->

=cleric
{once:
    - starting job
    - making progress
    - done!
    ~ SetStateTo(clericState, available)
    ->finish
}
->->

=scholar
{once:
    - starting job
    - making progress
    - done!
    ~ SetStateTo(scholarState, available)
    ->finish
}
->->

=finish
TODO: Job finish text
->->


=== finale

->SETUP_ACT1

/****** ACT 1: The Scholar ******

*******/
///ACT 1 Variables
///ACT 1 Scenes
===SETUP_ACT1

->intro_act1

===intro_act1
You made it inside.
*You look back at your companions.-> companion_reactions

===companion_reactions
Your companions react to the events outside.
{
    - prologueEvents ? (trustedScholar): Because you trusted the scholar to handle the trap, she is acting like your best friend now.
    - else: The scholar is in a terrible mood because you didn't trust her outside.
}
->antechamber

===antechamber
You are in the antechamber of the vault.
There is one way out of this room, directly across from you.
->END

===conversations_act1
->END

===rest_act1
->END

===path_forward
->END

===puzzle_room
->END

/****** ACT 2: The Brothers ******

******/

/****** ACT 3: The Ranger ******

******/

/****** FINALE: The Artifact ******

******/

/*
Cleric Rogue Argument scene
*/

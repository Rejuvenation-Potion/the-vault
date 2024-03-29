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


->DEBUG_MENU
///->SETUP_PROLOGUE

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
* {CanGiveJob(rangerState)} [Assign the Ranger.]
    You assign the ranger.
    ~SetStateTo(rangerState, busy)

=ranger (or rogue, or cleric, or scholar, or possibly others...)
The stitches named for assigned characters are where the turns happen.
For now this is represented by a sequence of whatever length is appropriate for that character (i.e. number of options in sequence == number of turns to complete job)

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
->assignment
=assignment
TODO: job assignment
* {CanGiveJob(rangerState)} [Assign the Ranger.]
    TODO: You assign the ranger.
    ~SetStateTo(rangerState, busy)
    TODO: Trust Changes
    ~AlterTrust(Ranger, 0)
    ->ranger
    
* {CanGiveJob(rogueState)} [Assign the Rogue.]
    TODO: You assign the rogue.
    ~SetStateTo(rogueState, busy)
    TODO: Trust Changes
    ~AlterTrust(Rogue, 0)
    ->rogue
    
* {CanGiveJob(clericState)} [Assign the Cleric.]
    TODO: You assign the cleric.
    ~SetStateTo(clericState, busy)
    TODO: Trust Changes
    ~AlterTrust(Cleric, 0)
    ->cleric
    
* {CanGiveJob(scholarState)} [Assign the Scholar.]
    TODO: You assign the scholar.
    ~SetStateTo(scholarState, busy)
    TODO: Trust Changes
    ~AlterTrust(Scholar, 0)
    ->scholar

=ranger
{once:
    - TODO: starting job
    - TODO: making progress
    - TODO: done!
    ~ SetStateTo(rangerState, available)
    ->finish
}
->->

=rogue
{once:
    - TODO: starting job
    - TODO: making progress
    - TODO: done!
    ~ SetStateTo(rogueState, available)
    ->finish
}
->->

=cleric
{once:
    - TODO: starting job
    - TODO: making progress
    - TODO: done!
    ~ SetStateTo(clericState, available)
    ->finish
}
->->

=scholar
{once:
    - TODO: starting job
    - TODO: making progress
    - TODO: done!
    ~ SetStateTo(scholarState, available)
    ->finish
}
->->

=finish
TODO: Job finish text
->->

***/


///Storywide Variables and Knowledge Chains
//Scholar
LIST scholarEndings = humbled, proud
//Cleric and Rogue
LIST brothersKnowledge = WHY_NOT_ASK_HIM, KNOW_ARE_BROTHERS, KNOW_ABOUT_CONFLICT, HEARD_ONE_SIDE, HEARD_BOTH_SIDES
LIST rogueEndings = revenge, loner, belonging
LIST clericEndings = lostFaith, statusQuo, enlightenment
//Ranger
LIST rangerGriefStages = (CLOSED_OFF), OPENING_UP, PROCESSING_GRIEF, ACCEPTED_LOSS
LIST rangerEndings = sacrifice, deathGuilt, deniedMartyr, brilliantPloy

=== DEBUG_MENU
+ [Start Game.]->SETUP_PROLOGUE
+ [Skip to Act 1.] ->SKIP_TO_ACT_1
//+ [Skip to Act 2.] ->SKIP_TO_ACT_2


/****** PROLOGUE: The Vault ******

******/
///PROLOGUE Variables
LIST prologueEvents = creaturesArrived, creaturesScared, creaturesKilled, fireSet, trustedScholar, trapDisarmed

//Record names from companionNames list in prologueInjuries, so that these specific injuries can be referenced later in dialogue
VAR prologueInjuries = ()

VAR player_injured = false

///PROLOGUE Scenes
===SETUP_PROLOGUE
~EnterSaveState(0, false)
->intro_prologue

===intro_prologue
You stand before a large stone structure. This is it, the ancient vault you have been searching for. 
You are in a small clearing and the vault is just ahead of you. On all other sides you are surrounded by the jungle you navigated to get here. You have travelled all day, and it is nearly sunset.
*   [Continue.]
    Set into the stone wall are two huge stone doors. Your guide, The Ranger, steps forward and studies them.
    "Those look heavy," she says, "but I should be able to get them open."
    **[Continue.]->job_001




//Job 001: OPEN Doors
=== job_001
=intro
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
+ {pass_time == 1} -> magic_sequence -> lock_sequence -> animals_sequence
+ {pass_time > 1} -> lock_sequence -> magic_sequence -> animals_sequence




=== magic_sequence
{
    //If lock is not investigated and dispelling has not started
    - not job_010.finish && not job_011: -> job_010
    //If dispelling isn't finished and scholar wasn't picked
    - not job_011.finish && not job_012: -> job_011
    //If scholar was picked but isn't finished yet
    - job_012 && not job_012.finish: -> job_012
    //Otherwise we are totally done with this sequence
    - else: ->->
}

=== lock_sequence
{
    - not job_020.finish: ->job_020
    //This one might exit tunnel to finale instead!
    - not job_021.finish: ->job_021
}

=== animals_sequence
{
    - prologueEvents ? (creaturesScared) || prologueEvents ? (creaturesKilled): -> pass_time
    //If animals not arrived yet
    - not job_030.finish: ->job_030->
    //If animals arrived
    - else: ->job_031->
}
//Restart loop
+ [Continue.] -> pass_time

/*
Job 010: INVESTIGATE Magic
Only Ranger and Scholar investigate,
Cleric and Rogue skip immediately to job 011: DISARM Trap
*/
===job_010
{
    - job_010.finish: ->job_011
    - job_010.ranger: ->ranger
    - job_010.scholar: ->scholar
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
    ~AlterTrust(Scholar, -2)
    ~AlterTrust(Cleric, 1)
    ->job_011.cleric

* {CanGiveJob(rangerState)} [The Ranger has good danger sense; tell her to investigate it]
    You decide the Ranger should be the one to investigate the unknown magic.
    ~SetStateTo(rangerState, busy)
    ~AlterTrust(Scholar, -2)
    ->ranger
    
* {CanGiveJob(rogueState)} [It's probably a trap; tell The Rogue to disarm it]
    "It is almost certainly a trap," you say. You turn to the Rogue. "And you are our trap expert; get in there and disarm it."
    "Literally what did I just say??" he exclaims. There is a pause, and then a sigh. "Look, I'll do it, but I won't forget this."
    ~SetStateTo(rogueState, busy)
    ~AlterTrust(Scholar, -2)
    ~AlterTrust(Rogue, -2)
    ->job_011.rogue
    
=ranger
{once:
    - "Makes sense I suppose," she shrugs. "I don't know much magic, but I should be able to tell if it's dangerous."
    - Meanwhile, the Ranger steps up as close as she can to the doors and scans their stone surfaces. Soon enough, she seems to have found what she is looking for.
    "Look here," she says, calling your attention to a series of small holes in the doors' surface.
    ~ SetStateTo(rangerState, available)
    ->finish
}
->->

=scholar
{once:
    - "Excellent!" The Scholar produces a notebook and begins writing in it frantically.
    - Meanwhile, the Scholar continues scribbling in her notebook, hard at work deciphering the magic imbued into the doors. Every now and then she pauses her writing to poke the surface of the doors, causing the glowing runes to reappear with their connecting lines. Looking over her shoulder, it appears as though she is studying the patterns of the lines and sketching dizzyingly complex diagrams to keep track of them all.
    "Aha!" Suddenly, she snaps the book shut. "I've got it."
    ~ SetStateTo(scholarState, available)
    ->finish
}
->->

=finish
* {CameFrom(->ranger)} [Continue.]
    You look where she points.
    "If I know traps, something really bad is going to shoot out of these when the doors are open. Probably some sort of magical projectile from the looks of things."
    "Now that we know what it is though, we can disarm it." She continues, "The Cleric could dispel the magic like he offered, but it should also be simple enough for one of us to physically disarm the projectile mechanism. Up to you."
* {CameFrom(->scholar)} [Continue.]
    "It's a trap of Moonfire," the Scholar explains, "designed to scorch whoever opens those doors."
    "Nice work," says the Ranger. "Let's get it turned off then."
    "Not so fast," the Scholar replies. "If you'll allow me to keep studying, I believe I can discover a way we might turn this magic to our advantage." The Scholar smiles broadly, but does not elaborate any further.
- ->job_011

/*
Job 011: DISARM/DISPELL Trap
*/
=== job_011
{
    - job_011.finish: ->->
    - job_011.ranger: ->ranger
    - job_011.rogue: ->rogue
    - job_011.cleric: ->cleric
    - else: ->intro
}
=intro
Now that you know more about the magic, who will deal with it?
->assignment
=assignment
* {CanGiveJob(scholarState) && not job_010.scholar} [Ask the Scholar to help dispel the trap.]
    The Scholar looks thouroughly displeased with you for not allowing her to study the magic. "Do it yourself, I won't help you destroy this arcane knowledge."
    ->assignment
* {CanGiveJob(scholarState) && job_010.scholar}[Allow the Scholar to continue studying the magic.]
    "Keep at it," you tell the Scholar. "I trust you."
    ~SetStateTo(scholarState, busy)
    ~AlterTrust(Scholar, 2)
    ->job_012.scholar
* {CanGiveJob(rangerState)} [Assign the Ranger.]
    You turn to the Ranger.
    "Sounds like you already have a good idea how to disarm this thing" you tell the Ranger. "Go ahead and get started."
    The Ranger nods in response. "Good plan."
    ~SetStateTo(rangerState, busy)
    ~AlterTrust(Ranger, 1)
    ~AlterTrust(Scholar, -2)
    ->ranger
    
* {CanGiveJob(rogueState)} [Assign the Rogue.]
    "I know you were wary of the magic, but we know what it is now. You say to the Rogue to cut off his protest. "And traps are your specialty."
    The Rogue sighs dramatically, but moves to the door anyway.
    {not job_020.rogue: He mutters under his breath just loud enough for you to hear, "I would have rather dealt with the lock..."}
    ~SetStateTo(rogueState, busy)
    ~AlterTrust(Rogue, -1)
    ~AlterTrust(Scholar, -2)
    ->rogue
    
* {CanGiveJob(clericState)} [Assign the Cleric.]
    You turn to the Cleric. "Go ahead and dispel it."
    ~SetStateTo(clericState, busy)
    ~AlterTrust(Cleric, 1)
    {job_010.scholar: 
        ~AlterTrust(Scholar, -2)
    }
    ->cleric
    


=ranger
{once:
    - The Ranger starts disarming the trap. She moves about the clearing for a minute gathering leaves, mud, and small rocks from the jungle floor. She then returns to the hole she found in the door and plugs it up with the material she gathered. She inspects her work for a moment and appears satisfied. 
    "This is going to work, but it will take some time. There are a few dozen of these holes to fill." She gets back to work.
    - The Ranger continues disarming the trap. She has filled over half the holes by now. "I think these are supposed to shoot jets of fire!" she calls back over her shoulder. "What I'm doing should suppress that."
    - You see that the Ranger seems to have finished her work at the doors. "Just one more second!" she says. She strikes the doors with the hilt of her handaxe and then retreats a few steps. The runes appear again, and then pools of white-blue energy appear around each of the openings the Ranger had filled. They glow brighter and brighter and you begin to anticipate an explosion of some kind. Instead however, you hear only a soft "pop." A few of the trap's openings emit a tiny jet of white fire before quickly burning out, and the rest lie totally dormant. After a moment all of the magical energy fades.
    ~ SetStateTo(rangerState, available)
    ->finish
}
->->

=rogue
{once:
    - While he isn't happy about it, the Rogue starts disarming the trap. He begins gingerly poking at the stone doors, causing the magical symbols to once again scatter across the surface. He takes out one of his daggers and scrapes it across one of the runes, as if trying to scratch it out. Suddenly the Rogue jumps back, turning away with his hands over his ears as if expecting an explosion. But after a tense moment, there is no reaction. The Rogue relaxes, and turns to you.
    "Well, I know how to do this now, but it's going to take a minute."
    - The Rogue has continues disarming the trap, proceding carefully across the stone wall and erasing runes one by one. "Almost done!" he calls out.
    - The Rogue calls out to you again. "We're good to go!" He scratches out one final symbol, and then strikes the doors with the hilt of his dagger, as if attempting to trigger the trap. He is trying to appear confident in his work, but you notice he still flinches as he does this. But nothing happens, and no runes appear.
    ~ SetStateTo(rogueState, available)
    ->finish
}
->->

=cleric
{once:
    - "Very well." The Cleric opens his prayerbook and begins muttering an incantation. His voice is drowned out for a moment by the Scholar's loud protestations, but you silence her with a stern glance.
    The Cleric is preparing his counterspell. As he reads out line after line from his worn prayerbook, he begins faintly glowing with a golden light.
    - the Cleric finishes his spell. He speaks one final word in a language you do not understand, his normally soft voice crescendoing to a surprising volume. The golden light that had been gathering around him travels forward in a wave and suffuses the stone doors, as if washing across their surface. The Cleric walks up and softly places a palm on the stone door. Unlike last time, no magical runes or lines appear. He smiles gently, satisfied with his work. The magic has been dispelled.
    ~ SetStateTo(clericState, available)
    ->finish
}
->->

=finish
~prologueEvents += trapDisarmed
{
    - CameFrom(->ranger) || CameFrom(->rogue): The trap is disarmed!
    - CameFrom(->cleric): The magic trrap is dispelled!
}
->->
/*
Job 012: REPURPOSE Magic trap (Scholar only)
*/
=== job_012
{
    - job_012.finish: ->->
    - job_012.scholar: ->scholar
}

=scholar
{once:
     - Pleased, the Scholar goes back to her note taking. "How nice it is to work with someone who values intelligence! Now as soon as I copy down all the details of this magic, I'll show you what it can do."
    - "Yes!" You hear the Scholar cry out with glee." The Scholar snaps her book shut once again. "Now this will be fun!" 
    ~ SetStateTo(scholarState, available)
    ->finish
}
->->

=finish
~prologueEvents += trapDisarmed
~prologueEvents += trustedScholar
Moving quickly, the Scholar knocks several times on the doors in quick succession, in a different spot each time. Each knock leads to more magical lines rippling accross the surface of the door. They seem to be coalescing into pools of bright energy scattered across the stone wall. With a last knock, the Scholar suddenly twirls out of the way. A beam of white fire shoots out from each of the magical pools, arcing toward where the Scholar was just standing. But her dodge was successful, and the moonfire instead arcs out harmlessly into the jungle.
{
    - prologueEvents !? (creaturesArrived): To your pleasant surprise, this burst of firey magic also seems to scare the creatures that have been meancing you from the jungle. You hear two terrified yelps in the darkness, and then the sounds of creatures dashing away through the underbrush, the sound fading as they get further and further away. The Scholar turned the trap to your advantage after all!
        ~ prologueEvents += creaturesScared
    - prologueEvents !? (creaturesKilled): To your pleasant surprise, the leopards that have been attacking you take one look at the burst of firey magic and dart off into the jungle in terror. The Scholar turned the trap to your advantage after all!
        ~ prologueEvents += creaturesScared
}
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
Now for the lock: who should climb up and open it?
->assignment
=assignment
* {CanGiveJob(rangerState)} [Assign the Ranger.]
    "Get that lock open," you tell the Ranger. 
    ~SetStateTo(rangerState, busy)
    ->ranger
    
* {CanGiveJob(rogueState)} [Assign the Rogue.]
    "Get that lock open," you tell the Rogue. 
    ~AlterTrust(Rogue, 1)
    ~SetStateTo(rogueState, busy)
    ->rogue
    
* {CanGiveJob(clericState)} [Assign the Cleric.]
    "Get that lock open," you tell the Cleric. 
    ~SetStateTo(clericState, busy)
    ->cleric
    
* {CanGiveJob(scholarState)} [Assign the Scholar.]
    "Get that lock open," you tell the Scholar. 
    ~SetStateTo(scholarState, busy)
    ->scholar

=ranger
{once:
    - "Got it." The Ranger makes her way over to the vine-covered wall. "Locks aren't my specialty, but I'll climb up and see what I can do."
    - In one swift motion, the Ranger grabs hold of the vines and hoists herself to the top of the wall. 
    - From her perch above the mechanism, The Ranger begins smashing the lock with the flat of her axe.
    - With one last strike The Ranger bashes the lock free! 
    ~ SetStateTo(rangerState, available)
    ->finish
}
->->

=rogue
{once:
    - The Rogue grins. "Stand back everybody! And let a master work." He swaggers over to the vine-covered wall.
    - Alternating between the vines and cracks in the stonework, the Rogue deftly makes his way up the wall.
    - The Rogue takes out his thieves tools and twirls them around his fingers for a moment. Then he goes to work, his fingers moving faster than you can follow. Before you know it, the lock slides open.
    ~ SetStateTo(rogueState, available)
    ->finish
}
->->

=cleric
{once:
    - "Ah, v-very well. I'm no lockpick, but perhaps I might be able to bash it open." He pats the silver mace tied to his simple rope belt. You know that The Cleric, though a bit meek in personality, is a surprisingly strong man. "I feel uneasy about those vines however. I will retrieve our climbing gear."
    - The Cleric retrieves the climbing gear from the Scholar's pack.
    - The Cleric climbs up the wall with the climbing gear.
    - The Cleric begins smashing the lock with his mace.
    - With one last whack of his mace, the Cleric breaks the lock!
    ~ SetStateTo(clericState, available)
    ->finish
}
->->

=scholar
{once:
    - "Aha! A test of both mind and body!" the Scholar exclaims. "That lock is as good as open." 
    She begins rummaging through her pack. "Now where did I put that climbing gear?..."
    - The Scholar is still busy grabbing an armful of climbing gear--ropes, pitons, gloves, and the like--from her pack.
    - The Scholar carefully attaches the ropes and pitons, and then steps back to consider the wall. "A good climber knows that plotting the course is half the battle!" she declares to no one in particular. She doesn't seem to be in any hurry.
    - Finally prepared, the Scholar makes her way up the stone wall.
    - The scholar puts a finger to her temple and studies the locking mechanism as if regarding a clever rival in a game of chess. After a moment she retrieves a hairpin and springs into action. With one simple action, the lock slides open.
    ~ SetStateTo(scholarState, available)
    ->finish
}
->->

=finish
->job_021

/*
Job 021: OPEN Doors (for real this time)
*/
=== job_021
=intro
{
    - prologueEvents ? (trapDisarmed): Now that the doors are unlocked and the magic is no longer a threat, you just need someone to open them!
    - not job_011 && not job_012 && not job_010.finish: Now that they are unlocked, You could order someone to open those doors. The magic is still active though, and there's no telling what it could do.
    -else: Now that they are unlocked, You could order someone to open those doors. The magic is still active though, and would likely injure whoever you choose.
}
->assignment
=assignment
* {CanGiveJob(rangerState)} [Tell the Ranger to open the doors.]
    You yell for the Ranger to open the doors.
    ->ranger
    
* {CanGiveJob(rogueState)} [Tell the Rogue to open the doors.]
    You yell for the Rogue to open the doors.
    ->rogue
    
* {CanGiveJob(clericState)} [Tell the Cleric to open the doors.]
    You yell for the Cleric to open the doors.
    ->cleric
    
* {CanGiveJob(scholarState)} [Tell the Scholar to open the doors.]
    You yell for the Scholar to open the doors.
    ->scholar

+ {prologueEvents !? (trapDisarmed)}[Leave the doors alone for now.]
    Knowing the magic is still active, you leave the doors alone for now.
    ->->

=ranger
The Ranger rushes over to the doors and begins pushing them open. <>
{
    - prologueEvents ? (trapDisarmed): Now that they are unlocked this proves to be fairly easy for someone of her strength. Fortunately, the magic is dealt with and no further traps reveal themselves.
    - else: As she pushes, several pools of blue-white energy coalesce on the surface of the door. A jet of white flame shoots straight out from each one, several of them burning the Ranger. She cries out in pain, but keeps pushing. After a few seconds the flames burn out. The Ranger is still standing, but looking quite injured and burned.
        ~Injure(rangerState)
}
->finish

=rogue
The Rogue rushes over to the doors and begins pushing them open.
{
    - prologueEvents ? (trapDisarmed): It takes all of his might, but he manages to start moving them. Fortunately, the magic is dealt with and no further traps reveal themselves.
    - else: As he pushes, several pools of blue-white energy coalesce on the surface of the door. A jet of white flame shoots straight out from each one, several of them burning the Rogue. He cries out in pain, but keeps pushing. After a few seconds the flames burn out. The Rogue is still standing, but looking quite injured and burned.
        ~Injure(rogueState)
}
->finish

=cleric
The Cleric hurries toward the doors and begins pushing them open.
{
    - prologueEvents ? (trapDisarmed): Now that they are unlocked this proves to be fairly easy for someone of his strength. Fortunately, the magic is dealt with and no further traps reveal themselves.
    - else: As he pushes, several pools of blue-white energy coalesce on the surface of the door. A jet of white flame shoots straight out from each one, several of them burning the Cleric. He cries out in pain, but keeps pushing. After a few seconds the flames burn out. The Cleric is still standing, but looking quite injured and burned.
        ~Injure(clericState)
}
-> finish

=scholar
For once, the Scholar does not argue. Instead, she hurries over the doors and begins pushing them open.
{
    - prologueEvents ? (trapDisarmed): It takes all of her might, but she manages to start moving them. Fortunately, the magic is dealt with and no further traps reveal themselves.
    - else: As she pushes, several pools of blue-white energy coalesce on the surface of the door. A jet of white flame shoots straight out from each one, several of them burning the Scholar. She cries out in pain, but keeps pushing. After a few seconds the flames burn out. The Scholar is still standing, but looking quite injured and burned.
        ~Injure(scholarState)
}
-> finish

=finish
->-> finale

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
{once:
    - Your companions begin carrying out your orders. You notice that the sky has gotten much darker since you arrived. The sun must be below the horizon line by now, if you could even see it through the thick jungle around you. You get the vague sensation that something is watching you, waiting for night to fall. ->->
    - By now the darkness of the forest has grown more oppressive. You start to hear growls from the forest all around you, and they seem to be getting closer.
}

Your companions look about uneasily as danger seems to be setting in around you. It might be wise to mount a defense of some kind against the creatures of the jungle while you work on getting inside the vault.
Your companions not busy with other tasks offer their suggestions:
    {
    - CanGiveJob(rangerState): The Ranger cups her ear and listens intently to the sounds from the jungle. "Those sound like jungle cats to me. Large, dangerous predators. But don't worry, I know how to deal with this. Send me out there and I'll lure them away by mimicing their calls."
    }
    {    
    - CanGiveJob(rogueState): The Rogue paces nervously. "Gods I hate animals, I should have stayed in the city! Ok, animals hate fire right? Why don't we gather some wood and start a fire to keep them away?"
    }
    {    
    - CanGiveJob(clericState): The Cleric's eyes go wide as he listens to the predators approach. He pulls out his prayerbook and begins turning its pages quickly. "I sh-should be able to consecrate the ground in this clearing, giving us a c-circle of protection from those creatures. That would p-prevent them from harming us. I think...."
    }
    {   
    - CanGiveJob(scholarState): The Scholar pulls a stack of books from her pack. "Not to worry! I know not what creatures menace us, but surely something in these tomes will help us divert them. Knowledge never fails me!" 
        The Scholar is putting on a brave face, but you can tell she is as nervous as the rest of you underneath.
    }

->assignment
=assignment
Whose plan will you use to hold back the creatures in the jungle?
* {CanGiveJob(rangerState)} [The Ranger will lure them away.]
    "Lure them away," you say, and the Ranger nods.
    ~SetStateTo(rangerState, busy)
    ->ranger
    
* {CanGiveJob(rogueState)} [The Rogue will build a fire.]
    "A fire seems like it should work," you say. "Lets look for kindling."
    ~SetStateTo(rogueState, busy)
    ->rogue
    
* {CanGiveJob(clericState)} [The Cleric will create a magical circle of protection.]
    "A circle of protection sounds wise," you say to the Cleric. "Get started."
    ~SetStateTo(clericState, busy)
    ->cleric
    
* {CanGiveJob(scholarState)} [The Scholar will find a solution in her books.]
    "Let's search these books," you say, and the Scholar begins flipping pages.
    ~SetStateTo(scholarState, busy)
    ->scholar

=ranger
{once:
    - The Ranger disappears into the darkness. A moment later you hear a series of startlingly lifelike animal calls, ranging from birds to cats to creatures you can't even name. The calls get progressively further away and eventually grow quiet. Some moments later, the Ranger reappears at your side. "Hopefully that bought us some time"
    ~ SetStateTo(rangerState, available)
    - It seems that the Ranger's diversion did buy you some time, but now you can hear the creatures approaching agian. They will be upon you soon, and there is no time for another diversion.
    - Suddenly, the creatures that had been lured away jump out of the darkness and into the clearing!
    ->finish
}
->->

=rogue
{once:
    - The Rogue runs about the clearing gathering branches, fallen leaves, anything that looks like it will burn. He throws it all into a big pile at the edge of the darkness, grabs a tinderbox from his pack, and lights it all up. Soon a blaze is burning brightly. Beyond the light of the fire, you see two bright pairs of eyes--but then you seem them quickly retreat. It seems the Rogue's fire did scare off the creatures!
    ~ SetStateTo(rogueState, available)
    ~ prologueEvents += creaturesScared
    ~ prologueEvents += fireSet
    - The creatures were scared away, but you realize now that you have a new problem: the fire the Rogue constructed is burning out of control. You urge everyone away from the blaze.
    {
            - CanGiveJob(clericState): However the Cleric doesn't get away quite quickly enough, and the flames travel up to the fraying edges of his robes. His robes light on fire briefly before he is able to stamp them out with your assistance. He is alive and well, but with burns up his right leg.
            ~Injure(clericState)
        
            - CanGiveJob(scholarState): However, the Scholar is distracted when she sees the fire moving towards a pile of her books. She runs over to them as they burst into flame. The Rogue pulls her back as quick as he can, but not before the Scholar severely burns her hands trying in vain to save her books.
            ~Injure(scholarState)
            
            - CanGiveJob(rangerState): The Ranger tries bravely to contain the blaze. As she attempts to beat the fire down with her cloak, it flares for a moment and catches fire to her right arm. She dives into a roll immediately and manages to put it out, but when she stands you can see scorch marks lingering along her whole arm.
            ~Injure(rangerState)
    }
    - The fire has grown completely out of control and nearly filled the clearing. Your group is now pressed up very close to the doors to stay out of the flames. The rogue, looking terrified and guilty, is looking frantically through the group's supplies for something, anything that could fight the fire. The fire flares and catches fire to his cloak. You pull him away and fortunately extinguish his clothing before he is completely consumed, but he will be feeling those burns for a while.
    ~ Injure(rogueState)
    
}
->->

=cleric
{once:
    - The Cleric starts pacing a careful arc along the edge of the clearing. He reads aloud an incantation from his book while dropping a trail of what looks to be fine golden sand from a small pouch at his belt. When it hits ground, the sand combines to form the base of a glowing golden barrier. Soon enough he has traced the entire perimeter of the clearing. Just in time too; you can see two pairs of hungry feline eyes pearing out from the darkness beyond the barrier. But, at least for now, they aren't coming any closer.
    ~ SetStateTo(clericState, available)
    - Unfortunately, the Cleric's consecrated barrier was made hastily, and soon holes start to form in the perimeter. It isn't long before the creatures that have been stalking you find an opening and leap into the clearing!
    ->finish
}
->->

=scholar
{once:
    - You watch anxiously as the Scholar shuffles through her papers. Maybe books aren't the best defense against wild animals after all, because before she can find anything, the jungle cats that have been creeping toward you burst into the clearing!
    ~ SetStateTo(scholarState, available)
    ->finish
}
->->

=finish
~prologueEvents += creaturesArrived
Two hungry leopards stand before you, and they look ready to kill.
->->

/*
Job 031: CONFRONT Animals
*/
=== job_031
{
    - job_031.finish: ->->
    - prologueEvents ? (creaturesKilled) || prologueEvents ? (creaturesScared): ->->
    - job_031.ranger: ->ranger
    - job_031.rogue: ->rogue
    - job_031.cleric: ->cleric
    - job_031.scholar: ->scholar
    - else: ->intro
}
=intro
Despite your efforts, two large leopards now stand before your group in the jungle clearing. They look hungry and ready to strike!
->assignment
=assignment
Who will lead the fight against the jungle cats?
* {CanGiveJob(rangerState)} [Assign the Ranger.]
    "Hold them off!" you yell to the Ranger.
    ~SetStateTo(rangerState, busy)
    ->ranger
    
* {CanGiveJob(rogueState)} [Assign the Rogue.]
    "Hold them off!" you yell to the Rogue.
    ~SetStateTo(rogueState, busy)
    ->rogue
    
* {CanGiveJob(clericState)} [Assign the Cleric.]
    "Hold them off!" you yell to the Cleric.
    ~SetStateTo(clericState, busy)
    ->cleric
    
* {CanGiveJob(scholarState)} [Assign the Scholar.]
    "Hold them off!" you yell to the Scholar.
    ~SetStateTo(scholarState, busy)
    ->scholar

=ranger
Quicker than you can see the Ragner draws her bow and puts an arrow between the eyes  of the first leopard. Just as quickly however, the second one pounces on her. In the scuffle the Ranger manages to retrieve her handaxe and slay the seond leopard as well, but not before it leaves a nasty claw mark across her torso.
~Injure(rangerState)
->finish

=rogue
"Did I mention I really hate animals?" The rogue grimly draws his daggers. There is a tense moment as the leopards slowly approach. Suddenly the Rogue springs into action, flicking his wrist, he sends a dagger hurtling through the air and into the first leopard's eye. One down. But then the other one is upon him, leaping up and biting into the Rogue's shoulder. He screams, but with his other hand manages to stab into the attacking leopard's belly. It falls to the ground, dead. The Rogue is alive, but clutching at the bite marks in his shoulder.
~ Injure(rogueState)
->finish

=cleric
The Cleric's eyes go wide, but he draws his silver mace and prepares to fight. The leopards approach, but with one heavy swing he manages to bring down the first. As he does so the other cat circles around him and leaps from behind, leaving a nasty claw mark across his back. The Cleric whirls around and takes out the second leopard with a spinning strike, but then falls to one knee in pain. You help him up. He will live, but will be feeling that injury for a while.
~ Injure(clericState)
->finish

=scholar
The Scholar has more tricks up her sleeve than you might have guessed. She pulls a scroll from her pack and begins reading from it. As she finishes, one of the leopards claws at her and injures her arm, but then a forked bolt of lightning shoots out from the scroll and strikes both creatures dead!
~ Injure(scholarState)
->finish

=finish
The party isn't unscathed, but the danger is dealt with for now.
~prologueEvents += creaturesKilled
->->


=== finale
* [Continue]
With one last push, the doors are finally open.
{
    - prologueEvents !? (creaturesArrived) && prologueEvents !? (creaturesKilled) && prologueEvents !? (creaturesScared): Knowing there is still danger approaching from the forest, you hurridely usher everyone inside. Working together, you close the heavy doors behind you.
    - prologueEvents ? (creaturesArrived) && prologueEvents !? (creaturesKilled) && prologueEvents !? (creaturesScared): "Inside, quickly!" you shout as the hungry leopards pin your group closer and closer to the wall. You dart inside one after another. <>
    { 
        - IsInjured(rangerState) && IsInjured(clericState): You attempt to close the doors before the beasts can follow you in. However, with the ranger and the cleric injued your group is not at full strength, and the leopards get one last swipe in--at you--before the doors close. You stumble back in the darkness cluthcing at your left leg, which is now bleeding where the leopard clawed you. Your companions immediately start to bandage you up. You'll live, but you'll also have trouble with that leg for a while.
            ~ player_injured = true
        - IsInjured(rangerState): You attempt to close the doors before the beasts can follow you in. However, with the ranger injued your group is not at full strength, and the leopards get one last swipe in--at you--before the doors close. You stumble back in the darkness cluthcing at your left leg, which is now bleeding where the leopard clawed you. Your companions immediately start to bandage you up. You'll live, but you'll also have trouble with that leg for a while.
            ~ player_injured = true
        - IsInjured(clericState): You attempt to close the doors before the beasts can follow you in. However, with the cleric injued your group is not at full strength, and the leopards get one last swipe in--at you--before the doors close. You stumble back in the darkness cluthcing at your left leg, which is now bleeding where the leopard clawed you. Your companions immediately start to bandage you up. You'll live, but you'll also have trouble with that leg for a while.
            ~ player_injured = true
        - else: Working together, you manage to slam the heavy doors shut just before the creatures can follow you in!
    }
    - prologueEvents ? (fireSet): The fire is now completely consuming the clearing, and you all rush inside to escape it. Shoving the doors closed with all your might, you manage to keep the fire outside.
    - else: With all outside dangers averted for now, your group unhurridely makes their way inside. Working together, you close the heavy doors behind you.
}
You've made it inside, but you are sure far more challenges await you within the vault.
** [Finish.]->results

===results
RESULTS: 

VAR scholar_disarmed_trap = false


{ job_012.finish:  
    You trusted the Scholar to figure out a use for the magical trap.
    ~scholar_disarmed_trap = true
}
{ job_011.finish:  
    You disarmed the trap rather than allow the scholar to continue studying it.
    ~scholar_disarmed_trap = false
}
{ job_011.rogue: You ordered the rogue to deal with the magic despite his wishes. }
{ prologueEvents !? (creaturesArrived) && prologueEvents !? (fireSet):  You made it inside before any dangerous jungle creatures attacked you.}
{ prologueEvents ? (creaturesArrived) && prologueEvents !? (creaturesKilled): You escaped the leopards in the nick of time. }
{ prologueEvents ? (creaturesKilled): You fought off or scared away the dangerous creatures in the jungle. }
{ prologueEvents ? (fireSet): The Rogue built a fire that started burning out of control.}
{ IsInjured(rangerState): The Ranger became injured. }
{ IsInjured(rogueState): The Rogue became injured. }
{ IsInjured(clericState): The Cleric became injured. }
{ IsInjured(scholarState): The Scholar became injured. }
{ player_injured: You became injured. }

You and your companions made it into the vault.

*[Next Scene.]->SETUP_ACT1

/****** ACT 1: The Scholar ******

*******/
=== SKIP_TO_ACT_1
Pick a Save State to start Act 1 with:
+ [Default Save State]
    {EnterSaveState(111, true)}
+ [Ideal Save State]
    {EnterSaveState(101, true)}
+ [Bad Save State (1 Injury)]
    {EnterSaveState(121, true)}
+ [Worst Save State (2 Injruies)]
    {EnterSaveState(131, true)}

- ->SETUP_ACT1
///ACT 1 Variables
VAR playerSympatheticToCleric = true
LIST act1Events = oneBlankTile, allBlankTiles, tilesEmpowered, tookEmpoweredTiles
LIST act1Hints = rangerHint, rogueHint, clericHint, scholarHint
///ACT 1 Scenes
===SETUP_ACT1

->intro_act1

===intro_act1
You made it inside. You are in a small, dimly lit room with stone walls. Directly across from you is a dark passageway flanked by two imposing statues.
->companion_reactions


===companion_reactions
* However, [before investigating further...] before  <>
// check injuries first
{InjuryCount() > 0:
    investigating further, you look back at your injured <>
    {
        - InjuryCount() > 1: companions <>
        - else: companion <>
    }
    and realize you have more pressing concerns.
    ->injuries
}
//check for scholar being mad
{prologueEvents !? (trustedScholar):
    you have a chance to investigate, the Scholar grabs you by the shoulder and whirls you around. She looks furious.
    ->scholar_argument
}
//check for fire argument
{prologueEvents ? (fireSet):
    you have a chance to investigate, you hear an argument break out behind you.
    ->fire_argument
}


//If made it this far, ranger complements you instead
you have a chance to investigate, one of your companions claps you on the back. It is the Ranger, and as you turn toward her you notice she is smiling.
"Just wanted to say, good work so far." She continues, "A lot could have gone wrong out there, but you made sure nothing did. In fact things went about as well as they possibly could have."
** "Thank you!"
    ~AlterTrust(Ranger, 2)
    She nods. "Of course it will likely get more difficult from here. But we're off to a good start."
** "Keep your guard up anyway[."]," you tell her. "There's a lot more that could still go wrong."
    ~AlterTrust(Ranger, 2)
    "Of course" she replies matter-of-factly. "I always do." 
** "I just hope our luck holds[."]," you reply.
    ~AlterTrust(Ranger, 1)
    "Oh luck had nothing to do with it," the Ranger says matter-of-factly. "Don't discount your own decision-making."
    
- "Keep it up, and we'll have claimed the artifact in no time." And with a curt nod, the Ranger goes back to check on the others. She seems to be viewing you with a newfound respect!
->antechamber

=injuries
//Injuries
{IsInjured(rangerState): The Ranger is injured, clutching at her side. She says she'll walk it off, but you can tell she's hurting.}
{IsInjured(rogueState): The Rogue is injured, and is making sure everyone knows it. He is definitely hurt, but not quite as badly as he is making it seem.}
{IsInjured(clericState): The Cleric is injured, and you see him grimace as he searches his pack for the healing kit.}
{IsInjured(scholarState): You hear a cry of pain and a clatter of books, and then you see the Scholar clutching at her injured arm. She curses and then carefully bends down to lift her books with her good arm this time.}

The Cleric approaches you with the healing kit. He says, "I have healing magic as well of course," he says somewhat reassuringly. " But even so, it is always b-best to start by tending to their wounds conventionally."
->healing_decision
=healing_decision
* "Go ahead."
    The Cleric nods and sets to work binding wounds.
* "Let me help[."]," you say, grabbing some bandages from the kit.
    ~AlterTrust(Cleric, 2)
    "Oh, Excellent!" The Cleric's face brightens, and you both set to work. 
You join the Cleric in tending wounds, and your injured companions look grateful.
    {IsInjured(rangerState): 
        ~AlterTrust(Ranger, 1)
    }
    {IsInjured(rogueState):
        ~AlterTrust(Ranger, 1)
    }
    {IsInjured(scholarState): 
        ~AlterTrust(Scholar, 1)
    }
* ["Healing magic?"] "How does your healing magic work exactly?" you ask.
    "I-I will explain once this is done," the Cleric says apologetically. "Bandages first." ->healing_decision
    
- Once finished, everyone seems to be in slightly brigther spirits than they were.
    
//check for scholar being mad
{
- prologueEvents !? (trustedScholar):
    Everyone except the Scholar that is, <>
    {
        -IsInjured(scholarState): who seems to have remembered that she is quite angry with you now that her pain is lessened. <>
        - else: who seems to have been waiting for an opportune moment to confront you. <>
    }
    She grabs you by the shoulder and whirls you around. She looks furious.
    ->scholar_argument
//check for fire argument
- prologueEvents ? (fireSet):
    But seemingly as soon as you've turned your back, you hear voices arguing. You turn back around to see the Ranger confronting the Rogue.
    ->fire_argument
-else: ->antechamber
}

=scholar_argument
She points her finger right in your face. "I demand to know if you will actually allow me to do the job I am here to do!"
* "Of course I will[."]," you reply, which seems to cool her down a bit.
    ~AlterTrust(Scholar, 1)
    "I hope that is true," she says, no longer shouting. "Claiming the artifact at the center of this vault is going to mean navigating quite a bit more magic than what we encountered outside. And quite frankly, I am the only one here with the intelligence to see us through."
* "Watch your tone."
    ~AlterTrust(Scholar, -2)
    Her face grows red. "I am surrounded by imbeciles!" she shouts. "I am the only hope any of you have of reaching the center of this vault and claiming the artifact!"
* "Is this about the magic outside?"
    She seems to get even angrier. "What ELSE would it be about?"
    She collects herself after this outburst. Then, with icy calm, "I am here to study magic. Without my knowledge we have no hope of claiming the artifact at the center of this vault. Yet at the first opportunity you undermine me. So I ask again, will you let me do my job the next time we encounter magic?"
    * * "Yes[."]," you assure her. "You have my word."
        ~AlterTrust(Scholar, 1)
        She nods. "See that you do."
    * * "Only if we're sure its safe."
        ~AlterTrust(Scholar, -1)
        "New discoveries cannot be made without risk. Remember that."
    * * "Don't question me."
        ~AlterTrust(Scholar, -2)
        She laughs bitterly. "It is amusing you think you can tell me what to do."

    - - 
- And with that she walks briskly past you toward the statues.//GATHER POINT- check for fire argument
    {
        -prologueEvents ? (fireSet):
        Just then, you hear the Ranger and the Rogue explode into an argument of their own.
        *[Continue.]->fire_argument
        -else: ->antechamber
    }

=fire_argument
TODO: Fire Argument
The Ranger and the Rogue are arguing about the fire the Rogue set outside. 
* [Listen in.]
    The Ranger is angry that the Rogue was so reckless, rightly pointing out that the fire immediately spun out of control and is still burning wildly on the other side of the door.
    
    The Rogue is arguing that he's the one who took the initiative to save the group from the leopards.
    "Anyone who thinks they can do better is welcome to try!" he shouts back.
    * * [Side with the Ranger.] You step beside the Ranger and make it clear you agree. The Rogue was too reckless.
        ~ AlterTrust(Ranger, 2)
        ~ AlterTrust(Rogue, -2)
        "I was following your orders!" the rogue fires back at you, but then he seems to concede defeat. He steps away, muttering "I knew this job was a bad idea."
    * * [Side with the Rogue.] You step beside the Rogue and come to his defense.
        ~AlterTrust(Ranger, -2)
        ~AlterTrust(Rogue, 2)
        The Ranger makes it clear she is now much more worried about your decision making, and the group's chances of success.
    * * [Try to mediate.] You step between them, creating a moment of calm. You remind them that everyone is on the same side here, and you all need to work together to get the artifact you are searching for.
        ~AlterTrust(Ranger, 1)
        ~AlterTrust(Rogue, 1)
    - - ->antechamber
* [Ignore them.]
    You decide to let them handle their business themselves, and go back to inspecting the room.
    -> antechamber



=scholar_approach

->antechamber

===antechamber
* [Continue.]
With any distractions handled for the moment, you take a closer look around.
You are in a 10-foot square room with walls of cool blue stone. The ceiling, about 20 feet above you, is a metal grate which lets in the fading grey light from the sky above.
The rest of the vault--and hopefully, the artifact you have been sent to find--lie somewhere through the dark passageway cut into the wall across from you.
**[Continue.]->statues

===statues
TODO: Hint about Rogue backstory?
//Scholar approaches statues
You turn your attention from that passageway to the the statues that stand on either side of it, and you notice that the scholar has already begun to examine them closely. She is alternating between a sketchbook and a notebook, drawing the statues from all angles and jotting down notes. She seems positively abuzz with excitement.
{prologueEvents !? (trustedScholar): Fortunately, in the excitement, she seems to have forgotten her anger for now.}
The Rogue walks up to join her, and they discuss the statues. In particular they are both curious about the large metal bowls being held in the outstretched arms of each statue. The Scholar thinks they might be braziers of some kind, while the Rogue wonders if they hold treasure.
However, the statues are holding the bowls about 7 feet off the ground, too high to be able to look inside them. The Scholar and the Rogue make a plan to climb the statues to get a better look, and the Rogue gets into position to boost the Scholar up.
Seeing this, you say...
* "You two, leave those statues alone."
    ~AlterTrust(Scholar, -2)
    ~AlterTrust(Rogue, -1)
    {
        - prologueEvents ? (trustedScholar): The Scholar seems surprised at you, but <>
        - else: The Scholar scoffs. "Why did I expect anything different from you?" But <>
    }
    she listens to you and goes back to taking notes and observing.
    The Rogue says, "Well I guess they could be trapped anyway, better safe than sorry," but you can tell he is disappointed as well.
    ->our_mission
* (go_ahead)"Go ahead."
    ~AlterTrust(Scholar, 1)
    ~AlterTrust(Rogue, 1)
    The Rogue boosts the Scholar up onto the first statue, and then deftly climbs up the second one on his own. 
    The Scholar finds a perch on the shoulder of her statue, and peers down into the bowl it is holding. She excalims, "Now this is interesting!"
    "The inside of these bowls is mirrored," she continues. " It appears they are designed to reflect moonlight when it enters the room through the skylight."
    The Rogue chimes in from his statue. "There's some shiny things scattered at the bottom of this bowl, think they're valuable?"
    ->tile_choice->
    ->our_mission
* "Let me join you."
    ~AlterTrust(Scholar, 2)
    ~AlterTrust(Rogue, 1)
    {
        - prologueEvents ? (trustedScholar): "Of course!" the Scholar beams at you. "Here, I'll help you up first."
        - else: "Oh really?" the Scholar replies with some doubt. She turns to the Rogue and tells him, "why don't we let our brilliant leader go first then?"
    }
    The Rogue and the Scholar move next to the first statue, and lift you up high enough that you can grab onto its arm. As you pull yourself up into a sitting position, your two companions make their way up the other statue.
    From your new vantage point you can see that the interior surface of the bowl is lined with metal. Upon closer inspection, you realize it is polished enough to be a mirror. In fact even though the light is dim, you can see a warped reflection of the skylight above. The bowl is empty except for a few rectangular objects strewn across the bottom. They appear to be stone tiles of some kind.
    "Aha!" you hear the Scholar call from her perch on the other statue. "Now this is interesting."
    She turns to you. "Tell me, what do you think the purpose of these bowls is?"
    * * "They are braziers, to light the room."
        The Scholar shakes her head. "Not quite. They aren't for producing light, they're for collecting light."
    * * "They collect water, from the open roof."
        "Not quite. They don't collect water, they collect light." 
    * * "They reflect light from above."
        ~AlterTrust(Scholar, 2)
        "Correct!" She says, impressed.
    * * "Why don't you just tell me?"
        {
            -prologueEvents ? (trustedScholar): 
                ~AlterTrust(Scholar, 1)
                "Oh you're no fun," she teases. <>
            -else: 
                ~AlterTrust(Scholar, -1)
                "Typical," she sighs. <>
        }
        "Well, they reflect light, which is why this room has a skylight."
    - - She continues. "Specifically, they reflect moonlight, and they are curved in such a way that the moonlight is all directed into the center of the bowl."
        "Where these shiny things are!" observes the Rogue. "Think they're valuable?"
        ->tile_choice->
        {
            //They both help you down
            -prologueEvents ? (trustedScholar) && GetTrustThreshold(rogueTrust) != LOW:
            Once they're on the ground, the Rogue and the Scholar both walk over and help you down from your statue.
            TODO: Romance (Scholar x Rogue) hints?
            //The Rogue helps you down
            -GetTrustThreshold(rogueTrust) != LOW:
            Now the rogue walks over to you and puts out a hand.
            "Your turn, boss." He helps you down off the statue before going to rejoin the Scholar.
            //The Scholar helps you down
            -prologueEvents ? (trustedScholar) && GetTrustThreshold(scholarTrust) != LOW:
            After helping the Scholar down, the Rogue pointedly turns away from your statue and walks off. However, the Scholar walks over and help you climb down to the ground.
            "Come on," she says smiling. "I'm sure we have a lot more knowledge to uncover here."
            //No one helps you down :(
            -else:
            Now that they are on the ground, the Scholar and the Rogue seem to have completely forgotten you. As they walk away chatting, you carefully lower yourself from your statue.
        }
        ->our_mission
    //* [nothing.]->go_ahead
        
=tile_choice
"Indeed!" the Scholar replies. "These tiles are made of a type of ceramic that can hold magical enchantments. It seems likely that their magic is powered by moonlight, and they are placed in these bowls to recharge."
The Rogue suddenly looks wary. "What kind of magic are we talking? The 'blow up in your face' kind? Or the 'make me fabulously wealthy' kind?"
The Scholar laughs. "Maybe both, maybe neither." She crosses her arms. "But we won't know unless you go get some for me to study, now will we?" The Scholar arches an eyebrow in challenge. She seems to be teasing him.
"Hmm, well when you put it like that..." The Rogue thinks for a moment, and then lifts himself over the edge of the bowl, intent on gethering some of the tiles.
Seeing this, you tell him...
    * "Take as many as you can."
        ~AlterTrust(Rogue, 3)
        ~AlterTrust(Scholar, 1)
        "Music to my ears!" you hear the Rogue reply, his voice echoing strangely from inside the metal bowl. He starts gathering tiles.
        The Scholar, meanwhile, seems to be reconsidering. "Hopefully they don't actually need to remain in these bowls for some purpose..." Her voice trails off.
        "What was that?" the Rogue asks.
        "On second thought just take one tile!" The Scholar calls back.
        "Oh fine," the Rogue groans. He reappears a moment later. "Got one," he says, holding up his backpack.
        ~act1Events += (oneBlankTile)
    * "Just take one."
        ~AlterTrust(Rogue, 1)
        ~AlterTrust(Scholar, 2)
        "Fair enough," you hear the Rogue reply. "I guess that would be less likely to blow up in my face." His voice is echoing strangely from inside the bowl.
        "Indeed," replies the Scholar. "Besides, seeing as they are not currently empowered, I should be able to glean as much from one tile as I could from having all of them."
        "Alright, got it!" You see the Rogue reappear over the edge of the bowl, tile in hand. He puts it in his pack.
        ~act1Events += (oneBlankTile)
    * "Don't take any."
        ~AlterTrust(Scholar, -1)
        [DEBUG INFO:
        Rogue Trust Check: Listen or disobey?
        Required Trust: HIGH; 
        Current Trust: {GetTrustThreshold(rogueTrust)}
        Trust Check {GetTrustThreshold(rogueTrust) == HIGH: SUCCESSFUL | FAILED}
        DEBUG END]
        {
            - GetTrustThreshold(rogueTrust) == HIGH:
                "You know, ordinarily I'm annoyed when people tell me not to take things." He reappears over the edge of the bowl. "But you I like. I trust your judgement."
            /*
            - GetTrustThreshold(rogueTrust) == MED:
                ~AlterTrust(Rogue, -1)
                The Rogue reappears over the edge of the bowl. "You couldn't have told me that before I climbed in here? Whatever, fine. It was probably going to kill me anyway."
            */
            - else:
                ~AlterTrust(Rogue, -2)
                 
                "Huh, that's an idea," the Rogue replies, his voice echoing strangely from inside the bowl. "But I have a couterproposal: Stop telling me what to do." He reappears over the edge of the bowl with a tile in hand, smiling smugly at you.
                ~act1Events += (oneBlankTile)
        }
    - Then in one quick motion, the Rogue lifts himself over the edge of the bowl and drops to the ground, landing in a roll. He then offers his hand to help the Scholar climb down.
    ->->

===our_mission
*[Continue.]->bump
=bump
Meanwhile, you notice that the Ranger and the Cleric have begun unpacking supplies. However, at the moment they are in conversation about your group's mission.
//Talk about camp
"Do you think we'll be s-safe here? the Cleric asks the Ranger.
"Definitely," she replies. "Those doors are sealed tight, and there is only one other entrance. As long as we keep our normal watch we should be fine."
"Plus," she continues, "that grate in the ceiling means we can have a fire, so we should be nice and comfortable for one more night at least."
"Oh excellent! One more night of light before we fully head into the d-dark." He pauses. " I know the artifact we seek is important," he says softly, "but I must admit I am quite f-frightened of what we might face on the way to finding it."
"I'm worried too," the Ranger replies, "but a lot of people are depending on us. The city won't last much longer under seige," she continues grimly. "This artifact is supposed to be the only thing that can turn the tide for us."
"As long as we s-survive to use it."
They notice you listening in, and the Ranger addresses you. "Well boss, how are you feeling about all this?"
* "We'll make it through this together[."]," you say reassuringly. 
    ~AlterTrust(Ranger, 1)
    ~AlterTrust(Cleric, 2)
    "That's the idea," the Ranger replies.
    "Yes I suppose that's why we were each ch-chosen for this team!" The Cleric seems to have regained some of his courage. 
    "Yes, we have to rely on one another!" you continue. <>
* "I'm focused on what we are fighting for[."]," you say. <>
* "There's no room for fear[."]," you say bluntly.
    ~AlterTrust(Ranger, -1)
    ~AlterTrust(Cleric, -2)
    "Sometimes fear has a way of keeping you alive," the Ranger sighs, "but I see your point."
    The Cleric's eyes go wide, but he says nothing.
    ~playerSympatheticToCleric = false
    "We have to face the facts," you continue. <>
* "It doesn't matter how I feel[."]," you say. <>    

//Talk about mission
- "Without this artifact our home could be destroyed."
    "That's what they tell us," the Ranger replies.
    "I p-pray that they are wrong. Do we even know for sure what this artifact is? What it d-does?"
* "It will shield the city."
    ~AlterTrust(Ranger, -1)
    ~AlterTrust(Cleric, 1)
    "I suppose that doesn't s-sound so bad," the Cleric replies.
    "But all that will do is delay," the Ranger says. "Any shield can be broken through eventually. And trust me," she says intently, "those monsters will never stop attacking."
* "It will destroy the invaders."
    ~AlterTrust(Ranger, 2)
    ~AlterTrust(Cleric, -2)
    "Good," the Ranger says decisively. "The direct solution is best."
    "But anything with that much destructive p-potential could easily be misused, or misfired. What if this artifact destroys the invaders AND our home?"
    "That might be a risk we have to take. Those monsters are relentless." The Ranger looks grim for a moment, as if lost in a painful memory.
* "It will force a truce."
    ~AlterTrust(Ranger, -2)
    ~AlterTrust(Cleric, 2)
    "Oh!" The Cleric's face brightens. "Wh-what a wonderful turn that would be. No more v-violence."
    "All those monsters know is violence." The Ranger laughs bitterly. "I'll believe it when I see it."
* "We don't know what it will do."
    ~AlterTrust(Cleric, -1)
    ~AlterTrust(Ranger, 1)
    "Th-that's what I was afraid of." 
    "I was hoping the Council gave you more info to go on than the rest of us," the Ranger sighs. "But I appreciate your honesty. I just hope whatever it is we find will deal with those monsters once and for all."
    

- The Ranger continues. "But I suppose we don't have to worry about that until tomorrow at least." She grabs one of the bedrolls and hands it to you. "Here, help us finish setting up camp."
*[Continue.]->rest_act1


===rest_act1
TODO: From here all text is placeholder
[DEBUG: All text from this point on is placeholder]
//Explain resting
The Cleric explains that he has healing magic that can treat almost any injury, but it takes at least one full night of rest to work. 
{
    -InjuryCount() > 0: Because you have injured companions, he gets to work preparing his spell.
    -else: Though your group doesn't need any healing right now, it will likely be useful in the future.
}
*[Continue.]->argument
=argument
//Scholar argues back
The Scholar joins you, sees you are setting up camp, and gets angry. She asssumed you were continuing immediately into the vault, and is indiginent about being asked to wait for an entire night "on the precipice of discovery." ->rest_argument
=rest_argument
* {!IsInjured(scholarState) && InjuryCount() > 0} [Point out that you have injured party members]
    "They knew the risks. We can't afford to stop."
    ->rest_argument
* {IsInjured(scholarState)} [Point out that she is injured]
    "Do you really think I would let something so trivial stop me now?"
    ->rest_argument
* [Agree with her]
    {InjuryCount() > 0: The Cleric, with surprising ferocity, argues strongly against moving forward without rest. He explains that his healing magic can cure all injuries given enough time, but that it will not work without a full night of rest.}
    The Ranger argues that the party is tired from a full day of travel, and that pushing ahead past exhaustion will only get you all into trouble.
    ->rest_argument
* [Rest for the night]
You make it clear that any further exploration will have to wait for tomorrow; the party must rest for tonight.
//Scholar foreshadowing
[Scholar Trust Check: {GetTrustThreshold(scholarTrust)}]
{
    //High Trust
    -GetTrustThreshold(scholarTrust) == HIGH: After a moment of thought, the Scholar accepts your judgement. It goes against her instincts and desires, but she truly trusts your leadership.
    //Med Trust, helped outside
    -GetTrustThreshold(scholarTrust) == MED && prologueEvents ? (trustedScholar): The Scholar disagrees, but mentions that since you trusted her outside, she will go along with your judgement for now.
    //Med Trust, didn't help outside
    -GetTrustThreshold(scholarTrust) == MED && prologueEvents !? (trustedScholar): The Scholar reminds you how you already didn't trust her outside, and that this is beginning to form a worrying pattern of obstruction.
    //Low trust
    -else: The Scholar is furious with this decision, and makes it clear that she thinks of you as an obstacle to overcome.
}

->conversations_act1

//Extra chance to change trust levels
//Player can get reward of early information from companions at HIGH trust
===conversations_act1
Regardless of the Scholar's feelings, the rest of your party works to finish setting up camp. This might be a good time to talk to some of your companions one on one.
->choice
=choice
TODO: What topics for each conversation? How many?
Who do you approach?
 * [Talk to the Ranger.]
    You approach the Ranger, who is tending to the campfire. <>
    {IsInjured(rangerState): You notice she is still clutching at her wound every now and then. <>}
    ->ranger
 * [Talk to the Rogue.]->rogue
 You approach the Rogue, who is lying on his bedroll and idly shuffling a deck of cards.
 * [Talk to the Cleric.]->cleric
 You approach the Cleric, who is reading from his prayerbook by the firelight.
 * [Talk to the Scholar.]->scholar
//Intro within scholar section, changes based on trust
 TODO: Figure out fallback choices
 * {CHOICE_COUNT() == 0} ->night_1
 * {CHOICE_COUNT() < 4} [No one else.]->night_1
=ranger
    * {IsInjured(rangerState)} You ask her about her injury.
    She says she is fine, and that the Cleric's healing has been more than enough already.
        * * "Good to hear"
        * * "Are you sure?"
            ~AlterTrust(Ranger, -1)
            "I've had far worse than this."
    * [Ask about the "monsters."] You ask about why she called the invaders "monsters." 
        As she discusses her experience as a scout for the army, you realize this fight is personal to her. She lost someone very close to her in the fighting.
        * * [Press for more details]
            WIP: A trust check here. At LOW the Ranger refuses to speak more, but at HIGH/MED you can start helping her through her grief.
        * *[Talk about something else]
    //* {act1Hints ? (rangerHint)} [Who was it that you lost?]
        //Trust check
    * [That's all for now.]->choice
    - ->ranger
=rogue
The Rogue sits up as you approach and holds out his deck of cards. He asks if you know a game called "Snake Pit."
    * "No, I don't," you say.
    The Rogue winks. "That's because I invented it."
    * "Yes, I do," you lie.
    "Oh really!" The Rogue smirks. "I would have actually believed you if this weren't a game I invented."
    - "Here, I'll explain the rules and deal you in. It's very quick, and not that complicated."
    After hearing the rules--which have something to do with "capturing" your opponent's cards with higher value cards of your own--you aren't sure that you agree with "not complicated." But it does sound quick, taking only a few minutes per hand. As the Rogue lays out a grid of face-down cards to prepare the game, you decide to...
    * focus on asking the rogue questions.
    Accepting that you are probably going to lose anyway, you focus your attention on asking the rogue questions about his personal life.
    [Rogue Trust Check: {GetTrustThreshold(rogueTrust)}]
    {
        -GetTrustThreshold(rogueTrust) == HIGH: You've built up a lot of tust with the Rogue, and so he is surprisingly forthcoming--he tells you a lot about his life living as an exile on the outskirts of the city, surviving by stealing from the inner city and running cons on travellers. When you ask why he was exiled in the first place, he leans in conspiratorially. "Why don't you ask him?" he says, pointing over at the Cleric for emphasis. You try to inquire further, but as much as he trusts you, this is as much as the Rogue will say for now.
            ~Reach(WHY_NOT_ASK_HIM)
        -GetTrustThreshold(rogueTrust) == MED: The Rogue seems bored by your quesioning, but plays along while he easily defeats you at cards. You learn he lives in the outskirts of the city, stealing and running cons to get by. He dodges any more personal questions, but toward the end of the game, he leans in and lowers his voice to a whisper. "Between you and me," he says, "I wouldn't trust everyone in this little group of ours." You try to ask what he means by this, but he won't say more.
        -else: But despite all your efforts, the Rogue is a totally closed book. At the end of the game, all you've learned is that he doesn't seem to trust you very much.
    }
    "Oh, but thanks for playing," he smirks. "I do love an easy win."
    ~AlterTrust(Rogue, 1)
    * focus on playing the game.
    The Rogue's rules explanation makes more sense as you start to play, and you begin to develop a strong strategy for when to attack and when to defend. It isn't enough to beat the Rogue--he did invent the game, after all--but he seems legitimately impressed by your efforts.
    ~AlterTrust(Rogue, 2)
    * find a way to cheat.
    Figuring you need to even the odds if you're going to compete against the inventor of this game, you take the first opportunity hide some cards up your sleeve. By carefully deploying them, you end up winning the game! The Rogue figures out how you did it and is very impressed, saying that "cheating is at the heart of every good strategy."
    ~AlterTrust (Rogue, 3)
    * excuse yourself and walk away.
    ~AlterTrust(Rogue, -2)
    The Rogue laughs it off, but you can tell he's disappointed.
    - ->choice
=rogue_advanced
    The Rogue sits up as you approach and holds out his deck of cards. He asks if you know a game called "Snake Pit."
    * "No, I don't," you say.
    The Rogue winks. "That's because I invented it."
    * "Yes, I do," you lie.
    ~AlterTrust(Rogue, 1)
    "Oh really!" The Rogue smirks. "I would have actually believed you if this weren't a game I invented."
    - "Here, I'll explain the rules and deal you in. It's very quick, and not that complicated."
    After hearing the rules--which have something to do with "capturing" your opponent's cards with higher value cards of your own--you aren't sure that you agree with "not complicated." But it does sound quick, taking only a few minutes per hand. ->snake_pit
VAR hands_played = 0
=snake_pit
~hands_played++
{ once:
    - As the Rogue lays out a grid of face-down cards to prepare the game, you decide to...
        ~temp first_turn = true
    - You are partway through the game and you can tell <>
        {
            - cheated: that you are winning!
            - strategy: that you are evenly matched.
            - else: you have no idea what you are doing.
        }
        <> Seeing this, you decide to...
    - 
    The game is nearly over now, and you can tell <>
    {
        - cheated && strategy: that you are going to win!
        - cheated: That you are still doing quite well.
        - strategy: that despite your best efforts, the Rogue has pulled ahead somehow. 
        - else: 
            that you are absolutely going to lose.
             ~temp final_turn_losing = true
    }
    - ->conclusion
    
}
    + focus on asking the Rogue questions.
        * * Question 1
        * * Question 2
        * * Question 3
    * (strategy) {snake_pit < 3 || cheated}  focus on playing the game strategically.
        Now that you are playing, the Rogue's rules explanation makes a bit more sense. You start to devise a general strategy for when to attack and when to defend, and it seems to be working alright.
    * (cheated) {snake_pit < 3 || strategy} focus on finding a way to cheat.
        Knowing that conventional play won't lead to victory--your opponent invented the game after all--you look for a way to even the odds. You realize that there are frequent opportunities to "accidently" switch the positions of your face down cards, and you start doing this to make sure your highest cards are always where they need to be.
    * {snake_pit == 1} decline to play the game.
    * {snake_pit == 2 || (snake_pit == 3 && (cheated || strategy))} excuse yourself and walk away.
    * {snake_pit == 3} flip the card table and walk away.
    - ->snake_pit
    - (conclusion)
/*
    * {IsInjured(rogueState)} [Ask him about his injury.]
    * [What's in this for you?]
    * [Ask him about home.]
    * {act1Hints ? (rogueHint)} [Who exactly shouldn't I trust?]
    //Trust check
*/
    * [That's all for now.]->choice
    - ->rogue
=cleric
    * {IsInjured(clericState)} [Ask him about his injury.]
    * [Ask him about his magic.]
        The Cleric explains that his magic, like that of all priests in the city, comes from the sun. It is mostly used to heal and protect people, as well as to dispel other more harmful magic.
        * * "That sounds useful."
            ~AlterTrust(Cleric, 1)
        * * "I was hoping more for fireballs and lightning bolts."
            ~AlterTrust(Cleric, -1)
        - - he explains that he does know some offensive spells, but he prefers not to use them.
        * * "I won't make you"
            ~AlterTrust(Cleric, 2)
        * * "It might be unavoidable."
            "I know," the Cleric says sadly.
        * * "You'll do what I tell you."
            ~AlterTrust (Cleric, -2)
            "U-Understood."
    * {Reached(WHY_NOT_ASK_HIM)} ["The Rogue told me not to trust you."]
        The Cleric seems surprised, and sadly says, "he has his r-reasons."
        * * [Push for more info]
            This option reveals that the Cleric and Rogue are brothers, and that the Cleric did something terrible to betray the Rogue's trust. Something he seems to regret.
        * * [Talk about something else]
    * [That's all for now.]->choice
    - ->cleric
=scholar
    The Scholar simply reiterates her position from before about not wanting to rest. This is your final chance to alter her trust before the Scholar trust check coming up.
    * [Completely agree with her.]
        ~AlterTrust(Scholar, 2)
    * [Remind her the team has to work together.]
        ~AlterTrust(Scholar, -1)
    * [Demand she follow your orders.]
        ~AlterTrust(Scholar, -2)
    * [That's all for now.]->choice
    - ->scholar

===night_1
{InjuryCount() > 0: The Cleric finishes casting his healing spell.} Your party settles down for the night.
{InjuryCount() > 0: Over the night, all your companions' injuries are healed.}
~HealOneStepAll(true)
Just as you are about to fall asleep, you get the faint sensation that something is watching you--not physically, but mentally. Something observing the inside of your mind. But just as you attempt to focus on it, you are instead swept into a dream...
*[Continue.]->dream
=dream
Suddenly, you are in a vast stone chamber, its circular walls glowing with an ethereal light. Though you have never seen it before, you know this to be the center of the vault. 
Ahead of you, two of your companions are struggling over a large circular disk about 3 feet across. It looks like the surface of the moon and is glowing with the same white light as the rest of the chamber, but much brighter. You know that this is the artifact you seek. Your two companions are at odds, each trying to rip the artifact from the other's grasp. 
//Choose companions
~temp lowTrustDreamCompanion = GetLowestTrust()
~temp highTrustDreamCompanion = GetHighestTrust()

[DEBUG
Retrieving lowest trust companion: {GetLowestTrust()}
Retireving highest trust companion: {GetHighestTrust()}
END DEBUG]
On the left is the {lowTrustDreamCompanion} who looks crazed with anger.
On the right is the {highTrustDreamCompanion} who looks at you pleadingly for assistance.

//Left = Low Trust
* {lowTrustDreamCompanion == Ranger}[Assist the Ranger, on the left.]
    The Ranger looks surprised as you come to her assistance, but accepts your help. Together, you pull on the artifact with all your might.
* {lowTrustDreamCompanion == Rogue}[Assist the Rogue, on the left.]
    The Rogue looks surprised as you come to his assistance, but accepts your help. Together, you pull on the artifact with all your might.
* {lowTrustDreamCompanion == Cleric}[Assist the Cleric, on the left.]
    The Cleric looks surprised as you come to his assistance, but accepts your help. Together, you pull on the artifact with all your might.
* {lowTrustDreamCompanion == Scholar}[Assist the Scholar, on the left.]
    The Scholar looks surprised as you come to her assistance, but accepts your help. Together, you pull on the artifact with all your might.
//Right = High Trust
* {highTrustDreamCompanion == Ranger}[Assist the Ranger, on the right.]
    The Ranger looks grateful as you come to her assistance, and starts fighting with renewed strength. Together, you pull on the artifact with all your might.
* {highTrustDreamCompanion == Rogue}[Assist the Rogue, on the right.]
    The Rogue looks grateful as you come to his assistance, and starts fighting with renewed strength. Together, you pull on the artifact with all your might.
* {highTrustDreamCompanion == Cleric}[Assist the Cleric, on the right.]
    The Cleric looks grateful as you come to his assistance, and starts fighting with renewed strength. Together, you pull on the artifact with all your might.
* {highTrustDreamCompanion == Scholar}[Assist the Scholar, on the right.]
    The Scholar looks grateful as you come to her assistance, and starts fighting with renewed strength. Together, you pull on the artifact with all your might.
//Can always choose yourself
* [Sieze the artifact for yourself.]
    Both of your companions look on in stunned betrayal as you step between them and attempt to sieze the artifact for yourself.
- There is a blinding flash of light...->scholar_trust_check

===scholar_trust_check
*[Continue]
[DEBUG:
Scholar Trust Check: Stays or sneaks ahead?
{
- prologueEvents ? (trustedScholar): Trust Required: MED (trusted outside)
- else: Trust Required: HIGH (did not trust outside)
}
Current Trust: {GetTrustThreshold(scholarTrust)}
{
- GetTrustThreshold(scholarTrust) == HIGH || (prologueEvents ? (trustedScholar) && GetTrustThreshold(scholarTrust) == MED): Trust Check SUCCESSFUL; Scholar stays 
END DEBUG]->awakened_by_scholar
- else: Trust Check FAILED; Scholar sneaks away 
END DEBUG]->awakened_by_scream
}

===awakened_by_scholar
*[Continue]->bump
=bump
...and you are awakened by a high-pitched scream echoing down the passageway.
You and your companions jump to your feet and scramble to check on one another. It takes only a moment to realize who is missing: The Scholar. She must have gone ahead without the group while you were sleeping. As you gather your things, you realize that all her gear is gone as well.
You realize that the room is bathed in moonlight, and as you look around the room, you notice that this seems to have altered the room. Frist <>->notice
=notice
you notice...
* [the sky]
    Directly overhead, the moon is visible through the skylight. It is nearly full and seems huge in the sky. It's light is making the room nearly as bright as day. 
* [the walls]
    The walls of the room are now covered in luminous blue writing in a language you cannot read. You look briefly at the others, but they shake their heads. Without the Scholar here to translate, there's no telling what it all means.
* [The statues]
    The moonlight has activated the statues and caused them to lower their arms to the ground. The bowls they hold are glowing brightly with reflected moonlight, but otherwise they are totally empty. 

* {CHOICE_COUNT() == 0} ->trap_passageway.scholar_ahead
- then <>->notice

===awakened_by_scream
*[Continue]->bump
=bump
...and suddenly someone is shaking you awake. As you open your eyes the light seems almost as bright as it was in your dream. You look up and see the Scholar is the one waking you. She looks giddy with excitement, and tells you to hurry.
You look around the room and realize things have changed. First <>->notice
=notice
you notice...
* [the sky]
    Directly overhead, the moon is visible through the skylight. It is nearly full and seems huge in the sky. It's light is making the room nearly as bright as day. 
* [the walls]
    The walls of the room are now covered in luminous blue writing in a language you cannot read. The Scholar tells you she has already started translating them, but seems to excited to stop and tell you what they say just yet.
* [The statues]
    The moonlight has activated the statues and caused them to lower their arms to the ground. The bowls they hold are glowing brightly with reflected moonlight. You and the Scholar look inside and see each is now holding several glowing ceramic tiles--they seem to have been empowered by the moonlight.
    "They lowered the bowls to the ground in offering," the Scholar observes. "We should take what they hold!" She begins packing the tiles into her backpack.
* {CHOICE_COUNT() == 0} ->trap_passageway
- Then <>->notice

You look up and see that the moon is directly visible through the open ceiling of the chamber. It is nearly full, and the room is bathed in moonlight.
->END

VAR scholarConfronted = true
===trap_passageway
the rest of your group finishes packing up camp, and the Scholar is urging you all into the passageway. "We've had our precious rest," she says. "But now time is of the essence!"
You all rush into the passageway, but the Ranger looks uneasy. "I don't like this," she says. "We should be moving much slower, and someone should be scouting ahead for traps."
* [Trust the Scholar to lead you.]
    ~AlterTrust(Ranger, -2)
    You ignore the Ranger and let the scholar continue to lead...
* [Assign the Ranger to scout ahead.]
    You tell the Ranger to scout ahead, but the Scholar refuses to cede control of the situation. She rushes to keep ahead of your scout, bumping and shoving to stay in the lead...
* [Assign the Rogue to scout ahead.]
    You tell the Rogue to scout ahead, but the Scholar refuses to cede control of the situation. She rushes to keep ahead of your scout, bumping and shoving to stay in the lead...
* [Assign the Cleric to schot ahead.]
    You tell the Cleric to scout ahead, but the Scholar refuses to cede control of the situation. She rushes to keep ahead of your scout, bumping and shoving to stay in the lead...
- ...and just as the Ranger predicted, before long the Scholar has stumbled over a hidden tripwire. A cage of barbed wire descends from the ceiling. However, rather than cartching the Scholar, it captures the Cleric instead! He cries out in pain and surprise as some of the wire cuts into his skin.
~Injure(clericState)
"Well, that is most unfortunate," the Scholar observes. "But I am afraid we must keep going."
"W-what?" the Cleric stammers, his eyes wide. "You would abandon me here?"
"Oh I'm sure there will be time to come back for you later!" The Scholar seems to think this should comfort the Cleric, but he shows no sign of calming down. "What?" the Scholar seems genuinely confused. "We all knew the risks."
She turns to you. "Come, we must keep moving."
* [Go with the Scholar.]
    ~AlterTrust(Rogue, -1)
    ~AlterTrust(Ranger, -2)
    ~AlterTrust(Cleric, -3)
    You agree with the Scholar, much to the surprise of the rest of your companions.
    The Rogue and the Ranger work to free the Cleric while you keep moving with the Scholar. they eventually all catch up to you, but the Cleric looks injured, and none of your companions seem happy.
* [Assist the Cleric.]
    ~AlterTrust(Scholar, -2)
    ~AlterTrust(Cleric, 3)
    ~AlterTrust(Ranger, 2)
    ~AlterTrust(Rogue, 1)
    You shake your head and turn back to help the Cleric out of the barbed cage. The Scholar groans and taps her foot while the rest of you work to free the Cleric, but she does not go ahead without you. When you are done, the Cleric looks very grateful, if a bit worse for wear.
    "Fine," the Scholar says impatiently. "Can we continue now?"
    * *[Confront the Scholar about her attitude.]
    You stop in the passageway to have a confrontation about the Scholar's attitude, and how it is endangering the team and mission. She seems taken aback, and genuinely speechless. It looks like you might finally be getting through to her.
    ~scholarConfronted = true
    * *[Let the matter drop.]
    You decide now is not the time for another argument, and the Scholar continues to regard the rest of your companions with visible disdain. Looking at them, the feeling now seems mutual.
- ->riddle_door
=scholar_ahead
you hear another scream. While the first was a scream of surprise and pain, this one has words. "Will one of you useless imbeciles hurry up and help me already??" you hear the Scholar's voice echo down the passageway.
The rest of the group relaxes slightly. At least the Scholar is alive, although she also sounds very annoyed.
You make your way down the passageway until you come upon the Scholar tangled in a cage of barbed wire, suspended about 6 feet off the floor. It seems in her haste she stumbled her way into a trap. She looks somewhat injured, but not terribly so.
~Injure(scholarState)
As you work to free the Scholar...
* You apologize for letting this happen.
    ~AlterTrust(Scholar, 1)
* You remind her she is part of a team.
    ~AlterTrust(Scholar, 2)
* You mock her for getting herself captured.
    ~AlterTrust(Scholar, -2)
- She considers your words for a moment, but they mostly seem to bounce off of her. After freeing her, the Scholar makes a snide comment about you not arriving sooner.
* [Confront her about her attitude.]
    You stop in the passageway to have a confrontation about the Scholar's attitude, and how it is endangering the team and mission. She seems taken aback, and genuinely speechless. It looks like you might finally be getting through to her.
    ~scholarConfronted = true
* [Let the matter drop.]
    You decide now is not the time for another argument, and the Scholar continues to regard the rest of your companions with visible disdain. Looking at them, the feeling seems mutual.
- ->riddle_door

VAR full_moons = 0
VAR CompanionsSafe = ()
VAR usedWildcard = false
===riddle_door
WIP: The group now arrives at the final challenge of Act 1: a riddle door. The group does not know this at first, but each riddle is about one member of the group (Some entity in the vault read each person's dreams to learn about them, including the player). 
*[Continue.]->scholar_riddle.
=scholar_riddle
//She solves it
The Scholar's riddle is a complex logic problem, but she solves it herself almost immediately. You are presented with a choice:
* [Trust her]
* [Ask the group for a second opinion.]
- If you ask the group this time, she ignores you and enters her answer anyway, but for the other riddles this will be an important choice. She enters the answer using one of the ceramic tiles from the first room--because her answer is correct, it comes back with a full moon printed on it. However, she doesn't realize it the question had anything to do with herself.
*[Continue.]->rogue_riddle
=rogue_riddle
You next turn to a wall covered in rectangular markings with numbers inside.
{
    -conversations_act1.rogue: Because you played cards with the rogue earlier, you recognize this as a representation of the card game he created. This is the first way you can discover that the riddles are specifically about your party members. Once you point this out to him, he realizes the riddle is how many moves it would take to win this game. The Scholar takes back control and realizes the answer is "3 moves." At this point you can choose:
    * (rogue_wrong)[Trust her.]
        She puts in the answer and the tile gets printed with a half-moon (wrong answer).->your_riddle
    * [Ask the Rogue if she is correct.]
        The Rogue realizes that, if you cheat, the game could actually be won in "2 moves." You now choose whose answer to use.
        * * [Pick the Scholar's Answer]->rogue_wrong
        * * [Pick the Rogue's Answer]
            You put in the Rogue's answer and get back another full moon.
        ->your_riddle
    -else: The Scholar solves this as a math problem and presents an asnwer to you. You choose:
    * [Trust her]
        She puts in the answer and the tile gets printed with a half-moon (wrong answer).->your_riddle
    * [Ask the group for a second opinion.]
        At this point the Rogue this as a representation of the card game he created. This is the first way you can discover that the riddles are specifically about your party members. Once you point this out to him, he realizes the riddle is how many moves it would take to win this game. The Scholar takes back control and realizes the answer is "3 moves." At this point you can choose:
    ** (rogue_wrong2)[Trust her.]
        She puts in the answer and the tile gets printed with a half-moon (wrong answer).->your_riddle
    ** [Ask the Rogue if she is correct.]
        The Rogue realizes that, if you cheat, the game could actually be won in "2 moves." You now choose whose answer to use.
        * * * [Pick the Scholar's Answer]->rogue_wrong2
        * * * [Pick the Rogue's Answer]
            You put in the Rogue's answer and get back another full moon.
        ->your_riddle
}

=your_riddle
You realize quickly that next riddle is about who you supported in claiming the artifact in your dream. This means you know the answer right away, but you are given the choice of whether or not to reveal the meaning to the group or keep it secret. 
*[continue.]
->cleric_riddle
=cleric_riddle
The next riddle is about betrayal, and the Cleric realizes immediately it is about him.
If he is at LOW trust he will not reveal this to the group. If you have the blank tile from the first room, you can discover here that it can be used as a free "solved" riddle. If this route is chosen, the Rogue will eventually figure out the meaning of the riddle and reveal the story to the group at the start of ACT 2.
If he is at MED trust he will say he knows the answer, but not reveal how. You can choose whether to allow this, or demand the truth. If you don't demand the truth, the Rogue does instead.
If he is at HIGH trust he automatically reveals the full truth.
If you get the full story, The Cleric reveals to the group that 1) He and the Rogue are brothers and 2) He is the reason that the Rogue was exiled, and nearly executed. 
*[Continue.]->ranger_riddle
=ranger_riddle
The Ranger's riddle also reveals something dark about her past (she sacrificed a whole group of other Rangers trying to save the life of a loved one.) This plays out as a similar trust check to the Cleric's section (I don't know what makes it different yet).
*[Continue.]->riddle_finale
=riddle_finale
The number of incorrect or unanswered riddles equals the number of injuries the group sustains trying to make it through the door. If it was discovered that the blank tile can be used as a wildcard, it can be used in place of an incorrect answer.
->scholar_lesson


===scholar_lesson
WIP: After getting through the door, there is a final conversation with the Scholar to wrap up this section. If you confronted her appropriately about how her feelings of superiority were hindering the group, she will start to view the rest of the group as equals moving forward. However, if you either enabled her too much, did not confront her, or were overly mean in confronting her, she will double down on feeling superior to the others, and be willing to use them as disposable pawns.
->END

/****** ACT 2: The Brothers ******

******/
///Act 2 Variables
=== SKIP_TO_ACT_2
Pick a Save State to start Act 2 with:
+ [Default Save State]
    {EnterSaveState(201, true)}
+ [Ideal Save State]
    {EnterSaveState(202, true)}
+ [Bad Save State]
    {EnterSaveState(203, true)}

- ->intro_act2

===SETUP_ACT2
->intro_act2

===intro_act2
//You just made it through
{scholarEndings ? (humbled): }
->END

===brothers_intro
->END

===job_201
->END

===job_202
->END

===job_203
->END

===diverging_paths
->END

===rogue_passage
->END

===cleric_passage
->END

===act2_puzzle_room
->END

===job_210
->END
===job_211
->END

===job_220
->END
===job_221
->END

===act2_puzzle_finale
->END

===brothers_finale
->END

===act2_end
-
->SETUP_ACT3

/****** ACT 3: The Ranger ******

******/
===SETUP_ACT3
->intro_act3

===intro_act3
->END

===back_outside
->END

===new_destination
->END

===night_2
->END

===ambush
->END

===death_around_every_corner
->END

///Camp
===job_300
->END

///Jungle
===job_310
->END

///Ravine
===job_320
->END

///Riverbed
===job_330
->END

///Basin
===job_340
->END

///Doors
===job_350
->END

===finale_act3
->END


/****** FINALE: The Artifact ******

******/



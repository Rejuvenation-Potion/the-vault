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
///->DEBUG_MENU

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
    ~AlterTrust(rangerTrust, 0)
    ->ranger
    
* {CanGiveJob(rogueState)} [Assign the Rogue.]
    TODO: You assign the rogue.
    ~SetStateTo(rogueState, busy)
    TODO: Trust Changes
    ~AlterTrust(rogueTrust, 0)
    ->rogue
    
* {CanGiveJob(clericState)} [Assign the Cleric.]
    TODO: You assign the cleric.
    ~SetStateTo(clericState, busy)
    TODO: Trust Changes
    ~AlterTrust(clericTrust, 0)
    ->cleric
    
* {CanGiveJob(scholarState)} [Assign the Scholar.]
    TODO: You assign the scholar.
    ~SetStateTo(scholarState, busy)
    TODO: Trust Changes
    ~AlterTrust(scholarTrust, 0)
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
LIST brothersKnowledge = KNOW_ARE_BROTHERS, KNOW_ABOUT_CONFLICT, HEARD_ONE_SIDE, HEARD_BOTH_SIDES
LIST rogueEndings = revenge, loner, belonging
LIST clericEndings = lostFaith, statusQuo, enlightenment
//Ranger
LIST rangerGriefStages = CLOSED_OFF, OPENING_UP, PROCESSING_GRIEF, ACCEPTED_LOSS
LIST rangerEndings = sacrifice, deathGuilt, deniedMartyr, brilliantPloy

=== DEBUG_MENU
->SKIP_TO_ACT_2


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
    ~AlterTrust(scholarTrust, -2)
    ~AlterTrust(clericTrust, 1)
    ->job_011.cleric

* {CanGiveJob(rangerState)} [The Ranger has good danger sense; tell her to investigate it]
    You decide the Ranger should be the one to investigate the unknown magic.
    ~SetStateTo(rangerState, busy)
    ~AlterTrust(scholarTrust, -2)
    ->ranger
    
* {CanGiveJob(rogueState)} [It's probably a trap; tell The Rogue to disarm it]
    "It is almost certainly a trap," you say. You turn to the Rogue. "And you are our trap expert; get in there and disarm it."
    "Literally what did I just say??" he exclaims. There is a pause, and then a sigh. "Look, I'll do it, but I won't forget this."
    ~SetStateTo(rogueState, busy)
    ~AlterTrust(scholarTrust, -2)
    ~AlterTrust(rogueTrust, -2)
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
    ~AlterTrust(scholarTrust, 2)
    ->job_012.scholar
* {CanGiveJob(rangerState)} [Assign the Ranger.]
    You turn to the Ranger.
    "Sounds like you already have a good idea how to disarm this thing" you tell the Ranger. "Go ahead and get started."
    The Ranger nods in response. "Good plan."
    ~SetStateTo(rangerState, busy)
    ~AlterTrust(rangerTrust, 1)
    ~AlterTrust(scholarTrust, -2)
    ->ranger
    
* {CanGiveJob(rogueState)} [Assign the Rogue.]
    "I know you were wary of the magic, but we know what it is now. You say to the Rogue to cut off his protest. "And traps are your specialty."
    The Rogue sighs dramatically, but moves to the door anyway.
    {not job_020.rogue: He mutters under his breath just loud enough for you to hear, "I would have rather dealt with the lock..."}
    ~SetStateTo(rogueState, busy)
    ~AlterTrust(rogueTrust, -1)
    ~AlterTrust(scholarTrust, -2)
    ->rogue
    
* {CanGiveJob(clericState)} [Assign the Cleric.]
    You turn to the Cleric. "Go ahead and dispel it."
    ~SetStateTo(clericState, busy)
    ~AlterTrust(clericTrust, 1)
    ~AlterTrust(scholarTrust, -2)
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
    - With one last The Ranger bashes the lock free! 
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
    - not job_010.finish: Now that they are unlocked, You could order someone to open those doors. The magic is still active though, and there's no telling what it could do.
    - prologueEvents !? (trapDisarmed): Now that they are unlocked, You could order someone to open those doors. The magic is still active though, and would likely injure whoever you choose.
    - else: Now that the doors are unlocked and the magic is no longer a threat, you just need someone to open them!
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
    - Your companions begin carrying out your orders. You notice that the sky has gotten much darker since you arrived. The sun must be bellow the horizon line by now, if you could even see it through the thick jungle around you. You get the vague sensation that something is watching you, waiting for night to fall. ->->
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
    - prologueEvents ? (creaturesArrived) && prologueEvents !? (creaturesKilled) && prologueEvents !? (creaturesScared): "Inside, quickly!" you shout as the hungry leopards pin your group closer and closer to the wall. You dart inside one after another, and working together, <>
    { 
        - IsInjured(rangerState) && IsInjured(clericState): You attempt to close the doors before the beasts can follow you in. However, with the ranger and the cleric injued your group is not at full strength, and the leopards get one last swipe in--at you--before the doors close. You stumble back in the darkness cluthcing at your left leg, which is now bleeding where the leopard clawed you. Your companions immediately start to bandage you up. You'll live, but you'll also have trouble with that leg for a while.
            ~ player_injured = true
        - IsInjured(rangerState): You attempt to close the doors before the beasts can follow you in. However, with the ranger injued your group is not at full strength, and the leopards get one last swipe in--at you--before the doors close. You stumble back in the darkness cluthcing at your left leg, which is now bleeding where the leopard clawed you. Your companions immediately start to bandage you up. You'll live, but you'll also have trouble with that leg for a while.
            ~ player_injured = true
        - IsInjured(clericState): You attempt to close the doors before the beasts can follow you in. However, with the cleric injued your group is not at full strength, and the leopards get one last swipe in--at you--before the doors close. You stumble back in the darkness cluthcing at your left leg, which is now bleeding where the leopard clawed you. Your companions immediately start to bandage you up. You'll live, but you'll also have trouble with that leg for a while.
            ~ player_injured = true
        - else: "Inside, quickly!" you shout as the hungry leopards pin your group closer and closer to the wall. You dart inside one after another, and working together, you manage to slam the heavy doors shut just before the creatures can follow you in.
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

//*[Next Scene]->trust_explanation
//*[Next Scene]->antechamber

*[Next Scene.]->SETUP_ACT1

/****** ACT 1: The Scholar ******

*******/
///ACT 1 Variables
VAR playerSympatheticToCleric = true
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
///ACt 2 Variables
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
You just made it through
{scholarEndings ? (humbled): }
->END


/****** ACT 3: The Ranger ******

******/

/****** FINALE: The Artifact ******

******/

/*
Cleric Rogue Argument scene
*/

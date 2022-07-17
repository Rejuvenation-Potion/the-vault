->intro
=== intro ===
You stand before a large stone structure. This is it, the ancient vault you have been searching for. 
You are in a small clearing and the vault is just ahead of you. On all other sides you are surrounded by the jungle you navigated to get here. You have travelled all day, and it is nearly sunset.
*   [Continue.]
    Set into the stone wall are two huge stone doors. Your guide, The Ranger, steps forward and studies them.
    "Those look heavy," she says, "but I should be able to get them open."
    **[Continue.]->first_turn
    
=== first_turn
Someone needs to get those doors open. You could follow the Ranger's suggestion, or assign one of your other companions to the task. ->assignment
=assignment
* [Let the Ranger open the doors]->ranger
* [Assign the Rogue to open the doors]->rogue
* [Assign the Cleric to open the doors]->cleric
* [Assign the Scholar to open the doors]->scholar
    
=ranger
You tell the Ranger to open the doors. 
"No problem, boss." The Ranger moves up to the door, scanning them quickly for any obvious danger. She then places her hands on the stone surface and prepares to push.
As soon as her hands make contact however, <>->end_turn
=rogue
You tell the Rogue to open the doors.
"You know our contract didn't mention anything about manual labor, I thought you hired me for my finesse." The Rogue smirks, but he strides up the door regardless. "Well, pretty sure I get time-and-a-half for this." 
He places one hand out to lean upon the doors for a moment. 
As soon as his hand makes contact however, <>->end_turn
=cleric
You call out to the Cleric, and he looks up suddenly from his prayerbook. His sad eyes meet yours for a moment. 
"If that is what you wish. I-I suppose it might be safest for me to be the first into this tomb regardless." 
He walks carefyully up to the doors and places his hands upon their stone surface. 
As soon as his hands make contact however, <>->end_turn
=scholar
You call out to the Scholar, but she cuts you off.
"Bah, I have better things to do than manual labor, get one of these other cretins to do it. Isn't that why we hired them?" She doesn't even look up from her scrolls. 
    ->first_turn.assignment
= end_turn
 hundreds of luminous blue symbols--magical runes of some kind--appear on the surface of the doors and and scatter outward from the point of contact. They are connected by elegant arcs of white energy. You all take a small step backward, and as soon as no one is touching the doors, the glowing symbols begin to fade again.
* [Continue.]->second_turn

=== second_turn
At the first sign of this magic, the Scholar looks up from the scroll she was buried in. "Oh finally, something interesting!" 
"And potentially dangerous," adds the Ranger. "We might be dealing with a magical trap of some sort."
The Scholar takes off her reading glasses and stows them away. "Well, if you let me get a closer look, I can tell you for sure."
* [Continue]
{first_turn.rogue: 
The rogue chimes in. "Look all you want, but the door is locked anyway." You turn to him where he is leaning on the door, and he points lazily upward.
}
{first_turn.ranger:
    The Ranger holds up a hand. "Just hold on, the door is locked anyway. I could tell when I tried to push it."
} 
{first_turn.cleric:
    "Uh, if I may," the Cleric interjects heasitantly. "Trap or no trap, from what I could tell the door is also locked."
} 
{not first_turn.rogue:
    "Pff, I could have told you that," says the Rogue. "Look up there." 
    You turn to him and see that he is pointing to something high up on the wall.
}

    **  [Continue.]

- Following his gesture, you see a stone box with several openings--presumably a large locking mechanism of some kind--high up on the wall.
"With all the vines growing over the stonework, I could climb up there no problem and get that open for you," says the rogue. "But I don't want anything to do with that magic!"
The scholar huffs. "That is why I already said that should be left to me!"

{
    - not first_turn.cleric:The Cleric, who has been quiet until now, <>
    - else: The Cleric <>
}
speaks softly. "If I can be of some use here, I also have some experience with magic. if you give me a moment, I could craft a counterspell that would remove the magic regardless of its purpose."
The Scholar whirls on him. "And lose an opportunity for study?" She turns back to you. "It is possible that this magic might actually help us, but we'll never know if you don't give me a chance."
"Respectfully, we might not have time to sit here while you doodle in your notebook," the Ranger counters. "We've been travelling all day and the sun is settting. This jungle gets dangerous at night."
The Scholar looks down her nose at the Ranger. "You obviously don't understand how quickly I work."
The Ranger sighs, and then she turns back to you. "It's your call."
** [Continue]->magic_and_lock

=== magic_and_lock
Someone needs to determine the nature of the magic spell, while someone else climbs up and unlocks the doors.
->magic

//Busy flags
VAR ranger_busy = false
VAR rogue_busy = false
VAR cleric_busy = false
VAR scholar_busy = false

//Injured flags
VAR ranger_injured = false
VAR rogue_injured = false
VAR cleric_injured = false
VAR scholar_injured = false
VAR player_injured = false

VAR creatures_arrived = false
VAR creatures_killed = false

=== magic
What should be done about the unknown magic?
* { not scholar_busy} [Allow The Scholar to begin studying it.]
    ~ scholar_busy = true
    ->scholar
* { not cleric_busy} [Have The Cleric begin dispelling it.]
    ~ cleric_busy = true
    ->cleric
* { not ranger_busy} [The Ranger has good danger sense; tell her to investigate it]
    ~ ranger_busy = true
    ->ranger
* { not rogue_busy} [It's probably a trap; tell The Rogue to disarm it]
    ~ rogue_busy = true
    ->rogue
=ranger
You decide the Ranger should be the one to investigate the unknown magic.
"Makes sense I suppose," she shrugs. "I don't know much magic, but I should be able to tell if it's dangerous."
->lock
=rogue
"It is almost certainly a trap," you say. You turn to the Rogue. "And you are our trap expert; get in there and disarm it."
"Literally what did I just say??" he exclaims. There is a pause, and then a sigh. "Look, I'll do it, but I won't forget this."
->lock
=cleric
"Let's not take any chances," you say and turn to the Cleric. "Dispel it."
"Very well." The Cleric opens his prayerbook and begins muttering an incantation. His voice is drowned out for a moment by the Scholar's loud protestations, but you silence her with a stern glance.
->lock
=scholar
"Excellent!" The Scholar produces a notebook and begins writing in it frantically.
->lock

=== lock
* [Continue.]->assignment
=assignment
Now for the lock: who should climb up and open it?
* { not ranger_busy} [The Ranger]
    ~ ranger_busy = true
    ->ranger
* { not rogue_busy} [The Rogue]
    ~ rogue_busy = true
    ->rogue
* { not cleric_busy} [The Cleric]
    ~ cleric_busy = true
    ->cleric
* { not scholar_busy} [The Scholar]
    ~ scholar_busy = true
    ->scholar
=ranger
"Got it." The Ranger makes her way over to the vine-covered wall. "Locks aren't my specialty, but I'll climb up and see what I can do."
->turn
=rogue
The Rogue grins. "Stand back everybody! And let a master work." He swaggers over to the vine-covered wall.
->turn
=cleric
"Ah, v-very well. I'm no lockpick, but perhaps I might be able to bash it open." He pats the silver mace tied to his simple rope belt. You know that The Cleric, though a bit meek in personality, is a surprisingly strong man. "I feel uneasy about those vines however. I will retrieve our climbing gear."
->turn
=scholar
"Aha! A test of both mind and body!" the Scholar exclaims. "That lock is as good as open." 
She begins rummaging through her pack. "Now where did I put that climbing gear?..."
->turn


=== turn
=start
-Your companions begin carrying out your orders.
->pass_time


===pass_time
+ <>[Continue.]
{You notice that the sky has gotten much darker since you arrived. The sun must be bellow the horizon line by now, if you could even see it through the thick jungle around you. You get the vague sensation that something is watching you, waiting for night to fall.->job_102| By now the darkness of the forest has grown more oppressive. You start to hear growls from the forest all around you, and they seem to be getting closer.->job_101|->job_101}

// Keep watch for dangers from the jumgle
=== job_101
{

    -job_101.finish: ->job_102
    -job_101.fire: -> fire_rogue
    -job_101.ranger: ->ranger
    -job_101.rogue:->rogue
    -job_101.cleric: ->cleric
    -job_101.scholar:->scholar
}
Your companions look about uneasily as danger seems to be setting in around you. It might be wise to mount a defense of some kind against the creatures of the jungle while you work on getting inside the vault.
Your companions not busy with other tasks offer their suggestions:
    {
    - not ranger_busy: The Ranger cups her ear and listens intently to the sounds from the jungle. "Those sound like jungle cats to me. Large, dangerous predators. But don't worry, I know how to deal with this. Send me out there and I'll lure them away by mimicing their calls."
    }
    {    
    - not rogue_busy: The Rogue paces nervously. "Gods I hate animals, I should have stayed in the city! Ok, animals hate fire right? Why don't we gather some wood and start a fire to keep them away?"
    }
    {    
    - not cleric_busy: The Cleric's eyes go wide as he listens to the predators approach. He pulls out his prayerbook and begins turning its pages quickly. "I sh-should be able to consecrate the ground in this clearing, giving us a c-circle of protection from those creatures. That would p-prevent them from harming us. I think...."
    }
    {   
    - not scholar_busy: The Scholar pulls a stack of books from her pack. "Not to worry! I know not what creatures menace us, but surely something in these tomes will help us divert them. Knowledge never fails me!" 
        The Scholar is putting on a brave face, but you can tell she is as nervous as the rest of you underneath.
    }

->assignment
=assignment
Whose plan will you use to hold back the creatures in the jungle?
* { not ranger_busy} [The Ranger will lure them away.]
    //~ ranger_busy = true
    ->ranger
* { not rogue_busy} [The Rogue will build a fire.]
    // ~ rogue_busy = true
    ->rogue
* { not cleric_busy} [The Cleric will create a magical circle of protection.]
    //~ cleric_busy = true
    ->cleric
* { not scholar_busy} [The Scholar will find a solution in her books.]
    //~ scholar_busy = true
    ->scholar
= ranger
{The Ranger disappears into the darkness. A moment later you hear a series of startlingly lifelike animal calls, ranging from birds to cats to creatures you can't even name. The calls get progressively further away and eventually grow quiet. Some moments later, the Ranger reappears at your side. "Hopefully that bought us some time"|It seems that the Ranger's diversion did buy you some time, but now you can hear the creatures approaching agian. They will be upon you soon, and there is no time for another diversion.->finish}
->job_102
= rogue
{The Rogue runs about the clearing gathering branches, fallen leaves, anything that looks like it will burn. He throws it all into a big pile at the edge of the darkness, grabs a tinderbox from his pack, and lights it all up. Soon a blaze is burning brightly. Beyond the light of the fire, you see two bright pairs of eyes--but then you seem them quickly retreat. It seems the Rogue's fire did scare off the creatures!|The creatures were scared away, but you realize now that you have a new problem: the fire the Rogue constructed is burning out of control. You urge everyone away from the blaze. ->fire}
->job_102
= cleric
{The Cleric starts pacing a careful arc along the edge of the clearing. He reads aloud an incantation from his book while dropping a trail of what looks to be fine golden sand from a small pouch at his belt. When it hits ground, the sand combines to form the base of a glowing golden barrier. Soon enough he has traced the entire perimeter of the clearing. Just in time too; you can see two pairs of hungry feline eyes pearing out from the darkness beyond the barrier. But, at least for now, they aren't coming any closer.| Unfortunately, the Cleric's consecrated barrier was made hastily, and soon holes start to form in the perimeter. It isn't long before the creatures that have been stalking you find an opening and jump into the clearing. Two leopards stand before you, and they look ready to kill.->finish}
->job_102
= scholar
You watch anxiously as the Scholar shuffles through her papers. Maybe books aren't the best defense against wild animals after all, because before she can find anything, the jungle cats that have been creeping toward you burst into the clearing!->finish
=finish
~ creatures_arrived = true
->job_102
=fire
~ creatures_killed = true
{
    - not cleric_busy: However the Cleric doesn't get away quite quickly enough, and the flames travel up to the fraying edges of his robes. His robes light on fire briefly before he is able to stamp them out with your assistance. He is alive and well, but with burns up his right leg.
        ~cleric_injured = true
    - not scholar_busy: However, the Scholar is distracted when she sees the fire moving towards a pile of her books. She runs over to them as they burst into flame. The Rogue pulls her back as quick as he can, but not before the Scholar severely burns her hands trying in vain to save her books.
        ~scholar_injured = true
    - not ranger_busy: The Ranger tries bravely to contain the blaze. As she attempts to beat the fire down with her cloak, it flares for a moment and catches fire to her right arm. She dives into a roll immediately and manages to put it out, but when she stands you can see scorch marks lingering along her whole arm.
        ~ranger_injured = true
}
->job_102
=fire_rogue
The fire has grown completely out of control and nearly filled the clearing. Your group is now pressed up very close to the doors to stay out of the flames. The rogue, looking terrified and guilty, is looking frantically through the group's supplies for something, anything that could fight the fire. The fire flares and catches fire to his cloak. You pull him away and fortunately extinguish his clothing before he is completely consumed, but he will be feeling those burns for a while.
    ~ rogue_injured = true
->job_102

=== job_102
{   
    - job_102.finish: ->job_103
    - lock.ranger: ->ranger
    - lock.rogue: ->rogue
    - lock.cleric: ->cleric
    - lock.scholar: ->scholar
}
= ranger
You look toward the door and lock, where you've assigned the Ranger to the task. <>
{once:
    - In one swift motion, the Ranger grabs hold of the vines and hoists herself to the top of the wall. 
    - From her perch above the mechanism, The Ranger begins smashing the lock with the flat of her axe.
    - With one last The Ranger bashes the lock free! 
    ~ ranger_busy = false
    ->finish
}
->continue
= rogue
You look toward the door and lock, where you've assigned the Rogue to the task. <>
{once:
- Alternating between the vines and cracks in the stonework, the Rogue deftly makes his way up the wall.
- The Rogue takes out his thieves tools and twirls them around his fingers for a moment. Then he goes to work, his fingers moving faster than you can follow. Before you know it, the lock slides open.
    ~ rogue_busy = false
    ->finish
}
->continue
= cleric
You look toward the door and lock, where you've assigned the Cleric to the task. <>
{once: 
- He retrieves the climbing gear from the Scholar's pack.
- He climbs up the wall with the climbing gear.
- He begins smashing the lock with his mace.
- With one last whack of his mace, the Cleric breaks the lock!
~ cleric_busy = false
->finish
}
->continue
= scholar
You look toward the door and lock, where you've assigned the Scholar to the task. <>
{once:
- The Scholar is still busy grabbing an armful of climbing gear--ropes, pitons, gloves, and the like--from her pack.
- The Scholar carefully attaches the ropes and pitons, and then steps back to consider the wall. "A good climber knows that plotting the course is half the battle!" she declares to no one in particular. She doesn't seem to be in any hurry.
- Finally prepared, the Scholar makes her way up the stone wall.
- The scholar puts a finger to her temple and studies the locking mechanism as if regarding a clever rival in a game of chess. After a moment she retrieves a hairpin and springs into action. With one simple action, the lock slides open.
~ cleric_busy = false
->finish
}
->continue
= continue
->job_103
= finish
->job_104


// Investigate the magic
=== job_103
{   
    - job_103.finish || magic.rogue || magic.cleric: ->job_104
    - magic.ranger: ->ranger
    - magic.scholar: ->scholar
}
= ranger
Meanwhile, the Ranger steps up as close as she can to the doors and scans their stone surfaces. Soon enough, she seems to have found what she is looking for.
*[Continue]
    "Look here," she says, calling your attention to a series of small holes in the doors' surface.
    "If I know traps, something really bad is going to shoot out of these when the doors are open. Probably some sort of magical projectile from the looks of things."
    ** [Continue]
    ~ ranger_busy = false
    ->finish
= scholar
Meanwhile, the Scholar continues scribbling in her notebook, hard at work deciphering the magic imbued into the doors. Every now and then she pauses her writing to poke the surface of the doors, causing the glowing runes to reappear with their connecting lines. Looking over her shoulder, it appears as though she is studying the patterns of the lines and sketching dizzyingly complex diagrams to keep track of them all.
"Aha!" Suddenly, she snaps the book shut. "I've got it."
~ scholar_busy = false
*[Continue]
"It's a trap of Moonfire," the Scholar explains, "designed to scorch whoever opens those doors."
"Nice work," says the Ranger. "Let's get it turned off then."
"Not so fast," the Scholar replies. "If you'll allow me to keep studying, I believe I can discover a way we might turn this magic to our advantage." The Scholar smiles broadly, but does not elaborate any further.
**[Continue]
->finish
=finish 
->job_104

// Open the doors
=== job_104
{   
    - not job_102.finish: ->job_105
    - else: ->assignment
}
=assignment
{
    - not job_103.finish && not job_105a.finish && not job_105b.finish: Now that they are unlocked, You could order someone to open those doors. The magic is still active though, and there's no telling what it could do.
    - not job_105a.finish && not job_105b.finish: Now that they are unlocked, You could order someone to open those doors. The magic is still active though, and would likely injure whoever you choose.
    - else: Now that the doors are unlocked and the magic is no longer a threat, you just need someone to open them!
}
* { not ranger_busy } [Tell the Ranger to open the doors.]->ranger
* { not rogue_busy }[Tell the Rogue to open the doors.]->rogue
* { not cleric_busy }[Tell the Cleric to open the doors.]->cleric
* { not scholar_busy }[Tell the Scholar to open the doors.]->scholar
+ {not job_105a.finish && not job_105b.finish}[Leave the doors alone for now.]->noone
=noone
Knowing the magic is still active, you leave the doors alone for now.
Time passes. <>
->job_105
= ranger
The Ranger rushes over to the doors and begins pushing them open. <>
{
    - job_105a.finish || job_105b.finish: Now that they are unlocked this proves to be fairly easy for someone of her strength. Fortunately, the magic is dealt with and no further traps reveal themselves.
    - else: As she pushes, several pools of blue-white energy coalesce on the surface of the door. A jet of white flame shoots straight out from each one, several of them burning the Ranger. She cries out in pain, but keeps pushing. After a few seconds the flames burn out. The Ranger is still standing, but looking quite injured and burned.
        ~ ranger_injured = true
}
->finish
= rogue
The Rogue rushes over to the doors and begins pushing them open.
{
    - job_105a.finish || job_105b.finish: It takes all of his might, but he manages to start moving them. Fortunately, the magic is dealt with and no further traps reveal themselves.
    - else: As he pushes, several pools of blue-white energy coalesce on the surface of the door. A jet of white flame shoots straight out from each one, several of them burning the Rogue. He cries out in pain, but keeps pushing. After a few seconds the flames burn out. The Rogue is still standing, but looking quite injured and burned.
        ~ rogue_injured = true
}
->finish
= cleric
The Cleric hurries toward the doors and begins pushing them open.
{
    - job_105a.finish || job_105b.finish: Now that they are unlocked this proves to be fairly easy for someone of his strength. Fortunately, the magic is dealt with and no further traps reveal themselves.
    - else: As he pushes, several pools of blue-white energy coalesce on the surface of the door. A jet of white flame shoots straight out from each one, several of them burning the Cleric. He cries out in pain, but keeps pushing. After a few seconds the flames burn out. The Cleric is still standing, but looking quite injured and burned.
        ~ cleric_injured = true
}
->finish //HERE
= scholar
For once, the Scholar does not argue. Instead, she hurries over the doors and begins pushing them open.
{
    - job_105a.finish || job_105b.finish: It takes all of her might, but she manages to start moving them. Fortunately, the magic is dealt with and no further traps reveal themselves.
    - else: As she pushes, several pools of blue-white energy coalesce on the surface of the door. A jet of white flame shoots straight out from each one, several of them burning the Scholar. She cries out in pain, but keeps pushing. After a few seconds the flames burn out. The Scholar is still standing, but looking quite injured and burned.
        ~ scholar_injured = true
}
->finish
=finish 
->finale

//Decide what to do about the magic, with more information
===job_105
{ 
    
    - magic.rogue || magic.cleric || job_105a: ->job_105a
    - job_105b: ->job_105b
    - not job_103.finish: ->job_106
    - else: ->assignment
}
=assignment
Now that you know more about the magic, who will deal with it?
* { not scholar_busy && not job_103.scholar}[Ask the Scholar to help dispel the trap.]
    The Scholar looks thouroughly displeased with you for not allowing her to study the magic. "Do it yourself, I won't help you destroy this arcane knowledge."
    ->assignment
* { not scholar_busy && job_103.scholar}[Allow the Scholar to continue studying the magic.]
    ~ scholar_busy = true
    ->job_105b.scholar
* { not cleric_busy }[Tell the Cleric to dispel the magical trap.]
    ~ cleric_busy = true
    ->job_105a.cleric
* { not ranger_busy } [Tell the Ranger to disarm the trap.]
    ~ ranger_busy = true
    ->job_105a.ranger
* { not rogue_busy }[Tell the Rogue to disarm the trap.]
    ~ rogue_busy = true
    ->job_105a.rogue

->job_105a
->job_105b


// Disarm the magical trap
=== job_105a
{
    - job_105a.finish || job_105b.finish: ->job_106
    - magic.ranger: ->ranger
    - magic.rogue: ->rogue
    - magic.cleric: ->cleric
}
= ranger
Meanwhile, <>
{ once:
    - the Ranger starts disarming the trap. She moves about the clearing for a minute gathering leaves, mud, and small rocks from the jungle floor. She then returns to the hole she found in the door and plugs it up with the material she gathered. She inspects her work for a moment and appears satisfied. 
    "This is going to work, but it will take some time. There are a few dozen of these holes to fill." She gets back to work.
    - the Ranger continues disarming the trap. She has filled over half the holes by now. "I think these are supposed to shoot jets of fire!" she calls back over her shoulder. "What I'm doing should suppress that."
    - you see that the Ranger seems to have finished her work at the doors. "Just one more second!" she says. She strikes the doors with the hilt of her handaxe and then retreats a few steps. The runes appear again, and then pools of white-blue energy appear around each of the openings the Ranger had filled. They glow brighter and brighter and you begin to anticipate an explosion of some kind. Instead however, you hear only a soft "pop." A few of the trap's openings emit a tiny jet of white fire before quickly burning out, and the rest lie totally dormant. After a moment all of the magical energy fades. The Ranger was successful, and the trap is now disarmed!
    ~ ranger_busy = false
    ->finish
}
    ->job_106 
= rogue
Meanwhile, <>
{ once:
    - while he isn't happy about it, the Rogue starts disarming the trap. He begins gingerly poking at the stone doors, causing the magical symbols to once again scatter across the surface. He takes out one of his daggers and scrapes it across one of the runes, as if trying to scratch it out. Suddenly the Rogue jumps back, turning away with his hands over his ears as if expecting an explosion. But after a tense moment, there is no reaction. The Rogue relaxes, and turns to you.
    "Well, I know how to do this now, but it's going to take a minute."
    - the Rogue has continues disarming the trap, proceding carefully across the stone wall and erasing runes one by one. "Almost done!" he calls out.
    - the Rogue calls out to you again. "We're good to go!" He scratches out one final symbol, and then strikes the doors with the hilt of his dagger, as if attempting to trigger the trap. He is trying to appear confident in his work, but you notice he still flinches as he does this. But nothing happens, and no runes appear. The trap is disarmed!
    ~ rogue_busy = false
    ->finish
}
->job_106  
= cleric
Meanwhile, <>
{ once: 
    - the Cleric is preparing his counterspell. As he reads out line after line from his worn prayerbook, he begins faintly glowing with a golden light.
    - the Cleric finishes his spell. He speaks one final word in a language you do not understand, his normally soft voice crescendoing to a surprising volume. The golden light that had been gathering around him travels forward in a wave and suffuses the stone doors, as if washing across their surface. The Cleric walks up and softly places a palm on the stone door. Unlike last time, no magical runes or lines appear. He smiles gently, satisfied with his work. The magic has been dispelled.
    ~cleric_busy = false
    ->finish
}
->job_106
=finish
->job_106

=== job_105b
=scholar
{ once:
    - Pleased, the Scholar goes back to her note taking. "How nice it is to work with someone who values intelligence! Now as soon as I copy down all the details of this magic, I'll show you what it can do."
    - "Yes!" You hear the Scholar cry out with glee." The Scholar snaps her book shut once again. "Now this will be fun!" 
    ~scholar_busy = false
    ->finish
}
->job_106
=finish
Moving quickly, the Scholar knocks several times on the doors in quick succession, in a different spot each time. Each knock leads to more magical lines rippling accross the surface of the door. They seem to be coalescing into pools of bright energy scattered across the stone wall. With a last knock, the Scholar suddenly twirls out of the way. A beam of white fire shoots out from each of the magical pools, arcing toward where the Scholar was just standing. But her dodge was successful, and the moonfire instead arcs out harmlessly into the jungle.
{
    - not creatures_killed: To your pleasant surprise, this burst of firey magic also immediately scares away the creatures from the jungle that have been menacing you. The Scholar turned the trap to your advantage after all.
        ~ creatures_killed = true
}
{ job_102.finish: ->job_104}
->job_106



// Keep the dangerous creatures at bay
=== job_106
{
    - not creatures_arrived || creatures_killed: ->pass_time
    - creatures_arrived && not assignment: ->assignment
}
= assignment
Despite your efforts, two large leopards now stand before your group in the jungle clearing. They look hungry and ready to strike!
Who will lead the fight against the jungle cats?
* { not ranger_busy } [The Ranger]
    ~ ranger_busy = true
    ->ranger
* { not rogue_busy }[The Rogue]
    ~ rogue_busy = true
    ->rogue
* { not cleric_busy }[The Cleric]
    ~ cleric_busy = true
    ->cleric
* { not scholar_busy}[The Scholar.]
    ~ scholar_busy = true
    ->scholar
= ranger
Quicker than you can see the Ragner draws her bow and puts an arrow between the eyes  of the first leopard. Just as quickly however, the second one pounces on her. In the scuffle the Ranger manages to retrieve her handaxe and slay the seond leopard as well, but not before it leaves a nasty claw mark across her torso.
~ ranger_injured = true
~ creatures_killed = true
->pass_time
= rogue
"Did I mention I really hate animals?" The rogue grimly draws his daggers. There is a tense moment as the leopards slowly approach. Suddenly the Rogue springs into action, flicking his wrist, he sends a dagger hurtling through the air and into the first leopard's eye. One down. But then the other one is upon him, leaping up and biting into the Rogue's shoulder. He screams, but with his other hand manages to stab into the attacking leopard's belly. It falls to the ground, dead. The Rogue is alive, but clutching at the bite marks in his shoulder.
~ creatures_killed = true
~ rogue_injured = true
->pass_time
= cleric
The Cleric's eyes go wide, but he draws his silver mace and prepares to fight. The leopards approach, but with one heavy swing he manages to bring down the first. As he does so the other cat circles around him and leaps from behind, leaving a nasty claw mark across his back. The Cleric whirls around and takes out the second leopard with a spinning strike, but then falls to one knee in pain. You help him up. He will live, but will be feeling that injury for a while.
~ cleric_injured = true
~ creatures_killed = true
->pass_time
= scholar
The Scholar has more tricks up her sleeve than you might have guessed. She pulls a scroll from her pack and begins reading from it. As she finishes, one of the leopards claws at her and injures her arm, but then a forked bolt of lightning shoots out from the scroll and strikes both creatures dead!
~ scholar_injured = true
~ creatures_killed = true
->pass_time
=finish
->pass_time //HERE


//Once doors are open
===finale
* [Continue]
With one last push, the doors are finally open.
{
    - not creatures_arrived && not creatures_killed: Knowing there is still danger approaching from the forest, you hurridely usher everyone inside. Working together, you close the heavy doors behind you.
    - creatures_arrived && not creatures_killed: "Inside, quickly!" you shout as the hungry leopards pin your group closer and closer to the wall. You dart inside one after another, and working together, <>
    { 
        - ranger_injured && cleric_injured: You attempt to close the doors before the beasts can follow you in. However, with the ranger and the cleric injued your group is not at full strength, and the leopards get one last swipe in--at you--before the doors close. You stumble back in the darkness cluthcing at your left leg, which is now bleeding where the leopard clawed you. Your companions immediately start to bandage you up. You'll live, but you'll also have trouble with that leg for a while.
            ~ player_injured = true
        - ranger_injured: You attempt to close the doors before the beasts can follow you in. However, with the ranger injued your group is not at full strength, and the leopards get one last swipe in--at you--before the doors close. You stumble back in the darkness cluthcing at your left leg, which is now bleeding where the leopard clawed you. Your companions immediately start to bandage you up. You'll live, but you'll also have trouble with that leg for a while.
            ~ player_injured = true
        - cleric_injured: You attempt to close the doors before the beasts can follow you in. However, with the cleric injued your group is not at full strength, and the leopards get one last swipe in--at you--before the doors close. You stumble back in the darkness cluthcing at your left leg, which is now bleeding where the leopard clawed you. Your companions immediately start to bandage you up. You'll live, but you'll also have trouble with that leg for a while.
            ~ player_injured = true
        - else: "Inside, quickly!" you shout as the hungry leopards pin your group closer and closer to the wall. You dart inside one after another, and working together, you manage to slam the heavy doors shut just before the creatures can follow you in.
    }
    - job_101.fire: The fire is now completely consuming the clearing, and you all rush inside to escape it. Shoving the doors closed with all your might, you manage to keep the fire outside.
    - else: With all outside dangers averted for now, your group unhurridely makes their way inside. Working together, you close the heavy doors behind you.
}
You've made it inside, but you are sure far more challenges await you within the vault.
** [Finish.]->results

===results
RESULTS: 

VAR scholar_disarmed_trap = false


{ job_105b.finish:  
    You trusted the Scholar to figure out a use for the magical trap.
    ~scholar_disarmed_trap = true
}
{ job_105a.finish:  
    You disarmed the trap rather than allow the scholar to continue studying it.
    ~scholar_disarmed_trap = false
}
{ job_105a.rogue: You ordered the rogue to deal with the magic despite his wishes. }
{ not creatures_arrived && not job_101.fire:  You made it inside before any dangerous jungle creatures found you.}
{ creatures_arrived && not creatures_killed: You escaped the leopards in the nick of time. }
{ creatures_killed: You fought off or scared away the dangerous creatures in the jungle. }
{ job_101.fire: The Rogue built a fire that started burning out of control.}
{ ranger_injured: The Ranger became injured. }
{ rogue_injured: The Rogue became injured. }
{ cleric_injured: The Cleric became injured. }
{ scholar_injured: The Scholar became injured. }
{ player_injured: You became injured. }

You and your companions made it into the vault.

//*[Next Scene]->trust_explanation
//*[Next Scene]->antechamber

->END


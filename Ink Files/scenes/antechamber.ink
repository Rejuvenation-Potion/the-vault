//INCLUDE tutorial_v2.ink
    
/*
Scene overview: The Antechamber
Objectives:
    - Introduce main goal and motivation (find an artifact to stop the seige of your home city)
    - Introduce neccessary backstory (You are all from different social circles in the same city, 
    - Refelct results of previous scene (injuries, fire, etc)
    - Introduce trust system
    - Introduce story axis system
Structure
- Summary of last scene
- Conversation regarding last scene
- Introduction to new space
- Time to rest?
- Optional conversation with each party member, alone
    - Three conversation hubs per convo
*/

->antechamber


//trust levels
VAR ranger_trust = 5
VAR rogue_trust = 5
VAR cleric_trust = 5
VAR scholar_trust = 5



/*
I don't know if I should display this at all
*/ 
===trust_explanation
 # CLEAR
 (This scene introduces the concept of Trust Levels for each of your companions. For each companion, their trust in you is represented as a number between 0 and 10. From now on, assigning party members to certain tasks may require them to be above a particular trust level; otherwise they may refuse or act against your orders. )
 (At the start of the game, everyone's trust is at 5.)
 {
    - job_105a.finish: (Because you trusted the Scholar to study the magic outside, her trust in you has also increased.)
    ~scholar_trust += 2
    [Scholar Trust increased by 2, now equals {scholar_trust} ]
    
    - job_105b.finish: Since you did not allow the scholar to fully study the magic outside, her trust in you has decreased
    ~scholar_trust -= 2
    (Scholar Trust decreased by 2, now equals {scholar_trust})
 
 }
* [Continue.]->antechamber

===antechamber
/*
With some effort you made it through the exterior doors of the vault. Looking around you find yourself in a small square chamber about 10 feet on each side and 20 feet high. The walls are made of large blocks of blue stone, cool to the touch. Looking up, you see that the ceiling is mostly taken up by a large circular opening with a metal grate across it, through which the sky is visible. The fading light of dusk is the only thing illuminating the room; you see no torches on the walls, nor places for them to rest.

Other than the doors that just closed behind you, the only other way out of this room is a dark passageway cut into the stone directly across from you. The passageway ahead is flanked by two statues of robed figures, each holding a large stone bowl in front of them.

You notice that the Scholar is immediately interested in the stautes, <>
{ 
    - scholar_injured: but as she opens her journal to begin taking notes, she exhales in pain instead. The book falls to the floor as she clutches at the injury she sustained outside. ->rest_decision
    - scholar_trust > 3: .
    - else: and she quickly shoves past you to get a closer look. "I trust you will allow me to do my job."
}

{
    - not rogue_injured: .
    - else: .
}
. 
Above 
{ 
    - not ranger_injured: Test
    - not cleric_injured: 
}
*/
(TEMP) You made it inside.
(TEMP) You are now in a 10x10x20 stone room
(TEMP) There is a skylight above you letting in the fading light of day. No torches or any other source of light.
(TEMP) There is one way out of the room--a dark passageway directly across from you

(TEMP) There are two statues flanking the doorway holding big stone bowls.

{
    - scholar_injured: The scholar wants to study them, but can't due to her injury.->rest_decision.injury
    - scholar_trust > 3: The scholar shares her excitement and goes forward to study them in detail.
    - else: The scholar goes to study the statues and is a jerk about it.
}



* [Continue]->rest_decision

VAR player_knows_brothers = false

===statue_decision
* [Continue]
Ranger questions if Scholar should interact with the statues, wonders about danger.
{
    - not rogue_injured: The rogue joins her and begins picking over the statues for loot. ->rogue
    - else: The rogue makes a snide comment about being injured. ->scholar
}

=scholar
Do you tell the scholar to knock it off?
* "Keep studying."
    (Ranger Trust -1){~ranger_trust -= 1}
    (Scholar Trust +1) {~scholar_trust += 1}
* "Look but don't touch."
    (Scholar Trust +1) {~scholar_trust += 1}
* "We have more important things to worry about right now."
    (Ranger Trust +1){~ranger_trust += 1}
    (Scholar Trust -2) {~scholar_trust -= 2}
* [Stay Silent.]

- ->wrapup

=rogue
{
    - not cleric_injured: Cleric disapproves of his brother's looting
    ~ player_knows_brothers = true
    - else: Cleric looks pained, but might be from his injury
}
The Rogue has pulled himself up over the lip of one of the stone bowls, looking for loot.
The Scholar is poking and prodding at the carved robes of the other statue.
Do you tell one or both of them to knock it off?
* "Keep doing what you're doing!"
    (Ranger Trust -1){~ranger_trust -= 1}
    (Rogue Trust +1){~rogue_trust += 1}
    (Cleric Trust -1){~cleric_trust -= 1}
    (Scholar Trust +1) {~scholar_trust += 1}
* "Both of you, look but don't touch"
    (Ranger Trust +1){~ranger_trust += 1}
    (Cleric Trust +1){~cleric_trust += 1}
    (Scholar Trust +1) {~scholar_trust += 1}
    Rogue says "fine" once reminded of danger
    Scholar says seems prudent, she can do her work mentally.
    Ranger and Cleric are grateful.
* "Rogue, No Looting."
    (Rogue Trust -2){~rogue_trust -= 2}
    (Cleric Trust +2){~cleric_trust += 2}
* Tell the Scholar to stop
    (Ranger Trust +1){~ranger_trust -= 1}
    (Scholar Trust -2) {~scholar_trust -= 2}
* "Both of you, knock it off."
    (Ranger Trust +1){~ranger_trust += 1}
    (Rogue Trust -1){~rogue_trust -= 1}
    (Cleric Trust +1){~cleric_trust += 1}
    (Scholar Trust -1) {~scholar_trust -= 1}

- ->wrapup
=wrapup
~ temp number_injured = 0
{ranger_injured: number_injured++}
{rogue_injured: number_injured++}
{cleric_injured: number_injured++}
{scholar_injured: number_injured++}
{
    - number_injured > 0: ->rest_decision.injury
    - else: ->rest_decision.no_injury
}





/*
Cases are made for and against resting for the night,
and then the player makes a decision
*/
===rest_decision
=no_injury
You could rest here for the night and move forward well rested, or get started now.
Cleric favors rest, wary of the night. Explains healing magic.
Ranger favors rest and caution.
Scholar favors haste.
Rogue favors haste.
* [Rest for the night] ->rest_201
    (Ranger Trust +1){~ranger_trust += 1}
    (Rogue Trust -1){~rogue_trust -= 1}
    (Cleric Trust +1){~cleric_trust += 1}
    (Scholar Trust -2) {~scholar_trust -= 2}
* [Move forward] ->no_rest_201
    (Ranger Trust -1){~ranger_trust -= 1}
    (Rogue Trust +1){~rogue_trust += 1}
    (Cleric Trust -2){~cleric_trust -= 2}
    (Scholar Trust +2) {~scholar_trust += 2}
=injury
You have injured to deal with.
{
    - ranger_injured && not rogue_injured && not cleric_injured && not scholar_injured: Don't stop on my account (favors haste)
    - else: Ranger favors rest strongly
}
{
    - rogue_injured: Yeah don't make me move. (favors rest)
    - else: let's get going (favors haste)
}

{
    - cleric_injured: I always favor rest... ow.
    - else: I always favor rest.
}

{
    - scholar_injured: You think I'll let this slow me down when we've just begun?
    - else: We've just arrived and now you ask me to stop?
}
Scholar asks about healing magic. Isn't it instant?
Cleric says no, it takes a night of rest.
* [Rest for the night] ->rest_201
    {
        - ranger_injured && not rogue_injured && not cleric_injured && not scholar_injured: (Ranger Trust -1){~ranger_trust -= 1}
        - else: (Ranger Trust +1){~ranger_trust += 1}
    }
    {
        - rogue_injured: (Rogue Trust +1){~rogue_trust += 1}
        - else: (Rogue Trust -1){~rogue_trust -= 1}
    }
    (Cleric Trust +2){~cleric_trust += 2}
    (Scholar Trust -2) {~scholar_trust -= 2}

* [Move forward] ->no_rest_201
    {
        - ranger_injured && not rogue_injured && not cleric_injured && not scholar_injured: (Ranger Trust +1){~ranger_trust += 1}
        - else: (Ranger Trust -1){~ranger_trust -= 1}
    }
    {
        - rogue_injured: (Rogue Trust -1){~rogue_trust -= 1}
        - else: (Rogue Trust -1){~rogue_trust += 1}
    }
    (Cleric Trust -2){~cleric_trust -= 2}
    (Scholar Trust +2) {~scholar_trust += 2}

===rest_201
->convos_201

===no_rest_201
->convos_201

/*
The player has an opportunity to converse with whichever companions they wish, learning backstory and affecting trust levels
Answers may differ based on trust levels
For Instance, player can only discover rogue and cleric are brothers if trust is high (trust > 7) with one of them (is that actually possible?)
*/
===convos_201
{
    - convos_201 >= 2: Anyone else?
    - else: This would be a good chance to speak to your companions one on one. Who do you approach?
}
* [Talk to Ranger]->ranger
* [Talk to Ranger]->rogue
* [Talk to Ranger]->cleric
* [Talk to Ranger]->scholar
* [Talk to no one.]->end_scene_201
{
    - convos_201 >= 2: * [No one else.]->end_scene_201
}
=ranger
* What danger are we facing in here?
* 
* That's all.->convos_201
=rogue
->convos_201
=cleric
->convos_201
=scholar
->convos_201

===end_scene_201
{
- rest_201:
    //ALL INJURIES HEALED
    ~ ranger_injured = false
    ~ rogue_injured = false
    ~ cleric_injured = false
    ~ scholar_injured = false
}

->END


/*
Random dialogue

Scholar: No! we stand upon the threshold of discovery and you ask me to delay? I move forward, ever forward.
Rogue: Hey, sooner in sooner out. Get in there, disarm some traps, take some loot, and we're back home before we know it.
Ranger: No, really I'm fine. Or at least I've felt a lot worse than this. No need to stop on my account.
Cleric: Y-yes, that's true, My m-magic speeds up healing immensely. However, it still isn't instantaneous. It also works best pared with a good, full night of rest. For that reason I am certainly in favor of camping for the night.
*/


















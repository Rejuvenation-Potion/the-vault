->intro
=== intro ===
You stand before a large stone structure. This is it, the ancient vault you have been searching for. You are in a small clearing and the vault is just ahead of you. On all other sides you are surrounded by the jungle you navigated to get here.
*   [Continue.]
    Set into the stone wall are two huge stone doors. Your guide, The Ranger, steps forward and studies them.
    "Looks heavy," she says, "but I should be able to get them open."
    ** [Continue.]->char_sheets
- Next Section
    ->END

VAR turnsUntilSunset = 5
VAR myNumber = 5
temp myTemporaryValue = 5

=== char_sheets
Here is what you know of your companions:
The Ranger
Trained in: Strength, Climbing, Survival

The Rogue
Trained in: Climbing, Disarming, Lockpicking

The Cleric
Trained in: Performing Magic, Healing, Ritual

The Scholar
Trained in: Detecting Magic, History, Logic, Speech
- ->player_turn

=== player_turn
/*
= first_turn
Here is where you make your assignment choices.
turnsUntilSunset
* {player_turn > 1}[continue]->first_turn
*/
-> END

=== first_turn
->END


/* 
Allowing multiple assignment basically means 15 possibilities for every choice!!!
16 if you count no one assigned, which I probably should
*/
// Attempt to open the doors
=== job_101
/*
var {yourVariable:
    This is written if yourVariable is true.
  - else:
    Otherwise this is written.
}
{yourVariable: This is written if yourVariable is true|Otherwise this is written}
*/
Someone needs to open those doors.
= ranger
You've assigned the Ranger to the task.
= rogue
You've assigned the Rogue to the task.
= cleric
You've assigned the Cleric to the task.
= scholar
You've assigned the Scholar to the task.

// Climb up and pick the lock
=== job_102
Someone needs to climb up to the top of the doors and unlock that mechanism.
= ranger
You've assigned the Ranger to the task.
{In one swift motion, the Ranger grabs hold of the vines and hoists herself to the top of the wall| The Ranger begins smashing the lock| The Ranger bashes the lock free!}
= rogue
You've assigned the Rogue to the task.
{Alternating between the vines and cracks in the stonework, the rogue deftly makes his way up the wall| The rogue takes out his thieves tools and twirls them around his fingers for a moment. Then he goes to work, his fingers moving faster than you can follow. Before you know it, the lock slides open.}
= cleric
You've assigned the Cleric to the task.
{He retrieves the climbing gear from the Scholar's pack|He climbs up the wall with the climbing gear|He begins smashing the lock with his mace|With one last whack of his mace, the Cleric breaks the lock!}
= scholar
You've assigned the Scholar to the task.
{"Aha! A test of both mind and body!" the Scholar exclaims. She begins rummaging through her pack. "Now where did I put that climbing gear?..."|The Scholar carefully attaches the ropes and pitons, and then steps back to consider the wall. "A good climber knows that plotting the course is half the battle!" she declares to no one in particular. She doesn't seem to be in any hurry.|Finally prepared, the Scholar makes her way up the stone wall|The scholar puts a finger to her temple and studies the locking mechanism as if regarding a clever rival in a game of chess. After a moment she retrieves a hairpin and springs into action. With one simple action, the lock slides open.}

// Open the doors
=== job_103
Now that they are unlocked, someone needs to open those doors.->END
= ranger
You've assigned the Ranger to the task.->END
= rogue
You've assigned the Rogue to the task.->END
= cleric
You've assigned the Cleric to the task.->END
= scholar
You've assigned the Scholar to the task.->END
=finish
->END

// Investigate the magic
=== job_104
Someone needs to figure out what kind of magic has been imbued in these doors.->END
= ranger
You've assigned the Ranger to the task.->END
= rogue
You've assigned the Rogue to the task.->END
= cleric
You've assigned the Cleric to the task.->END
= scholar
You've assigned the Scholar to the task.->END
=finish
->END

// Disarm the magical trap
=== job_105
Someone needs to dispel or disarm this magical trap.->END
= ranger
You've assigned the Ranger to the task.->END
= rogue
You've assigned the Rogue to the task.->END
= cleric
You've assigned the Cleric to the task.->END
= scholar
You've assigned the Scholar to the task.->END
=finish
->END

// Keep watch for dangers from the jumgle
=== job_106
Someone needs to watch your backs; the sun is setting and the jungle is dangerous.->END
= ranger
You've assigned the Ranger to the task.->END
= rogue
You've assigned the Rogue to the task.->END
= cleric
You've assigned the Cleric to the task.->END
= scholar
You've assigned the Scholar to the task.->END
=finish
->END

// Keep the dangerous creatures at bay
=== job_107
Someoned needs to keep the danger at bay!->END
= ranger
You've assigned the Ranger to the task.->END
= rogue
You've assigned the Rogue to the task.->END
= cleric
You've assigned the Cleric to the task.->END
= scholar
You've assigned the Scholar to the task.->END
=finish
->END

//Close the doors
=== job_108
Close the doors to keep out the dangerous animals->END
= ranger
You've assigned the Ranger to the task.->END
= rogue
You've assigned the Rogue to the task.->END
= cleric
You've assigned the Cleric to the task.->END
= scholar
You've assigned the Scholar to the task.->END
=finish
->END






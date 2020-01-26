Low Health regen mod
r1 - 2016-03-28
by tin man tex

This small mod decreases the player health regen.

The original values:
lifeRecoveryPerSecond: 1000
lifeRecoveryCooldownTimer: 2

The modded values:
lifeRecoveryPerSecond: 100
lifeRecoveryCooldownTimer: 20

The mod can be installed along-side Infinite Heaven.

Editing:
Extract the .mgsv with a zip tool
Extract \Assets\tpp\pack\player\game_object\single_player_game_obj.fpkd with GzsTool
Decompile \Assets\tpp\pack\player\game_object\single_player_game_obj_fpkd\Assets\tpp\level_asset\chara\player\game_object\single_player_game_obj.fox2
Find and edit the values mentioned above.

Recompile the .fox2.xml
Recompile the fpkd with GzsTool
Rezip the .mgsv with a zip tool
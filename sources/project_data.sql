USE PFMonsters;


INSERT INTO Creature 
	VALUES 
	('Goblin', '1d10+1', '1d4', '1d4', 16, 'Small', 'Goblinoid'),
	('Hell Hound', '4d10+8', '1d8+1 plus 1d6 fire', NULL, 16, 'Medium', 'Outsider'),
	('Golem, Ice', '6d10+20', '1d6+3 plus 1d6 cold', NULL, 17, 'Medium', 'Construct'),
	('Violet Fungus', '4d8+12', '1d4+1 plus rot', NULL, 15, 'Medium', 'Plant'),
	('Nymph', '8d6+32', '1d4', NULL, 23, 'Medium', 'Fey'),
	('Centaur', '4d10+8', '1d8+2', '1d8+2', 20, 'Large', 'Monstrous Humanoid');
	
INSERT INTO CreatureInstance (CurrentHP, MaxHP, Alignment, CreatureID) 
	VALUES
	(6,	6,	'NE',	'Goblin'),
	(10,	10,	'NE',	'Goblin'),
	(0,	5,	'NE',	'Goblin'),
	(38,	49,	'N',	'Golem, Ice'),
	(22,	22,	'LE',	'Centaur'),
	(15,	26,	'N',	'Centaur');

INSERT INTO Ability 
	VALUES
	('Cold', 'Ex'),
	('Icy Destruction', 'Ex'),
	('Immunity to Magic', 'Ex'),
	('Undersized Weapons', 'Ex');
	
INSERT INTO CreatureAbility
	VALUES
	('Golem, Ice', 'Cold'),
	('Golem, Ice', 'Icy Destruction'),
	('Golem, Ice', 'Immunity to Magic'),
	('Centaur', 'Undersized Weapons');

INSERT INTO AbilityEffect (AbilityName, Effect)
	VALUES
	('Cold', '1d6 cold damage on touch, incl. unarmed or natural attacks'),
	('Icy Destruction',	'3d6 slashing damage in 10 foot burst'),
	('Icy Destruction',	'2d6 cold damage in 10 foot burst'),
	('Immunity to Magic', 'Immune to any spell or spell-like ability excluding those that the fire descriptor'),
	('Immunity to Magic', 'Magical attack that does electricity damage slows for 2d6 rounds'),
	('Immunity to Magic', 'A magical attack that deals cold damage breaks any slow effect and heals 1 point for every 3 points of damage the attack would deal.'),
	('Undersized Weapons', 'Wields weapons as if they were one size category smaller');
	
INSERT INTO CreatureType
	VALUES
	('Goblinoid'),
	('Outsider'),
	('Construct'),
	('Animal'),
	('Monstrous Humanoid'),
	('Fey');
	
INSERT INTO TypeImmunity (TypeName, Immunity)
	VALUES
	('Construct',	'Mind-Affecting'),
	('Construct',	'Abilities requiring fort save'),
	('Construct',	'Bleed'),
	('Construct',	'Death effect'),
	('Construct',	'Paralysis'),
	('Construct',	'Poison'),
	('Construct',	'Sleep'),
	('Construct',	'Stun'),
	('Plant',	'Paralysis'),
	('Plant',	'Poison'),
	('Plant',	'Polymorph'),
	('Plant',	'Sleep'),
	('Plant',	'Stun');




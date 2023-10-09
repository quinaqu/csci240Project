Database of:
* Creature
	- CreatureName (PK)
	- HP
	- MeleeDmg
	- RangedDmg
	- AC
	- Size

* CreatureInstance
	- InstanceID (PK)
 	- CurrentHP
  	- MaxHP
   	- Alignment
   	- Creature (FK)

* Type
	- TypeName (PK)

* Type.Immunity
  	- ImmunityID (PK)
  	- TypeName (FK)
  	- Immunity
* Ability
	- AbilityName (PK)
	- AbilityType

* Ability.Effect
  	- EffectID (PK)
  	- AbilityName (FK)
  	- Effect
  
* CreatureAbility
  	- CreatureName (CPK)
  	- AbilityName (CPK)

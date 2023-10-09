[Link to ERD](https://lucid.app/lucidchart/aed0ec57-cb75-4fe5-92eb-0cdc902ed0e3/edit?viewport_loc=-203%2C-44%2C2325%2C1052%2C0_0&invitationId=inv_4d3c9e9e-a972-4fa6-9524-643033c0c8f9 "ERD on Lucidchart")

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

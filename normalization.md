Added:
* InstanceID as primary key for CreatureInstance
* EffectID as primary key for Ability.EffectID
* ImmunityID as primary key for Type.Immunity 

Considered adding a MeleeDmg2 column to contain "plus" values but it isn't actually something
separate from the damage calculation so I feel it is atomic for this case (Retitling it FullMeleeDmg might fit more accurately but seems unnecessary).
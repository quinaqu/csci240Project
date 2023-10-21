ALTER TABLE Creature
	ADD CONSTRAINT fk_types
	FOREIGN KEY (PrimaryType) REFERENCES CreatureType (TypeName);
	
ALTER TABLE CreatureInstance
	ADD CONSTRAINT fk_creatureid
	FOREIGN KEY (CreatureID) REFERENCES Creature (CreatureName);
	
ALTER TABLE CreatureAbility
	ADD CONSTRAINT fk_creaturename
	FOREIGN KEY (CreatureName) REFERENCES Creature (CreatureName);
	
ALTER TABLE CreatureAbility
	ADD CONSTRAINT fk_creatureability
	FOREIGN KEY (AbilityName) REFERENCES Ability (AbilityName);
	
ALTER TABLE AbilityEffect
	ADD CONSTRAINT fk_abilityname
	FOREIGN KEY (AbilityName) REFERENCES Ability (AbilityName);
	
ALTER TABLE TypeImmunity
	ADD CONSTRAINT fk_typename
	FOREIGN KEY (TypeName) REFERENCES CreatureType (TypeName);
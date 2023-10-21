DROP DATABASE IF EXISTS PFMonsters;
CREATE DATABASE PFMonsters;
USE PFMonsters;


CREATE TABLE CreatureType (
	TypeName VARCHAR(25) NOT NULL,
	PRIMARY KEY (TypeName)
);

CREATE TABLE Ability (
	AbilityName VARCHAR(30) NOT NULL,
	AbilityType VARCHAR(2) CHECK (
		AbilityType IN ('Ex','Sp','Su')),
	PRIMARY KEY (AbilityName)
);

CREATE TABLE Creature (
	CreatureName VARCHAR(30) NOT NULL,
	HP VARCHAR(10) NOT NULL,
	MeleeDmg VARCHAR(25),
	RangeDmg VARCHAR(25),
	AC SMALLINT UNSIGNED,
	SizeType VARCHAR(20) NOT NULL CHECK (
		SizeType IN (
			'Fine',
			'Diminutive',
			'Tiny',
			'Small',
			'Medium',
			'Large',
			'Huge',
			'Gargantuan',
			'Colossal')),
	PrimaryType VARCHAR(25),
	PRIMARY KEY (CreatureName)
);

CREATE TABLE CreatureInstance (
	InstanceID SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
	CurrentHP SMALLINT NOT NULL,
	MaxHP SMALLINT UNSIGNED NOT NULL,
	Alignment VARCHAR(2) CHECK (
		Alignment IN ('LG','LN','LE','NG','N','NE','CG','CN','CE')),
	CreatureID VARCHAR(30) NOT NULL,
	PRIMARY KEY (InstanceID)
);


CREATE TABLE CreatureAbility (
	CreatureName VARCHAR(30) NOT NULL,
	AbilityName VARCHAR(30) NOT NULL,
	PRIMARY KEY (CreatureName, AbilityName)
);

CREATE TABLE AbilityEffect (
	EffectID SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
	AbilityName VARCHAR(30) NOT NULL,
	Effect TEXT NOT NULL,
	PRIMARY KEY (EffectID)
);



CREATE TABLE TypeImmunity (
	ImmunityID SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
	TypeName VARCHAR(25) NOT NULL,
	Immunity TEXT NOT NULL,
	PRIMARY KEY (ImmunityID)
);


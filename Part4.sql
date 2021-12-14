-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema mtgdeck
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mtgdeck
-- -----------------------------------------------------

DROP DATABASE IF EXISTS mtgdeck;
CREATE SCHEMA IF NOT EXISTS `mtgdeck` DEFAULT CHARACTER SET utf8 ;
USE `mtgdeck` ;

-- -----------------------------------------------------
-- Table `mtgdeck`.`card_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mtgdeck`.`card_type` (
  `card_type_id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`card_type_id`),
  UNIQUE INDEX `card_type_id_UNIQUE` (`card_type_id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mtgdeck`.`card`
-- -----------------------------------------------------
drop table if Exists card;
CREATE TABLE IF NOT EXISTS `mtgdeck`.`card` (
  `card_id` INT NOT NULL AUTO_INCREMENT,
  `flavor_text` VARCHAR(300) NULL DEFAULT NULL,
  `power_toughness` VARCHAR(5) NULL DEFAULT NULL,
  `name_of_card` VARCHAR(25) NOT NULL,
  `picture` BLOB NULL DEFAULT NULL,
  `flip_card` CHAR(1) NOT NULL,
  `total_cost` INT Not Null,
  `card_type_id` INT NOT NULL,
  PRIMARY KEY (`card_id`),
  UNIQUE INDEX `card_id_UNIQUE` (`card_id` ASC) VISIBLE,
  INDEX `fk_card_card_type1_idx` (`card_type_id` ASC) VISIBLE,
  CONSTRAINT `fk_card_card_type1`
    FOREIGN KEY (`card_type_id`)
    REFERENCES `mtgdeck`.`card_type` (`card_type_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mtgdeck`.`card_description`
-- -----------------------------------------------------
Drop table if exists card_description;
CREATE TABLE IF NOT EXISTS `mtgdeck`.`card_description` (
  `card_description_id` INT NOT NULL AUTO_INCREMENT,
  `etb_effect` VARCHAR(300) NULL DEFAULT NULL,
  `abilities` VARCHAR(300) NULL DEFAULT NULL,
  `anthom` VARCHAR(500) NULL DEFAULT NULL,
  `key_words` VARCHAR(200) NULL,
  `combat_trigger` VARCHAR(500) NULL DEFAULT NULL,
  `card_id` INT NOT NULL,
  PRIMARY KEY (`card_description_id`),
  UNIQUE INDEX `card_description_id_UNIQUE` (`card_description_id` ASC) VISIBLE,
  INDEX `fk_card_description_card_idx` (`card_id` ASC) VISIBLE,
  CONSTRAINT `fk_card_description_card`
    FOREIGN KEY (`card_id`)
    REFERENCES `mtgdeck`.`card` (`card_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mtgdeck`.`creature_type`
-- -----------------------------------------------------
Drop table if exists creature_type;
CREATE TABLE IF NOT EXISTS `mtgdeck`.`creature_type` (
  `creature_type_id` INT NOT NULL AUTO_INCREMENT,
  `creature` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`creature_type_id`),
  UNIQUE INDEX `creature type_col_UNIQUE` (`creature` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mtgdeck`.`card_has_creature_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mtgdeck`.`card_has_creature_type` (
  `card_id` INT NOT NULL,
  `creature_type_id` INT NOT NULL,
  PRIMARY KEY (`card_id`, `creature_type_id`),
  INDEX `fk_card_has_creature_type_creature_type1_idx` (`creature_type_id` ASC) VISIBLE,
  INDEX `fk_card_has_creature_type_card1_idx` (`card_id` ASC) VISIBLE,
  CONSTRAINT `fk_card_has_creature_type_card1`
    FOREIGN KEY (`card_id`)
    REFERENCES `mtgdeck`.`card` (`card_id`),
  CONSTRAINT `fk_card_has_creature_type_creature_type1`
    FOREIGN KEY (`creature_type_id`)
    REFERENCES `mtgdeck`.`creature_type` (`creature_type_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mtgdeck`.`mana`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mtgdeck`.`mana` (
  `mana_id` INT NOT NULL AUTO_INCREMENT,
  `mana_color` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`mana_id`),
  UNIQUE INDEX `mana_id_UNIQUE` (`mana_id` ASC) VISIBLE,
  UNIQUE INDEX `mana_color_UNIQUE` (`mana_color` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mtgdeck`.`color_identity`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `mtgdeck`.`color_identity_or_produce` (
  `card_id` INT NOT NULL,
  `mana_id` INT NOT NULL,
  PRIMARY KEY (`card_id`, `mana_id`),
  INDEX `fk_card_has_mana_mana1_idx` (`mana_id` ASC) VISIBLE,
  INDEX `fk_card_has_mana_card1_idx` (`card_id` ASC) VISIBLE,
  CONSTRAINT `fk_card_has_mana_card1`
    FOREIGN KEY (`card_id`)
    REFERENCES `mtgdeck`.`card` (`card_id`),
  CONSTRAINT `fk_card_has_mana_mana1`
    FOREIGN KEY (`mana_id`)
    REFERENCES `mtgdeck`.`mana` (`mana_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



-- -----------------------Inserts----------------------------------------------------------------------------------------------------------------------------------------------------------------

Insert Into mana(mana_id, mana_color)
Values 
	(Default, "Any Color"),
    (Default, "White"),
	(Default, "Blue"),
    (Default, "Black"),
    (Default, "Red"),
    (Default, "Green"),
    (Default, "Colorless");
    
Insert Into creature_type(creature_type_id, creature)
Values
	(Default, "Dragon"),
    (Default, "Avatar"),
    (Default, "Elder"),
    (Default, "Goblin"),
    (Default, "Human"),
    (Default, "Barbarian"),
    (Default, "Shaman"),
    (Default, "Kobold"),
    (Default, "Zombie"),
    (Default, "Shapeshifter"),
    (Default, "Treefolk"),
    (Default, "Druid");
    
Insert Into card_type (card_type_id, type)
Values 
	(Default, "Creature"),
    (Default, "Artifact"),
    (Default, "Land"),
    (Default, "Instant"),
    (Default, "Sorcery"),
    (Default, "Enchantment");
    
Insert Into card (card_id, flavor_text, power_toughness, name_of_card, picture, flip_card, total_cost, card_type_id)
Values
	(default, Null, "10/10", "The Ur-Dragon", Null, "N", 9, 1),
    (default, "The blademaster turned his fury to his new foes: root rot and cabbage slugs.", Null, "Swords to Plowshares", Null, "N", 1, 4),
    (default, Null, Null , "Dragon Tempest", Null, "N",2, 6),
    (default, Null, Null, "Nyx lotus", Null, "N",4, 2),
    (default, "That which endures, survives.", Null, "Sandsteppe Citadel", Null, "N",0, 3),
    (default, "Its wide-reaching roots draw more than water", "0/0", "Faeburrow Elder", Null, "N",3, 1),
    (default, Null, "4/4", "Bladewing the Risen", Null, "N",7, 1),
    (default, Null, Null, "Savai Triome", Null, "N",0, 3),
    (default, Null, Null, "Branchloft Pathway", Null, "Y",0, 3),
    (default, "When defeat is near and guidance iss scarce, all eyes look in one direction.", Null, "Command Tower", Null, "N",0, 3),
    (default, "Those who bring nothing to the temple take nothing away", Null, "Temple of the False God", Null, "N",0, 3),
    (default, "Dromoka's followers forsakew blood ties so that they may join a greater family", "5/7", "Dragonlord Dromoka", Null, "N",6, 1),
    (default, Null, "0/1", "Minion of the Mighty", Null, "N",1, 1),
    (default, "We speak the dragons' language of flame and rage. They speak our language of fury and honor. Together we shall weave a tale of destruction without equal",
    "2/2", "Dragonspeaker Shaman", Null, "N",3, 1),
    (default, "This world will be ruled by its rightful sovereigns, not these hideous pretenders.", "1/1", "Dragonmaster outcast", Null, "N",1, 1),
    (default, Null, "2/3", "Realmwalker", Null, "N",3, 1),
    (default, Null, "1/3", "Dragonlord's Servant", Null, "N",2, 1),
    (default, Null, Null, "Boros Charm", Null, "N",2, 4),
    (default, Null, Null, "Counterspell", Null, "N",2, 4),
    (default, Null, Null, "Kodama's Reach", Null, "N",3, 5),
    (default, Null, Null, "Regrowth", Null, "N",2, 5),
    (default, Null, Null, "Crux of fate", Null, "N",5, 5),
    (default, "All are prey to the eyes of the wild", Null, "Lurking Predators", Null, "N",6, 6),
    (default, Null, Null, "Fist of Suns", Null, "N",3, 2),
    (default, Null, Null, "Maskwood Nexus", Null, "N",4, 2),
    (default, Null, Null, "Sol Ring", Null, "N",1, 2);
    
Insert Into card_description (card_description_id, etb_effect, abilities, anthom, key_words, combat_trigger, card_id)
Values
	(Default,Null, Null, "Dragon spells you cast cost 1 less to cast.", "Flying", "Whenever one or more Dragons you control attack, draw that many cards, then you may put a permanent card from your hand onto the battlefield.", 1 ),
    (Default, "Exile target creature. Its controller gains life equal to its power.", Null, Null, Null, Null, 2),
    (Default, Null, Null, "Whenever a creature with flying enters the battlefield under your control, it gains haste until the end of turn.
    Whenever a Dragon enters the battlefield under your control, it deals X damage to target creature or player, where X is the number of Dragons you control.", Null, Null, 3),
    (Default, "Nyx Lotus enters the battlefield tapped.", "T: Choose a color. Add an amount of mana of that color equal to your devotion to that color.
    (Your devotion is the number of mana symbols of that color in the mana costs of permanents you control.)", Null, Null, Null, 4),
    (Default, "Sandsteppe Citadel enters the battlefield tapped", "T: Add W, B, or G to your mana pool.", Null, Null, Null, 5),
    (Default,"Faeburrow Elder gets +1/+1 for each color among permanents you control.", "T: For each color among permanents you control, add one mana of that color.", Null, "Vigilance" , Null, 6),
    (Default, "When Bladewing the Risen enters the battlefield, you may return target Dragon permanent card from your graveyard to the battlefield.", "BR: Dragon creatures get +1/+1 until end of turn.", Null, "Flying", Null, 7),
    (Default, "Savai Triome enters the battlefield tapped.", "T: Add R, W, or B. & Cycling 3", Null, Null, NUll, 8),
    (Default, Null, "T: Add W. OR T: Add G.", Null, Null, Null, 9),
    (Default, Null, "T: Add one mana of any color in your commander's color identity.", Null, Null, Null, 10),
    (Default, Null, "T: Add CC. Activate this ability only if you control five or more lands.", Null, Null, Null, 11),
    (Default, "Dragonlord Dromoka can't be countered.", Null, "Your opponents can't cast spells during your turn.", "Flying, lifelink", Null, 12),
    (Default, Null, Null, Null, "Menace", "Pack tactics — Whenever Minion of the Mighty attacks, if you attacked with creatures with total power 6 or greater this combat, 
    you may put a Dragon creature card from your hand onto the battlefield tapped and attacking.", 13),
    (Default, Null, Null,"Dragon spells you cast cost 2 less to cast.", Null, Null, 14),
    (Default, Null, Null, "At the beginning of your upkeep, if you control six or more lands, put a 5/5 red Dragon creature token with flying onto the battlefield.", Null, Null, 15),
    (default, "As Realmwalker enters the battlefield, choose a creature type.", Null, "You may look at the top card of your library any time. & You may cast creature spells of the chose type from the top of your library.", "Changeling (This card is every creature type.)", Null, 16),
    (Default, Null, Null, "Dragon spells you cast cost 1 less to cast.", Null, Null, 17),
    (Default, "Choose one — 1.Boros Charm deals 4 damage to target player or planeswalker. 2.Permanents you control gain indestructible until end of turn; 3. Target creature gains double strike until end of turn.", NUll, Null, Null, Null, 18),
    (Default, "Counter Target spell", Null, Null, Null, Null, 19),
    (Default, "Search your library for up to two basic land cards, reveal those cards, and put one onto the battlefield tapped and the other into your hand. Then shuffle your library.", Null, Null, nULL, Null, 20),
    (Default, "Return target card from your graveyard to your hand", Null, Null, Null, Null, 21),
	(Default, "Choose one — 1.Destroy all Dragon creatures 2.Destroy all non-Dragon creatures." , Null, Null, Null, Null, 22),
    (Default, Null, Null, "Whenever an opponent casts a spell, reveal the top card of your library. If it’s a creature card, put it onto the battlefield. Otherwise, you may put that card on the bottom of your library.", Null, Null, 23),
    (Default, Null, Null, "You may pay WUBRG rather than pay the mana cost for spells you cast.", Null, Null, 24),
    (Default, Null, "3, T: Create a 2/2 blue Shapeshifter creature token with changeling. (It is every creature type.)", "Creatures you control are every creature type. The same is true for creatures spells you control and creature cards you own that aren't on the battlefield.", Null, Null, 25),
    (Default, Null, "T: Add CC.", Null, Null, Null, 26);
    
Insert Into color_identity_or_produce (card_id, mana_id)
Values
	(1,2),
    (1,3),
    (1,4),
    (1,5),
    (1,6),
    -- ---------------
    (2,2),
    -- ----------------
    (3,5),
    -- ---------------
    (4,7),
    -- -----------------
    (5,2), 
    (5,4),
    (5,5),
    -- -----------------
    (6,2),
    (6,6),
    -- ------------------
    (7,4),
    (7,5),
    -- ----------------
    (8,2),
    (8,4),
    (8,5),
    -- ----------------
    (9,2),
    (9,6),
    -- ------------------
    (10,1),
    -- -----------------
    (11,7),
    -- ---------------
    (12,2),
    (12,6),
    -- -----------------
    (13,5),
    -- ------------------
    (14,5),
    -- -----------------
    (15,5),
    -- ----------------
    (16,6),
    -- -------------
    (17,5),
    -- ------------------
    (18,2),
    (18,5),
    -- ------------------
    (19,3),
    -- ----------------
    (20,6),
    -- -----------
    (21,6),
    -- -----------------
    (22,4),
    -- -----------------
    (23,6),
    -- ----------------
    (24,7),
    -- --------------
    (25,7),
    -- -------------
    (26,7);
    
Insert into card_has_creature_type (card_id, creature_type_id)
Values
	(1,1),
    (1,2),
    -- --------
    (6,11),
    (6,12),
    -- -------
    (7,9),
    (7,1),
    -- -------
    (12,1),
    (12,3),
    -- ---------
    (13,8),
    -- ----------
    (14,5),
    (14,6),
    (14,7),
    -- --------
    (15,5),
    (15,7),
    -- ---------
    (16,10),
    -- -------
    (17,4),
    (17,5);
    
   -- -------------------- SELECT --------------------------------------------------------------------------------
   Use mtgdeck;
   Select name_of_card, total_cost, type
   From card c
	Join card_type ct
		On c.card_type_id = ct.card_type_id
	Where total_cost > 5;
   
Select name_of_card, total_cost, mana_color
   From card c
	Join color_identity_or_produce ci
		On c.card_id = ci.card_id
	Join mana m 
		On m.mana_id = ci.mana_id
	Where name_of_card = "The Ur-Dragon";



SELECT name_of_card, CONCAT_WS( ",", Black, Blue, Green, Red, White) AS "Card Color Identity"
FROM(

	SELECT name_of_card, total_cost,
    CASE WHEN EXISTS (SELECT * FROM color_identity_or_produce ci
						JOIN mana m ON m.mana_id = ci.mana_id
                        WHERE ci.card_id = c.card_id
                        AND mana_color = "Black") THEN "Black"
				ELSE ""
		END AS "Black",
	CASE WHEN EXISTS (SELECT * FROM color_identity_or_produce ci
						JOIN mana m ON m.mana_id = ci.mana_id
                        WHERE ci.card_id = c.card_id
                        AND mana_color = "Blue") THEN "Blue"
				ELSE ""
		END AS "Blue",
	CASE WHEN EXISTS (SELECT * FROM color_identity_or_produce ci
						JOIN mana m ON m.mana_id = ci.mana_id
                        WHERE ci.card_id = c.card_id
                        AND mana_color = "Green") THEN "Green"
				ELSE ""
		END AS "Green",
	CASE WHEN EXISTS (SELECT * FROM color_identity_or_produce ci
						JOIN mana m ON m.mana_id = ci.mana_id
                        WHERE ci.card_id = c.card_id
                        AND mana_color = "Red") THEN "Red"
				ELSE ""
		END AS "Red",
	CASE WHEN EXISTS (SELECT * FROM color_identity_or_produce ci
						JOIN mana m ON m.mana_id = ci.mana_id
                        WHERE ci.card_id = c.card_id
                        AND mana_color = "White") THEN "White"
				ELSE ""
		END AS "White"
	From card c
        );

Select name_of_card, combat_trigger
From card c
	join card_description cd
		On c.card_id = cd.card_id
Where combat_trigger is not Null;

Select name_of_card, type, creature
From card c
	Join card_type ct
		On c.card_type_id = ct.card_type_id
	Join card_has_creature_type cct
		On cct.card_id = c.card_id
	Join creature_type cty
		ON cct.creature_type_id = cty.creature_type_id
Where type = "Creature";


-- ----------------------------------------UPDATE--------------------------------------------------------------------------------------------------------------------------------------

Update card
Set picture = "png-File"
Where card_id = 1;

Update card_description
Set anthom = "Dragons 1 Less"
Where card_id = 1;

Update card_type
Set type = "Instants"
Where card_type_id = 4;

Update creature_type
Set creature = "DraGon"
Where creature_type_id = 1;

Update mana
Set mana_color = "ColorLess"
Where mana_id = 7;

-- ---------------------------------------DELETE----------------------------------------------------------------------------------------------------------------------------------
Delete 
From card
Where flip_card = "Y";

Delete 
From card_description_id
Where card_id = 9;

Delete 
From card_type
Where card_type_id = 6;
        
Delete
From creature_type
Where creature_type_id = 9;

Delete 
From mana
WHere mana_id = 7;

Delete 
From color_identity_or_produce
Where mana_id = 7;

Delete
From card_has_creature_type
Where card_type_id = 9;


        
        
        
        
        
        
        
        
        
        
    
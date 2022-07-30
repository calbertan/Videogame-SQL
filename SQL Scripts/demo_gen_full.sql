CREATE TABLE Publisher
( 
  name CHAR(30),
  headquarters CHAR(30) NOT NULL,
  staff_Count INT NOT NULL,
  PRIMARY KEY (name)
);

CREATE TABLE VG_Company
( 
  name CHAR(30),
  origin CHAR(30) NOT NULL,
  PRIMARY KEY (name)
);

CREATE TABLE Company_Publisher_Videogame
( 
  vg_Title CHAR(30),
  release_Date DATE,
  age_Rating INT,
  pub_Name CHAR(30),
  company_Name CHAR(30),
  PRIMARY KEY (vg_Title, pub_Name, company_Name),
  FOREIGN KEY (pub_Name) REFERENCES Publisher(name) ON DELETE CASCADE,
  FOREIGN KEY (company_Name) REFERENCES VG_Company(name) ON DELETE CASCADE
);

CREATE TABLE Genre
(
  name CHAR(30) PRIMARY KEY
);

CREATE TABLE Crossover_With
( 
  vg_Title_A CHAR(30),
  pub_Name_A CHAR(30),
  company_Name_A CHAR(30),
  vg_Title_B CHAR(30),
  pub_Name_B CHAR(30),
  company_Name_B CHAR(30),
  PRIMARY KEY (vg_Title_A, pub_Name_A, company_Name_A, 
    vg_Title_B, pub_Name_B, company_Name_B),
  FOREIGN KEY (vg_Title_A, pub_Name_A, company_Name_A) REFERENCES 
    Company_Publisher_Videogame(vg_Title, pub_Name, company_Name) ON DELETE CASCADE,
  FOREIGN KEY (vg_Title_B, pub_Name_B, company_Name_B) REFERENCES 
    Company_Publisher_Videogame(vg_Title, pub_Name, company_Name) ON DELETE CASCADE
);

CREATE TABLE Categorized_in
( 
  gen_Name CHAR(30),
  vg_Title CHAR(30),
  pub_Name CHAR(30),
  company_Name CHAR(30),
  PRIMARY KEY (gen_Name, vg_Title, pub_Name, company_Name),
  FOREIGN KEY (gen_Name) REFERENCES Genre(name) ON DELETE NO ACTION,
  FOREIGN KEY (vg_Title, pub_Name, company_Name) REFERENCES
    Company_Publisher_Videogame(vg_Title, pub_Name, company_Name) ON DELETE CASCADE
);

CREATE TABLE ip
(
  ip_Name CHAR(30) PRIMARY KEY
);

CREATE TABLE Licensed_By
( 
  vg_Title CHAR(30),
  pub_Name CHAR(30),
  company_Name CHAR(30),
  ip_Name CHAR(30),
  FOREIGN KEY (ip_Name) REFERENCES ip(ip_Name) ON DELETE CASCADE,
  FOREIGN KEY (vg_Title, pub_Name, company_Name) REFERENCES
    Company_Publisher_Videogame(vg_Title, pub_Name, company_Name) ON DELETE CASCADE
);

CREATE TABLE Video_Game_Reviewer
(
  ID INT PRIMARY KEY
);

CREATE TABLE General_Audience
(
  reviewer_ID INT,
  age INT,
  PRIMARY KEY (reviewer_ID),
  FOREIGN KEY (reviewer_ID) REFERENCES Video_Game_Reviewer(ID) ON DELETE CASCADE
);

CREATE TABLE Game_Critic
(
  reviewer_ID INT,
  organization CHAR(30),
  PRIMARY KEY (reviewer_ID),
  FOREIGN KEY (reviewer_ID) REFERENCES Video_Game_Reviewer(ID) ON DELETE CASCADE
);

CREATE TABLE Reviewed_By
(
  review_Score INT,
  vg_Title CHAR(30),
  pub_Name CHAR(30),
  company_Name CHAR(30),
  reviewer_ID INT,
  PRIMARY KEY (vg_Title, pub_Name, company_Name, reviewer_ID),
  FOREIGN KEY (reviewer_ID) REFERENCES Video_Game_Reviewer(ID) ON DELETE CASCADE,
  FOREIGN KEY (vg_Title, pub_Name, company_Name) REFERENCES
    Company_Publisher_Videogame(vg_Title, pub_Name, company_Name) ON DELETE CASCADE
);

CREATE TABLE Consumer
(
  name CHAR(20),
  ID INT,
  age INT,
  PRIMARY KEY (ID)
);

CREATE TABLE Plays
(
  consumer_ID INT,
  hours_Played INT,
  vg_Title CHAR(30),
  pub_Name CHAR(30),
  company_Name CHAR(30),
  PRIMARY KEY (consumer_ID, vg_Title, company_Name, pub_Name),
  FOREIGN KEY (consumer_ID) REFERENCES Consumer(ID) ON DELETE CASCADE,
  FOREIGN KEY (vg_Title, pub_Name, company_Name) REFERENCES
    Company_Publisher_Videogame(vg_Title, pub_Name, company_Name) ON DELETE CASCADE
);

CREATE TABLE Platform
(
  name CHAR(20),
  discontinued INT,
  company CHAR(20) NOT NULL,
  PRIMARY KEY (name)
);

CREATE TABLE Available_On
(
  platform_Name CHAR(20),
  vg_Title CHAR(30),
  pub_Name CHAR(30),
  company_Name CHAR(30),
  PRIMARY KEY (platform_Name, vg_Title, pub_Name, company_Name),
  FOREIGN KEY (platform_Name) REFERENCES Platform(name) ON DELETE CASCADE,
  FOREIGN KEY (vg_Title, pub_Name, company_Name) REFERENCES
    Company_Publisher_Videogame(vg_Title, pub_Name, company_Name) ON DELETE CASCADE
);

CREATE TABLE Influences
(
  consumer_ID INT,
  reviewer_ID INT,
  PRIMARY KEY (consumer_ID, reviewer_ID),
  FOREIGN KEY (consumer_ID) REFERENCES Consumer(ID) ON DELETE CASCADE,
  FOREIGN KEY (reviewer_ID) REFERENCES Video_Game_Reviewer(ID) ON DELETE CASCADE
);

CREATE TABLE Plays_On
(
  consumer_ID INT,
  platform_Name CHAR(20),
  PRIMARY KEY (consumer_ID, platform_Name),
  FOREIGN KEY (consumer_ID) REFERENCES Consumer(ID) ON DELETE CASCADE,
  FOREIGN KEY (platform_Name) REFERENCES Platform(name) ON DELETE CASCADE
);

CREATE TABLE Game_Awards
(
  year INT,
  vg_Title CHAR(30),
  pub_Name CHAR(30),
  company_Name CHAR(30),
  PRIMARY KEY (year, vg_Title, pub_Name, company_Name),
  FOREIGN KEY (vg_Title, pub_Name, company_Name) REFERENCES
    Company_Publisher_Videogame(vg_Title, pub_Name, company_Name) ON DELETE CASCADE
);

CREATE TABLE Nominations
(
  game_Award_Year INT,
  award_Category CHAR(30),
  vg_Title CHAR(30),
  pub_Name CHAR(30),
  company_Name CHAR(30),
  PRIMARY KEY (game_Award_Year, vg_Title, pub_Name, company_Name),
  FOREIGN KEY (game_Award_Year) REFERENCES Game_Awards(year) ON DELETE CASCADE,
  FOREIGN KEY (vg_Title, pub_Name, company_Name) REFERENCES
    Company_Publisher_Videogame(vg_Title, pub_Name, company_Name) ON DELETE CASCADE
);

CREATE TABLE Won_At
(
  game_Award_Year INT,
  award_Category CHAR(30),
  vg_Title CHAR(30),
  pub_Name CHAR(30),
  company_Name CHAR(30),
  PRIMARY KEY (game_Award_Year, vg_Title, pub_Name, company_Name),
  FOREIGN KEY (game_Award_Year) REFERENCES Game_Awards(year) ON DELETE CASCADE,
  FOREIGN KEY (vg_Title, pub_Name, company_Name) REFERENCES
    Company_Publisher_Videogame(vg_Title, pub_Name, company_Name) ON DELETE CASCADE
);

CREATE TABLE Game_Code_1
(
  level_Style CHAR(30),
  genre CHAR(20),
  PRIMARY KEY (level_Style)
);

CREATE TABLE Game_Code_2
(
  vg_Title CHAR(30),
  level_Style CHAR(30),
  multiplayer BOOLEAN,
  PRIMARY KEY (vg_Title),
  FOREIGN KEY (level_Style) REFERENCES Game_Code_1(level_Style) ON DELETE CASCADE
);

CREATE TABLE Game_Code_3
(
  min_Processor_Speed FLOAT,
  memory_Requirement INT,
  PRIMARY KEY (min_Processor_Speed)
);

CREATE TABLE Game_Code_4
(
  game_Engine CHAR(20),
  min_Processor_Speed FLOAT,
  PRIMARY KEY (game_Engine),
  FOREIGN KEY (min_Processor_Speed) REFERENCES Game_Code_3(min_Processor_Speed)
    ON DELETE CASCADE
);

CREATE TABLE Game_Code_5
(
  vg_Title CHAR(30),
  version CHAR(20),
  game_Engine CHAR(20),
  PRIMARY KEY (vg_Title, version),
  FOREIGN KEY (vg_Title) REFERENCES Game_Code_2(vg_Title) ON DELETE CASCADE,
  FOREIGN KEY (game_Engine) REFERENCES Game_Code_4(game_Engine) ON DELETE CASCADE
);

CREATE TABLE Game_Series_1
(
  sequel CHAR(30),
  number_of_Titles INT,
  number_in_Series INT,
  PRIMARY KEY (sequel)
);

CREATE TABLE Game_Series_2
(
  title CHAR(30),
  source_Code CHAR(30),
  most_Popular_in_Series CHAR(30), 
  player_Count INT,
  PRIMARY KEY (title)
);

CREATE TABLE Game_Series_3
(
  title CHAR(30),
  sequel CHAR(30),
  prequel CHAR(30),
  PRIMARY KEY (title),
  FOREIGN KEY (sequel) REFERENCES Game_Series_1(sequel) ON DELETE CASCADE
);


INSERT INTO Publisher VALUES('mojang','sweden', 600);
INSERT INTO Publisher VALUES('xbox game studios','united states', 6300);
INSERT INTO Publisher VALUES('relogic','united states', 11);
INSERT INTO Publisher VALUES('team17','united kingdom', 201);
INSERT INTO Publisher VALUES('epic games','united Sstates', 3746);
INSERT INTO Publisher VALUES('riot games','united states',2500);
INSERT INTO Publisher VALUES('sony','japan',109700);
INSERT INTO Publisher VALUES('warner bros','united states',8000);
INSERT INTO Publisher VALUES('matt makes games','canada',6);
INSERT INTO Publisher VALUES('capcom','japan',2832);
INSERT INTO Publisher VALUES('electronic arts','united states',11000);
INSERT INTO Publisher VALUES('bethesda softworks','united states',420);
INSERT INTO Publisher VALUES('valve','united states',360);

INSERT INTO VG_Company VALUES('Mojang','sweden');
INSERT INTO VG_Company VALUES('Bungie','united states');
INSERT INTO VG_Company VALUES('Relogic','united states');
INSERT INTO VG_Company VALUES('Team17','united kingdom');
INSERT INTO VG_Company VALUES('Epic games','united states');
INSERT INTO VG_Company VALUES('riot games','united states');
INSERT INTO VG_Company VALUES('hazelight studios','sweden');
INSERT INTO VG_Company VALUES('sucker punch productions','united states');
INSERT INTO VG_Company VALUES('netherrealm studios','united states');
INSERT INTO VG_Company VALUES('matt makes games','canada');
INSERT INTO VG_Company VALUES('capcom','japan');
INSERT INTO VG_Company VALUES('bethesda game studio','united states');
INSERT INTO VG_Company VALUES('kojima productions','japan');
INSERT INTO VG_Company VALUES('valve','united states');

INSERT INTO Company_Publisher_Videogame VALUES('minecraft','2011-11-18',10,'mojang','mojang');
INSERT INTO Company_Publisher_Videogame VALUES('halo: reach','2010-09-14',17,'xbox game studios','bungie');
INSERT INTO Company_Publisher_Videogame VALUES('terraria','2011-05-11',12,'relogic','relogic');
INSERT INTO Company_Publisher_Videogame VALUES('overcooked 2','2018-08-07',3,'team17','team17');
INSERT INTO Company_Publisher_Videogame VALUES('fortnite','2017-07-21',13,'epic games','epic games');
INSERT INTO Company_Publisher_Videogame VALUES('league of legends: wild rift','2020-10-27',12,'riot games','riot games');
INSERT INTO Company_Publisher_Videogame VALUES('it takes two','2021-03-26',12,'electronic arts','hazelight studios');
INSERT INTO Company_Publisher_Videogame VALUES('ghost of tsushima','2020-07-17',16,'sony','sucker punch productions');
INSERT INTO Company_Publisher_Videogame VALUES('mortal kombat 11','2019-04-23',18,'warner bros','netherrealm studios');
INSERT INTO Company_Publisher_Videogame VALUES('celeste','2018-01-25',7,'matt makes games','matt makes games');
INSERT INTO Company_Publisher_Videogame VALUES('resident evil village','2021-05-07',18,'capcom','capcom');
INSERT INTO Company_Publisher_Videogame VALUES('starfield','2023-12-31',18,'bethesda softworks','bethesda game studio');
INSERT INTO Company_Publisher_Videogame VALUES('death stranding','2019-11-08',18,'sony','kojima productions');
INSERT INTO Company_Publisher_Videogame VALUES('dota 2','2013-07-09',7,'valve','valve');
INSERT INTO Company_Publisher_Videogame VALUES('team fortress classic','1999-04-07',17,'valve','valve');
INSERT INTO Company_Publisher_Videogame VALUES('team fortress 2','2007-10-10',15,'valve','valve');
INSERT INTO Company_Publisher_Videogame VALUES('portal','2007-10-10',10,'valve','valve');
INSERT INTO Company_Publisher_Videogame VALUES('portal 2','2011-04-18',10,'valve','valve');

INSERT INTO Genre VALUES('sandbox');
INSERT INTO Genre VALUES('adventure');
INSERT INTO Genre VALUES('1st person shooter');
INSERT INTO Genre VALUES('simulation');
INSERT INTO Genre VALUES('3rd person shooter');

INSERT INTO Crossover_With VALUES('minecraft','mojang','mojang','halo: reach','xbox game studios','bungie');
INSERT INTO Crossover_With VALUES('halo: reach','xbox game studios','bungie','fortnite','epic games','epic games');
INSERT INTO Crossover_With VALUES('terraria','relogic','relogic','overcooked 2','team17','team17');
INSERT INTO Crossover_With VALUES('overcooked 2','team17','team17','terraria','relogic','relogic');
INSERT INTO Crossover_With VALUES('fortnite','epic games','epic games','minecraft','mojang','mojang');

INSERT INTO Categorized_in VALUES('sandbox','minecraft','mojang','mojang');
INSERT INTO Categorized_in VALUES('1st person shooter','halo: reach','xbox game studios','bungie');
INSERT INTO Categorized_in VALUES('adventure','terraria','relogic','relogic');
INSERT INTO Categorized_in VALUES('simulation','overcooked 2','team17','team17');
INSERT INTO Categorized_in VALUES('3rd person shooter','fortnite','epic games','epic games');

INSERT INTO IP VALUES('minecraft');
INSERT INTO IP VALUES('halo');
INSERT INTO IP VALUES('terraria');
INSERT INTO IP VALUES('overcooked');
INSERT INTO IP VALUES('fortnite');

INSERT INTO Licensed_By VALUES('minecraft','mojang','mojang','minecraft');
INSERT INTO Licensed_By VALUES('halo: reach','xbox game studios','bungie','halo');
INSERT INTO Licensed_By VALUES('terraria','relogic','relogic','terraria');
INSERT INTO Licensed_By VALUES('overcooked 2','team17','team17','overcooked');
INSERT INTO Licensed_By VALUES('fortnite','epic games','epic games','fortnite');

INSERT INTO Video_Game_Reviewer VALUES(99999);
INSERT INTO Video_Game_Reviewer VALUES(13213);
INSERT INTO Video_Game_Reviewer VALUES(30143);
INSERT INTO Video_Game_Reviewer VALUES(56789);
INSERT INTO Video_Game_Reviewer VALUES(42150);
INSERT INTO Video_Game_Reviewer VALUES(12345);
INSERT INTO Video_Game_Reviewer VALUES(48650);
INSERT INTO Video_Game_Reviewer VALUES(10001);
INSERT INTO Video_Game_Reviewer VALUES(55455);
INSERT INTO Video_Game_Reviewer VALUES(98765);

INSERT INTO General_Audience VALUES(99999, 9);
INSERT INTO General_Audience VALUES(13213, 20);
INSERT INTO General_Audience VALUES(30143, 30);
INSERT INTO General_Audience VALUES(56789, 15);
INSERT INTO General_Audience VALUES(42150, 19);

INSERT INTO Game_Critic VALUES(12345, 'ign');
INSERT INTO Game_Critic VALUES(48650, 'metacritic');
INSERT INTO Game_Critic VALUES(10001, 'eurogamer');
INSERT INTO Game_Critic VALUES(55455, 'screenrant');
INSERT INTO Game_Critic VALUES(98765, 'engadget');

INSERT INTO Reviewed_By VALUES(10, 'minecraft','mojang','mojang',12345);
INSERT INTO Reviewed_By VALUES(4, 'halo: reach','xbox game studios','bungie',48650);
INSERT INTO Reviewed_By VALUES(9, 'terraria','relogic','relogic',10001);
INSERT INTO Reviewed_By VALUES(6, 'overcooked 2','team17','team17',55455);
INSERT INTO Reviewed_By VALUES(10, 'fortnite','epic games', 'epic games',98765);

INSERT INTO Consumer VALUES('Jared Jones', 88888, 9);
INSERT INTO Consumer VALUES('Bob Smith', 21212, 20);
INSERT INTO Consumer VALUES('Andrew Garfield', 54321, 11);
INSERT INTO Consumer VALUES('Louis Hamilton', 65432, 78);
INSERT INTO Consumer VALUES('Alfred Pennyworth', 76543, 78);

INSERT INTO Plays VALUES(88888,732,'minecraft','mojang','mojang');
INSERT INTO Plays VALUES(21212,12,'halo: reach','xbox game studios','bungie');
INSERT INTO Plays VALUES(54321,3,'terraria','relogic','relogic');
INSERT INTO Plays VALUES(65432,200,'overcooked 2','team17','team17');
INSERT INTO Plays VALUES(76543,6589,'fortnite','epic games','epic games');

INSERT INTO Platform VALUES('playstation 3',2017,'sony');
INSERT INTO Platform VALUES('xbox 360',2016,'microsoft');
INSERT INTO Platform VALUES('pc',NULL,'microsoft');
INSERT INTO Platform VALUES('playstation5',NULL,'sony');
INSERT INTO Platform VALUES('switch',NULL,'nintendo');

INSERT INTO Available_On VALUES('pc','minecraft','mojang','mojang');
INSERT INTO Available_On VALUES('xbox 360','halo: reach','xbox game studios','bungie');
INSERT INTO Available_On VALUES('pc','terraria','relogic','relogic');
INSERT INTO Available_On VALUES('pc','overcooked 2','team17','team17');
INSERT INTO Available_On VALUES('switch','fortnite','epic games','epic games');

INSERT INTO Influences VALUES(88888,12345);
INSERT INTO Influences VALUES(21212,48650);
INSERT INTO Influences VALUES(54321,10001);
INSERT INTO Influences VALUES(65432,55455);
INSERT INTO Influences VALUES(76543,98765);

INSERT INTO Plays_On VALUES(88888,'pc');
INSERT INTO Plays_On VALUES(21212,'xbox 360');
INSERT INTO Plays_On VALUES(54321,'pc');
INSERT INTO Plays_On VALUES(65432,'pc');
INSERT INTO Plays_On VALUES(76543,'switch');

INSERT INTO Game_Awards VALUES(2021,'league of legends: wild rift','riot games','riot games');
INSERT INTO Game_Awards VALUES(2021,'it takes two','electronic arts','hazelight studios');
INSERT INTO Game_Awards VALUES(2020,'ghost of tsushima','sony','sucker punch productions');
INSERT INTO Game_Awards VALUES(2021,'mortal kombat 11','warner bros','netherrealm studios');
INSERT INTO Game_Awards VALUES(2018,'celeste','matt makes games','matt makes games');
INSERT INTO Game_Awards VALUES(2019,'mortal kombat 11','warner bros','netherrealm studios');
INSERT INTO Game_Awards VALUES(2019,'death stranding','sony','kojima productions');

INSERT INTO Nominations VALUES(2021,'game of the year','resident evil village','capcom','capcom');
INSERT INTO Nominations VALUES(2021,'best mobile game','league of legends: wild rift','riot games','riot games');
INSERT INTO Nominations VALUES(2021,'most anticipated game','starfield','bethesda softworks','bethesda game studio');
INSERT INTO Nominations VALUES(2019,'best fighting game','mortal kombat 11','warner bros','netherrealm studios');
INSERT INTO Nominations VALUES(2019,'game of the year','death stranding','sony','kojima productions');
INSERT INTO Nominations VALUES(2021,'game of the year','it takes two','electronic arts','hazelight studios');
INSERT INTO Nominations VALUES(2020,"player's choice",'ghost of tsushima','sony','sucker punch productions');
INSERT INTO Nominations VALUES(2018,'best independent game','celeste','matt makes games','matt makes games');

INSERT INTO Won_At VALUES(2021,'game of the year','it takes two','electronic arts','hazelight studios');
INSERT INTO Won_At VALUES(2020,"player's choice",'ghost of tsushima','sony','sucker punch productions');
INSERT INTO Won_At VALUES(2018,'best independent game','celeste','matt makes games','matt makes games');
INSERT INTO Won_At VALUES(2019,'best independent game','celeste','matt makes games','matt makes games');
INSERT INTO Won_At VALUES(2020,'best independent game','celeste','matt makes games','matt makes games');

INSERT INTO Game_Code_1 VALUES('open world','sandbox');
INSERT INTO Game_Code_1 VALUES('arena','moba');
INSERT INTO Game_Code_1 VALUES('side scroller','metroidvania');
INSERT INTO Game_Code_1 VALUES('platform','platformer');

INSERT INTO Game_Code_2 VALUES('minecraft','open world',1);
INSERT INTO Game_Code_2 VALUES('dota 2','arena',1);
INSERT INTO Game_Code_2 VALUES('terraria','side scroller',1);

INSERT INTO Game_Code_3 VALUES(2.4,900);
INSERT INTO Game_Code_3 VALUES(1.8,700);
INSERT INTO Game_Code_3 VALUES(0.2,32);
INSERT INTO Game_Code_3 VALUES(3,1200);
INSERT INTO Game_Code_3 VALUES(0.9,64);

INSERT INTO Game_Code_4 VALUES('source engine',2.4);
INSERT INTO Game_Code_4 VALUES('source 2',0.2);
INSERT INTO Game_Code_4 VALUES('unreal engine 5',3);
INSERT INTO Game_Code_4 VALUES('unity engine',0.9);

INSERT INTO Game_Code_5 VALUES('dota 2','7.31d','source 2');

INSERT INTO Game_Series_1 VALUES('team fortress classic',2,1);
INSERT INTO Game_Series_1 VALUES('team fortress 2',2,2);
INSERT INTO Game_Series_1 VALUES('portal 2',2,2);
INSERT INTO Game_Series_1 VALUES('portal',2,1);
INSERT INTO Game_Series_1 VALUES('minecraft',1,1);

INSERT INTO Game_Series_2 VALUES('team fortress classic','c++','team fortress 2',150037);
INSERT INTO Game_Series_2 VALUES('valorant','c++','valorant',1509009);
INSERT INTO Game_Series_2 VALUES('minecraft','java','minecraft',140000000);

INSERT INTO Game_Series_3 VALUES('team fortress 2',NULL,'team fortress classic');
INSERT INTO Game_Series_3 VALUES('portal','portal 2',NULL);
INSERT INTO Game_Series_3 VALUES('minecraft',NULL,NULL);
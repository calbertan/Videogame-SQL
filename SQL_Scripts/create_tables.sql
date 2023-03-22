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
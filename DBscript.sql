-- drop table book;
-- drop table category;

CREATE TABLE Category (
    Id INTEGER PRIMARY KEY,
    Name TEXT NOT NULL
);

CREATE TABLE Book (
    Id INTEGER PRIMARY KEY,
    Title TEXT NOT NULL,
    Author TEXT NOT NULL,
    PublicationDate TEXT NOT NULL,
    CategoryId INTEGER NOT NULL,
    FOREIGN KEY (CategoryId) REFERENCES Category(Id)
);

WITH DuplicateBooks AS (
    SELECT 
        Title, 
        Author, 
        MIN(Id) as MinId
    FROM 
        Book
    GROUP BY 
        Title, 
        Author
    HAVING 
        COUNT(*) > 1
)
DELETE FROM Book
WHERE Id NOT IN (
    SELECT MinId FROM DuplicateBooks
)
AND EXISTS (
    SELECT 1 FROM DuplicateBooks
    WHERE Book.Title = DuplicateBooks.Title
    AND Book.Author = DuplicateBooks.Author
);




INSERT INTO Category (Name) VALUES ('Fiction');
INSERT INTO Category (Name) VALUES ('Non-Fiction');
insert into Book (title, author, publicationDate, categoryid)
	values ('Dracula', 'Bram Stoker', '1897-05-26', 1),
		('The Black Dahlia', 'James Elroy', '1987-09-01', 2),
		('The Unbearable Lightness of Being', 'Milan Kundera', '1984-03-15', 3),
		('The Near Witch', 'Victoria Schwab', '2011-01-01', 5),
		('The Ninth House', 'Leigh Bardugo', '2019-01-01', 5),
		('Legendborn', 'Tracy Deonn', '2020-01-01', 5),
		('The Invisible Life of Addie LaRue', 'V.E. Schwab', '2020-01-01', 5),
		('Hunted by The Sky', 'Tanaz Bhathena', '2020-01-01', 5),
		('Rising Like a Storm', 'Tanaz Bhathena', '2021-01-01', 5),
		('Behold the Dreamers', 'Imbolo Mbue', '2017-01-01', 4),
		('Transcendent Kingdom', 'Yaa Gyasi', '2020-01-01', 4),
		('Yolk', 'Mary H.K. Choi', '2021-01-01', 4),
		('The Guncle', 'Steven Rowley', '2021-01-01', 4),
		('Lily and the Octopus', 'Steven Rowley', '2016-01-01', 4),
		('The Editor', 'Steven Rowley', '2019-01-01', 4),
		('A Star Is Bored', 'Byron Lane', '2020-01-01', 4),
		('Swimming Lessons', 'Claire Fuller', '2017-01-01', 4),
		('A Girl is a Body of Water', 'Jennifer Nansubuga Makumbi', '2020-01-01', 4),
		('The Vanishing Half', 'Brit Bennett', '2020-01-01', 4),
		('Everyone in This Room Will Someday Be Dead', 'Emily Austin', '2021-01-01', 4),
		('Afterparties', 'Anthony Veasna So', '2021-01-01', 4),
		('Klara and the Sun', 'Kazuo Ishiguro', '2021-01-01', 4),
		('Long Division', 'Kiese Laymon', '2013-01-01', 4),
		('The Art of Gathering', 'Priya Parker', '2018-01-01', 6),
		('The Health Catalyst', 'Avanti Kumar-Singh', '2020-01-01', 6),
		('The Person You Mean to Be', 'Dolly Chugh', '2018-01-01', 6),
		('Big Friendship', 'Aminatou Sow and Ann Friedman', '2020-01-01', 6),
		('Hidden Valley Road', 'Robert Kolker', '2020-01-01', 6),
		('Data Visualization', 'Kieran Healy', '2018-01-01', 6),
		('The Truthful Art', 'Alberto Cairo', '2016-01-01', 6),
		('Caste', 'Isabel Wilkerson', '2020-01-01', 6),
		('Land of the Fee', 'Devin Fergus', '2018-01-01', 6),
		('Set Boundaries Find Peace', 'Nedra Glover Tawwab', '2021-01-01', 6),
		('The Body Is Not An Apology', 'Sonya Renee Taylor', '2018-01-01', 6),
		('Such a Fun Age', 'Kiley Reid', '2019-01-01', 6),
		('Hood Feminism', 'Mikki Kendall', '2020-01-01', 6),
		('Talking to Strangers', 'Malcom Gladwell', '2019-01-01', 6),
		('Effortless', 'Greg McKeown', '2021-01-01', 6),
		('W.E.B. Du Bois Data Portraits: Visualizing Black America', 'Whitney Battle-Baptiste and Britt Rusert', '2018-01-01', 6),
		('Untamed', 'Glennon Doyle', '2020-01-01', 6),
		('The Wall Street Journal Guide to Information Graphics', 'Dona M. Wong', '2010-01-01', 6),
		('The Big Picture', 'Steve Wexler', '2021-01-01', 6),
		('All About Love', 'Bell Hooks', '1999-01-01', 6),
		('Sometimes I Trip On How Happy We Could Be', 'Nichole Perkins', '2021-01-01', 6),
		('Minor Feelings', 'Cathy Park Hong', '2020-01-01', 6),
		('All Along You Were Blooming', 'Morgan Harper Nichols', '2020-01-01', 7),
		('Heart Talk', 'Cleo Wade', '2018-01-01', 7);
--PART 1: Creating the entities --execute part 1 at once

CREATE TABLE Individuals (
	Id SERIAL PRIMARY KEY,
	Name VARCHAR(30) NOT NULL,
	Surname VARCHAR(30) NOT NULL,
	OIB VARCHAR(11) NOT NULL UNIQUE,
	DateOfBirth DATE NOT NULL,
	Gender VARCHAR(1),
	ResidencyCity VARCHAR(30)
);

CREATE TABLE Internships (
	Id SERIAL PRIMARY KEY,
	InternshipManagerId INT NOT NULL REFERENCES Individuals(Id),
	StartDate DATE NOT NULL,
	EndDate DATE,
	Status VARCHAR(15) NOT NULL
);

CREATE TABLE Branches (
	Id SERIAL PRIMARY KEY,
	Name VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE BranchInternships (
	Id SERIAL PRIMARY KEY,
	BranchId INT REFERENCES Branches(Id),
	InternshipId INT REFERENCES Internships(Id),
	BranchManagerId INT NOT NULL REFERENCES Individuals(Id),
	NumberOfInterns INT
);

CREATE TABLE InternBranches (
	Id SERIAL PRIMARY KEY,
	BranchId INT REFERENCES BranchInternships(Id) NOT NULL,
	InternId INT REFERENCES Individuals(Id) NOT NULL,
	Status VARCHAR(10)
);

CREATE TABLE MemberBranches (
	Id SERIAL PRIMARY KEY,
	MemberId INT REFERENCES Individuals(Id) NOT NULL,
	BranchId INT REFERENCES Branches(Id) NOT NULL
);

CREATE TABLE Homeworks (
	Id SERIAL PRIMARY KEY,
	InternId INT REFERENCES InternBranches(Id) NOT NULL,
	MemberId INT REFERENCES MemberBranches(Id),
	BranchId INT REFERENCES BranchInternships(Id) NOT NULL,
	Label VARCHAR(40) NOT NUll,
	Grade INT
);

--END OF PART 1

--PART 2: Adding constraints

ALTER TABLE Branches
ADD CONSTRAINT chk_limit_branches 
CHECK (Name IN ('Development', 'Design', 'Multimedia', 'Marketing'));

ALTER TABLE Individuals
ADD CONSTRAINT chk_OIB_length
CHECK (Length(OIB) = 11);

ALTER TABLE Homeworks
ADD CONSTRAINT chk_grade
CHECK (Grade > 0 AND Grade < 6);

ALTER TABLE Internships
ADD CONSTRAINT chk_internship_status
CHECK (Status IN ('Ended', 'In preparation', 'In process'));

ALTER TABLE InternBranches
ADD CONSTRAINT chk_intern_status
CHECK (Status IN ('Intern', 'Kicked', 'Ended'));

ALTER TABLE BranchInternships
ADD CONSTRAINT chk_max_number
CHECK (NumberOfInterns < 21);

--END OF PART 2

--PART 3: Adding mock data to database

INSERT INTO Individuals (Name, Surname, OIB, DateOfBirth, Gender, ResidencyCity)
VALUES
	('Alex', 'Amanzi', '12345678901', '1995-01-02', 'M', 'Split'),
	('Ante', 'Roca', '23456789012', '2002-12-25', 'M', 'Sinj'),
	('Bartol', 'Deak', '34567890123', '2003-10-01', 'M', 'Trogir'),
	('Duje', 'Sarić', '45678901234', '2000-05-20', 'M', 'Split'),
	('Frane', 'Doljanin', '56789012345', '2002-04-16', 'M', 'Omiš'),
	('Gabriela', 'Bonic', '67890123456', '2003-11-16', 'Ž', 'Kaštela'),
	('Ivo', 'Jovanović', '78901234567', '1999-06-07', 'M', 'Split'),
	('Luka', 'Nola', '89012345678', '1994-10-11', 'M', 'Split'),
	('Marija', 'Šustić', '90123456789', '2002-07-08', 'Ž', 'Split'),
	('Matija', 'Luketin', '01234567890', '1992-10-15', 'M', 'Split'),
	('Lucija', 'Vukorepa', '12345679000', '1998-09-16', 'Ž', 'Kaštela'),
	('Ana', 'Maroš', '11234567890', '2001-09-27', 'Ž', 'Makarska'),
	('Ana', 'Pavlinović', '12234567890', '2003-10-30', 'Ž','Kaštela'),
	('Andrea', 'Mikelić', '12334567890', '2005-11-11', 'Ž','Split'),
	('Andrea', 'Zečević', '12344567890', '2001-04-15', 'Ž','Solin'),
	('Antonia', 'Maleš', '12345567890', '1999-12-01', 'Ž','Split'),
	('Antonio', 'Bečić', '12345667890', '2004-06-17', 'M','Solin'),
	('Antonio', 'Strižić', '12345677890', '2003-10-29', 'M','Split'),
	('Dajana', 'Šimunović', '12345678890', '1999-07-29', 'Ž','Solin'),
	('Damjana', 'Barić', '12345678990', '1999-01-21', 'Ž', 'Kaštela'),
	('Dario', 'Mrkonjić', '12345678900', '2004-10-23', 'M','Split'),
	('Doria', 'Medak', '11123456789', '2002-06-15', 'Ž','Split'),
	('Ela', 'Jakelić', '12223456789', '2003-10-20', 'Ž', 'Trogir'),
	('Ema Andrea', 'Drašković', '12333456789', '2000-12-29', 'Ž', 'Solin'),
	('Gabriela', 'Delic', '12344456789', '2002-05-07', 'Ž', 'Split'),
	('Hajdi', 'Pervan', '12345556789', '1999-04-13', 'Ž', 'Solin'),
	('Iva', 'Puljak', '12345666789', '2003-03-07', 'Ž', 'Omiš'),
	('Jan', 'Modun', '12345677789', '2004-03-10', 'M', 'Split'),
	('Ljubica', 'Pranjić', '12345678889', '2002-10-03', 'Ž', 'Makarska'),
	('Lovre', 'Tomić', '12345678999', '2000-10-01', 'M', 'Split'),
	('Luce', 'Latin', '12345678000', '2003-08-10', 'Ž', 'Solin'),
	('Lucija', 'Ravlić', '23456789000', '2001-06-07', 'Ž', 'Split'),
	('Margareta', 'Pribudić', '13456789000', '2002-08-16', 'Ž', 'Solin'),
	('Marija', 'Gudelj', '12456789000', '2003-05-20', 'Ž', 'Split'),
	('Marina', 'Škorić', '12356789000', '2000-12-16', 'Ž', 'Solin'),
	('Marina', 'Žižić', '12346789000', '2005-10-15', 'Ž', 'Split'),
	('Marko', 'Jokic', '12345789000', '2004-09-28', 'M', 'Kaštela'),
	('Mate', 'Marušić', '12345689000', '2002-09-19', 'M', 'Split'),
	('Matija', 'Carević', '11134567890', '2003-04-26', 'Ž', 'Split'),
	('Melita', 'Vrcic', '11124567890', '2001-11-16', 'Ž', 'Solin'),
	('Meloni', 'Pinjušić', '11123567890', '2000-12-05', 'Ž', 'Makarska'),
	('Mia', 'Barada', '22341567890', '2001-08-16', 'Ž', 'Solin'),
	('Mia', 'Marasović', '33218797368', '1999-12-12', 'Ž', 'Split'),
	('Mihaela', 'Koprčina', '44367835895', '2002-10-19', 'Ž', 'Split'),
	('Mirna', 'Pendić', '55748302967', '2004-10-19', 'Ž', 'Kaštela'),
	('Miroslav', 'Sokol', '66894039123', '2003-05-19', 'M', 'Split'),
	('Nika', 'Kašljević', '77893625380', '2001-10-29', 'Ž', 'Solin'),
	('Tamara', 'Goić', '88357485018', '2002-11-19', 'Ž', 'Split'),
	('Tino', 'Maretić', '99836582345', '2003-08-30', 'M', 'Solin'),
	('Toma', 'Šiklić', '97658395753', '2002-09-21', 'M', 'Split');
	
INSERT INTO Branches (Name)
VALUES
	('Development'), ('Design'), ('Multimedia'), ('Marketing');
	
INSERT INTO Internships (InternshipManagerId, StartDate, EndDate, Status)
VALUES
	(1, '2021-10-15', '2022-05-24', 'Ended'),
	(4, '2022-10-26', '2023-05-26', 'In process'),
	(11, '2023-10-30', '2024-05-20', 'In preparation');
	
INSERT INTO MemberBranches (MemberId, BranchId)
VALUES
	(1, 1), (2, 3), (2, 2),(3, 1), (4, 1), (5, 1), (6, 3), (7, 1), 
	(8, 1), (9, 2), (10, 1), (10, 2), (11, 4);
	
INSERT INTO BranchInternships (BranchId, InternshipId, BranchManagerId)
VALUES
	(1, 1, 1), (2, 1, 10), (3, 1, 2), (4, 1, 11),
	(1, 2, 3), (2, 2, 9), (3, 2, 8), (4, 2, 11),
	(1, 3, 5), (2, 3, 9), (3, 3, 6), (4, 3, 11);

INSERT INTO InternBranches (InternId, BranchId, Status)
VALUES
	(12, 5,'Intern'), (12, 7,'Intern'), (13, 6,'Intern'), (14, 8,'Intern'), 
	(15, 7,'Intern'), (16, 6,'Intern'), (17, 3,'Ended'), (18, 1,'Ended'), 
	(19, 5,'Intern'), (20, 5,'Intern'), (21, 7,'Intern'), (21, 8,'Intern'),
	(22, 7,'Intern'), (23, 8,'Kicked'), (24, 5,'Intern'), (25, 6,'Intern'), 
	(25, 1,'Kicked'),(26, 1,'Ended'), (27, 1,'Ended'), (28, 2,'Kicked'), 
	(29, 3,'Ended'), (30, 4,'Ended'), (31, 5,'Kicked'), (32, 5,'Intern'), 
	(33, 6,'Intern'), (33, 4,'Ended'),(34, 4,'Ended'), (35, 3,'Ended'),
	(36, 2,'Kicked'), (37, 4,'Ended'), (38, 7,'Intern'), (39, 5,'Intern'),
	(40, 7,'Intern'), (40, 5,'Intern'),(41, 5,'Kicked'), (41, 2,'Kicked'),
	(42, 2,'Ended'), (43, 8,'Intern'), (44, 6,'Intern'), (45, 1,'Ended'), 
	(46, 4,'Kicked'), (47, 5,'Intern'), (48, 6,'Intern'), (49, 7,'Intern'), 
	(50, 5,'Intern'), (50, 6,'Intern');
	
INSERT INTO Homeworks (InternId, MemberId, BranchId, Label, Grade)
VALUES 
	(1, 1, 5, 'Internship-1-Git', 4),
	(1, 4, 5, 'Internship-2-C#', 2),
	(1, 4, 5, 'Internship-3-OOP-Calendar', 3),
	(9, 4, 5, 'Internship-1-Git', 2),
	(9, 4, 5, 'Internship-2-C#', 3),
	(9, 4, 5, 'Internship-3-OOP-Calendar', 2),
	(10, 5, 5, 'Internship-1-Git', 3),
	(10, 5, 5, 'Internship-2-C#', 4),
	(15, 8, 5, 'Internship-4-Crypto-Wallet', 2),
	(23, 9, 5, 'Internship-1-Git', 3),
	(24, 10, 5, 'Internship-2-C-Sharp', 2),
	(32, 6, 5, 'Internship-3-OOP-Calendar', 4),
	(33, 1, 5, 'Internship-1-Git', 4),
	(33, 1, 5, 'Internship-2-C-Sharp', 5 ),
	(33, 1, 5, 'Internship-3-OOP-Calendar', 4),
	(34, 4, 5, 'Internship-1-Git', 2),
	(33, 1, 5, 'Internship-2-C-Sharp', 3),
	(41, 9, 5, 'Internship-1-Git', 1);
	
--END OF PART 3

--PART 4: Queries

SELECT DISTINCT i.Name, i.Surname FROM MemberBranches m
JOIN Individuals i ON i.Id = m.MemberId
WHERE i.ResidencyCity != 'Split';

SELECT StartDate, EndDate FROM Internships
ORDER BY StartDate;

SELECT DISTINCT ind.Name, ind.Surname FROM InternBranches ib
JOIN BranchInternships bi ON bi.Id = ib.BranchId
JOIN Internships i ON bi.InternshipId = i.Id
JOIN Individuals ind ON ind.Id = ib.InternId
WHERE DATE_PART('year', i.StartDate) = 2021;

SELECT COUNT(*) AS NumberOfInterns FROM Individuals i
JOIN InternBranches ib ON ib.InternId = i.Id
JOIN Branches b ON b.Id = ib.BranchId
WHERE b.Name = 'Development' AND i.Gender = 'Ž';

SELECT COUNT(*) AS KickedFromMarketing FROM InternBranches ib
JOIN Branches b ON b.Id = ib.BranchId
WHERE b.Name = 'Marketing' AND ib.Status = 'Kicked';

--END OF PART 4

	

	
	

	
	
	
	
	
	
	
	
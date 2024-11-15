
--create database

create database VirtualArtGallery

-- Create the Artists table
CREATE TABLE Artists (
 ArtistID INT PRIMARY KEY,
 Name VARCHAR(255) NOT NULL,
 Biography TEXT,
 Nationality VARCHAR(100));

-- Create the Categories table
CREATE TABLE Categories (
 CategoryID INT PRIMARY KEY,
 Name VARCHAR(100) NOT NULL);

-- Create the Artworks table
CREATE TABLE Artworks (
 ArtworkID INT PRIMARY KEY,
 Title VARCHAR(255) NOT NULL,
 ArtistID INT,
 CategoryID INT,
 Year INT,
 Description TEXT,
 ImageURL VARCHAR(255),
 FOREIGN KEY (ArtistID) REFERENCES Artists (ArtistID),
 FOREIGN KEY (CategoryID) REFERENCES Categories (CategoryID));

-- Create the Exhibitions table
CREATE TABLE Exhibitions (
 ExhibitionID INT PRIMARY KEY,
 Title VARCHAR(255) NOT NULL,
 StartDate DATE,
 EndDate DATE,
 Description TEXT);

-- Create a table to associate artworks with exhibitions
CREATE TABLE ExhibitionArtworks (
 ExhibitionID INT,
 ArtworkID INT,
 PRIMARY KEY (ExhibitionID, ArtworkID),
 FOREIGN KEY (ExhibitionID) REFERENCES Exhibitions (ExhibitionID),
 FOREIGN KEY (ArtworkID) REFERENCES Artworks (ArtworkID));


-- Insert sample data into the Artists table
INSERT INTO Artists (ArtistID, Name, Biography, Nationality) VALUES
 (1, 'Pablo Picasso', 'Renowned Spanish painter and sculptor.', 'Spanish'),
 (2, 'Vincent van Gogh', 'Dutch post-impressionist painter.', 'Dutch'),
 (3, 'Leonardo da Vinci', 'Italian polymath of the Renaissance.', 'Italian');

-- Insert sample data into the Categories table
INSERT INTO Categories (CategoryID, Name) VALUES
 (1, 'Painting'),
 (2, 'Sculpture'),
 (3, 'Photography');

-- Insert sample data into the Artworks table
INSERT INTO Artworks (ArtworkID, Title, ArtistID, CategoryID, Year, Description, ImageURL) VALUES
 (1, 'Starry Night', 2, 1, 1889, 'A famous painting by Vincent van Gogh.', 'starry_night.jpg'),
 (2, 'Mona Lisa', 3, 1, 1503, 'The iconic portrait by Leonardo da Vinci.', 'mona_lisa.jpg'),
 (3, 'Guernica', 1, 1, 1937, 'Pablo Picasso''s powerful anti-war mural.', 'guernica.jpg');

-- Insert sample data into the Exhibitions table
INSERT INTO Exhibitions (ExhibitionID, Title, StartDate, EndDate, Description) VALUES
 (1, 'Modern Art Masterpieces', '2023-01-01', '2023-03-01', 'A collection of modern art masterpieces.'),
 (2, 'Renaissance Art', '2023-04-01', '2023-06-01', 'A showcase of Renaissance art treasures.');

-- Insert artworks into exhibitions
insert into ExhibitionArtworks (ExhibitionID, ArtworkID) values
 (1, 1),
 (1, 2),
 (1, 3),
 (2, 2);

 -----Insert queries for conditions in the questions which do not satisfies above data

 insert into Artworks (ArtworkID, Title, ArtistID, CategoryID, Year, Description, ImageURL) values
(4, 'Portrait ', 1, 1, 1947, 'A painting by Vijay', 'Portrait.jpg'),
(5, 'River', 1, 1, 2003, 'A Nature painting', 'River.jpg');

insert into Artworks (ArtworkID, Title, ArtistID, CategoryID, Year, Description, ImageURL) values
(6, 'The Old Book', 1, 1, 2001, 'A famous painting ', 'OldBook.jpg'),
(7, 'Nature River', 1, 1, 1990, 'A painting ', 'TheRiver.jpg');

insert into ExhibitionArtworks (ExhibitionID, ArtworkID) values
(3, 1),
(3, 2);

insert into Exhibitions (ExhibitionID, Title, StartDate, EndDate, Description) values
(5, 'Comp', '2024-11-01', '2024-12-01', 'An exhibition');


insert into Artworks (ArtworkID, Title, ArtistID, CategoryID, Year, Description, ImageURL) values
(8, 'Good ', 3, 1, 1500, 'An artwork', 'art.jpg'),
(9, 'Computer', 3, 2, 1505, 'An artwork ', 'computer.jpg'),
(10, 'Mobile', 3, 3, 1510, 'An artwork ', 'Mobile.jpg');



 ----------------------------------Check tables--------------------------------
 select * from Artists
 select * from Categories
 select * from Artworks
 select * from Exhibitions
 select * from ExhibitionArtworks

 ---------------------------------------Tasks--------------------------------

 --1.Retrieve the names of all artists along with the number of artworks they have in the gallery, 
 --and list them in descending order of the number of artwork
 
 select a.Name,count(ar.ArtworkId) as ArtWorks
 from Artists a join
 artworks ar on a.ArtistID=ar.ArtistID
 group by a.Name
 order by ArtWorks desc;

 --2. List the titles of artworks created by artists from 'Spanish' and 'Dutch' nationalities, 
 --and order them by the year in ascending order.

 select ar.Title,a.Nationality,ar.Year
 from Artworks ar
 join 
 Artists a on ar.ArtistID=a.ArtistID
 where a.Nationality in ('Spanish','Dutch')
 order by ar.year;

 --3. Find the names of all artists who have artworks in the 'Painting' category, and 
 --the number of artworks they have in this category.

 select a.Name as ArtistName,count(ar.ArtworkId) as PaintingsCount
 from Artists a
 join Artworks ar on a.ArtistID=ar.ArtistID
 join categories c on ar.categoryId=c.categoryId
 where c.Name='Painting'
 group by a.Name;

 --4. List the names of artworks from the 'Modern Art Masterpieces' exhibition, along with their 
 --artists and categories.

 select 
 ar.Title,a.Name,c.Name
 from ExhibitionArtworks ea
 join Artworks ar on ea.ArtworkID=ar.ArtworkID
 join artists a on ar.artistId=a.artistId
 join Categories c on ar.CategoryID=c.CategoryID
 join Exhibitions e on e.ExhibitionID=e.ExhibitionID
 where e.title='Modern Art Masterpieces'

 --5. Find the artists who have more than two artworks in the gallery

 select a.Name 
 from artists a
 join Artworks ar
 on a.ArtistID=ar.ArtistID
 group by a.Name
 having count(ar.artworkId)>2;

 --6. Find the titles of artworks that were exhibited in both 'Modern Art Masterpieces' and 
 --'Renaissance Art' exhibitions

select ar.title
from Artworks ar
join ExhibitionArtworks ea on ar.artworkid = ea.artworkid
join Exhibitions e on ea.exhibitionid = e.exhibitionid
where e.title in ('modern art masterpieces', 'renaissance art')
group by ar.title
having count(distinct e.title) = 2;

--7. Find the total number of artworks in each category

select c.Name, count(ar.artworkId) as ArtWorkCount
from Categories c
join Artworks ar on c.CategoryID=ar.CategoryID
group by c.Name

--8. List artists who have more than 3 artworks in the gallery

select a.Name as ArtistName
from Artists a
join Artworks ar
on a.ArtistID=ar.ArtistID
group by
a.Name 
having count(ar.ArtworkID)>3

--9. Find the artworks created by artists from a specific nationality (e.g., Spanish).

select ar.Title
from Artworks ar
join artists a
on ar.ArtistID=a.ArtistID
where a.Nationality='Spanish';

--10. List exhibitions that feature artwork by both Vincent van Gogh and Leonardo da Vinci.

select e.Title
from Exhibitions e
join ExhibitionArtworks ea on e.ExhibitionID=ea.ExhibitionID
join Artworks ar on ea.ArtworkID=ar.ArtworkID
join Artists a on ar.artistId =a.ArtistID
where a.Name='Vincent van Gogh' or a.Name='Leonardo da Vinci'
group by e.title 
having count(distinct a.Name)=2;

--11. Find all the artworks that have not been included in any exhibition.

select ar.Title
from Artworks ar
left join ExhibitionArtworks ea on ar.ArtworkID=ea.ArtworkID
where ea.ExhibitionID is null;

--12. List artists who have created artworks in all available categories.

select a.Name
from Artists a
join Artworks ar on a.ArtistID=ar.ArtistID
join Categories c on ar.CategoryID=c.CategoryID
group by a.Name
having Count(distinct ar.categoryId)=(select count(*) from categories);

--13. List the total number of artworks in each category.

select c.Name,
count(ar.ArtworkID)
from Categories c
join Artworks ar on C.CategoryID=ar.CategoryID
group by c.Name

--14. Find the artists who have more than 2 artworks in the gallery

select a.Name
from Artists a
join Artworks ar on a.artistId=ar.ArtistID
group by a.Name
having count(ar.artworkId)>2;

--15. List the categories with the average year of artworks they contain, only for categories 
--with more than 1 artwork.

select c.Name,avg(ar.year) as [Year]
from categories c
join Artworks ar
on c.CategoryID=ar.CategoryID
group by c.Name
having count(ar.artWorkId)>1;

--16. Find the artworks that were exhibited in the 'Modern Art Masterpieces' exhibition

select ar.Title
from ExhibitionArtworks ea
join Artworks ar
on ea.ArtworkID=ar.ArtworkID
join Exhibitions e on e.ExhibitionID=e.ExhibitionID
where e.Title='Modern Art Masterpieces'

--17.Find the categories where the average year of artworks is greater than the average year 
--of all artworks.

select c.Name
from Categories c
join Artworks ar on c.CategoryID=ar.CategoryID
group by c.Name
having avg(ar.year)>(select avg(year) from Artworks);

--18. List the artworks that were not exhibited in any exhibition 

select ar.Title
from Artworks ar
left join ExhibitionArtworks ea
on ea.ArtworkID=ar.ArtworkID
where ea.ExhibitionID is null;



--19. Show artists who have artworks in the same category as "Mona Lisa."

select a.Name
from artists a
join Artworks ar on a.ArtistID =ar.ArtistID
where ar.CategoryID=(select CategoryID from Artworks where title = 'Mona Lisa');

--20. List the names of artists and the number of artworks they have in the gallery

select a.Name,count(ar.ArtistID) as ArtWorks
from Artists a
left join 
Artists ar on a.ArtistID=ar.ArtistID
group by a.Name 

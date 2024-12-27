Create Database petclinic ;
USE petclinic;


CREATE TABLE Customer (
    NationalID int (10) NOT NULL,
    First_Name varchar (15),
    Last_Name varchar (15),
    Payment_Info varchar (11) CHECK (Payment_Info IN ('Credit Card', 'Apple Pay')),
    CONSTRAINT Customer_PK PRIMARY KEY (NationalID)
);

CREATE TABLE Adoption (
    adoptionID INT (10) NOT NULL PRIMARY KEY,
    adoptionDate DATE,
    adoptingFee DECIMAL(10, 2),
    pending BOOLEAN,
    approved BOOLEAN,
    completed BOOLEAN,
    nationalID int(10),
    CONSTRAINT Adoption_Customer_FK FOREIGN KEY (nationalID) REFERENCES Customer(NationalID)
);

CREATE TABLE Pet (
    PetID INT(5) NOT NULL,
    petName VARCHAR(20),
    NationalID INT(10),
    Age INT(2),
    Sex VARCHAR(20),
    Specie VARCHAR(20),
    Breed VARCHAR(20),
    Vaccination VARCHAR(20),
    adoptionID INT (5),
    CONSTRAINT Pet_PK PRIMARY KEY (PetID),
    CONSTRAINT pet_FK1 FOREIGN KEY (NationalID) REFERENCES Customer(NationalID) ON DELETE CASCADE,
    CONSTRAINT pet_FK2 FOREIGN KEY (adoptionID) REFERENCES Adoption(adoptionID) ON DELETE CASCADE
);
 
 CREATE TABLE Service (
ServiceID INT(5) NOT NULL,
Routine_Care VARCHAR(30),
Emergency VARCHAR(30),
Surgery VARCHAR(30),
Service_Price DECIMAL (5, 2), 
PetID INT(5),
NationalID INT (10),
CONSTRAINT service_PK PRIMARY KEY (serviceID),
CONSTRAINT service_FK1 FOREIGN KEY (PetID) REFERENCES Pet(PetID) ON DELETE CASCADE,
CONSTRAINT service_FK2 FOREIGN KEY (NationalID) REFERENCES Customer(NationalID) ON DELETE CASCADE);

CREATE TABLE Store (
    ProductID int(10) NOT NULL,
    ProductName varchar(15) unique,
    AvailableQuantity int,
    Price decimal(10, 2), 
    ExpirationDate date,
    StorageLocation varchar(15),
    NationalID int(10),
    CONSTRAINT Store_PK PRIMARY KEY (ProductID),
    CONSTRAINT Store_FK FOREIGN KEY (NationalID) references Customer(NationalID) on delete cascade
    );
    
    CREATE TABLE Employee (
    EmployeeID int (10) NOT NULL,
    FirstName varchar(15),
    LastName varchar(15),
    Position varchar(15),
    Salary decimal(10, 2),
    WorkingHours int,
    ContactInformation varchar(25),
    ProductID int(10),
    CONSTRAINT Employee_PK PRIMARY KEY (EmployeeID),
    CONSTRAINT Employee_FK FOREIGN KEY (ProductID) references Store(ProductID) on delete cascade
);

CREATE TABLE PhoneNumber (
    PhoneNumber VARCHAR(20) NOT NULL,
    NationalID int(10) NOT NULL,
    CONSTRAINT phonePK PRIMARY KEY(PhoneNumber,NationalID),
    CONSTRAINT FK_phone foreign key(NationalID) references Customer(NationalID)
);

CREATE TABLE Provides_Service (
    ServiceID int (10) NOT NULL,
    EmployeeID int (10) NOT NULL,
    CONSTRAINT Provides_Service_PK PRIMARY KEY (ServiceID, EmployeeID),
    CONSTRAINT Provides_Service_FK1 FOREIGN KEY (ServiceID) REFERENCES Service (ServiceID) ON DELETE CASCADE,
    CONSTRAINT Provides_Service_FK2 FOREIGN KEY (EmployeeID) REFERENCES Employee (EmployeeID) ON DELETE CASCADE
);



INSERT INTO Customer (NationalID, First_Name, Last_Name, Payment_Info)
VALUES 
    (1123054799, 'Layan', 'Alharbi', 'Credit Card'),
    (1097315468, 'Hamsa', 'Alharbi', 'Apple Pay'),
    (1102348601, 'Ghala', 'Almalki', 'Credit Card'),
    (1067921114, 'Retaj', 'Alosaimi', 'Apple Pay'),
    (1046896324, 'Raydaa', 'Almabadi', 'Credit Card');
    
    INSERT INTO Adoption (adoptionID, adoptionDate, adoptingFee, pending, approved, completed, nationalID)
VALUES 
    (1, '2024-01-15', 100.00, 1, 0, 0, '1046896324'),
    (2, '2022-02-20', 150.00, 0, 1, 0, '1067921114'),
    (3, '2023-03-25', 200.00, 0, 0, 1, '1097315468'),
    (4, '2023-04-10', 120.00, 1, 1, 0, '1123054799'),
    (5, '2021-05-05', 180.00, 1, 0, 1, '1102348601');
    
    INSERT INTO Pet (PetID, petName, NationalID, Age, Sex, Specie, Breed, Vaccination, adoptionID)
VALUES (10234,'Luna',1046896324,1,'Female','Cat','Persian','Vaccinted',3),
(10235,'Garfield',1067921114,3,'Male','Cat','Siamese','Not Vaccinted',null),
(10236,'Snoopy',1097315468,4,'Male','Dog','Beagle','Vaccinted',null),
(10237,'Pluto',1123054799,3,'Female','Dog','German Shepherd', 'Vaccinted',null),
(10238,'Tweety',1123054799,3,'Male','Bird','Budgie','Not Vaccinted',5),
(10239,'Woody',1102348601,2,'Male','Bird','Cocktiel','Not Vaccinted',null);

INSERT INTO Service 
VALUES 
(11001,'Grooming',NULL ,'Sterilization', 600.00 , 10234 ,1046896324 ),
(11002, 'Check Up','Fever', NULL, 100.00 ,10235 ,1067921114),
(22001, 'Dental Care', 'Tooth Fracture','Tooth Extraction', 350.75,10236 ,1097315468 ),
(22002, 'Blood Tests', 'Poisoning', 'Toxin Extraction',490.00 , 10237,1123054799 ),
(33001, 'Nail Trimming', NULL, NULL,  25.00, 10238, 1123054799),
(33002, NULL, 'Leg Fracture', 'Orthopaedic Treatment', 70.55 , 10239, 1102348601);
    
   INSERT INTO Store
VALUES
(1, 'Bird Food', 10, 20.99, '2024-03-01', 'Location A', 1123054799),
(2, 'Pet Shampoo', 5, 15.99, '2024-04-01', 'Location B', 1097315468),
(3, 'Cat Toy', 8, 18.99, '2024-05-01', 'Location C', 1102348601),
(4, 'Horse Brush', 3, 12.99, '2024-06-01', 'Location D', 1067921114),
(5, 'Horse Vitamins', 12, 24.99, '2024-07-01', 'Location E', 1046896324),
(6, 'Pet Bed', 6, 17.99, '2024-08-01', 'Location F', 1067921114);

INSERT INTO Employee
VALUES
(1, 'Arwa', 'Mohammed', 'Veterinarian', 5000.00, 40, 'Arwa@gmail.com', 1),
(2, 'Fatima', 'Omar', 'VeterAssistant', 3000.00, 35, 'Fatima@gmail.com', 2),
(3, 'Aisha', 'Ali', 'PetCaretaker', 4000.00, 38, 'Aisha@gmail.com', 1),
(4, 'Leila', 'Hassan', 'AdmAssistant ', 3000.00, 35, 'Leila@gmail.com', 2),
(5, 'Khalid', 'Abdullah', 'Receptionist', 2500.00, 30, 'Khalid@gmail.com', 3);

    INSERT INTO PhoneNumber (PhoneNumber, NationalID)
VALUES 
    ('05485437393', 1046896324),
    ('05503938264', 1067921114),
    ('05127395729', 1097315468),
    ('05682749136', 1123054799),
    ('05937264173', 1102348601);
    
     INSERT INTO Provides_Service (ServiceID, EmployeeID) VALUES
(11001, 1),
(11002, 2),
(22001, 3),
(22002, 4),
(33001, 5);
    
delete from Store
WHERE ProductID = 6;
SELECT *
FROM Store;

UPDATE Adoption 
SET 
    adoptingFee = 150.00,
    pending = 0,
    approved = 1,
    completed = 1
WHERE
    adoptionID = 1;

SELECT C.NationalID, C.Payment_Info,
       S.ProductID, S.Price
FROM Customer AS C
JOIN Store AS S ON C.NationalID = S.NationalID;

SELECT COUNT(*)
FROM Customer
WHERE Payment_Info = 'Credit Card' AND First_Name = 'Layan';

SELECT NationalID AS Customer, SUM(Service_Price) AS Total
FROM Service
GROUP BY NationalID
HAVING Total > 300;

SELECT EmployeeID,Salary
FROM Employee
ORDER BY 2 ASC;

SELECT EmployeeID,Salary
FROM Employee
WHERE Salary BETWEEN 2000 AND 3000;

SELECT StorageLocation, SUM(Price) AS Total_Price
FROM Store
GROUP BY StorageLocation;

SELECT ProductName, AVG(AvailableQuantity) AS Avg_Quantity
FROM Store
GROUP BY ProductName;

SELECT*
 FROM PhoneNUmber
 WHERE NationalID = '1046896324';
 
SELECT*
FROM Adoption 
WHERE adoptingFee > 100;

SELECT *
 FROM Customer
 ORDER BY Last_Name DESC;
 

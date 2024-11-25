
-- 1. Create EntityTypes Table
CREATE TABLE EntityTypes (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,  -- e.g., "Product", "Order", "Service"
    Description NVARCHAR(500) NULL
);

-- 2. Create Languages Table
CREATE TABLE Languages (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Code NVARCHAR(10) NOT NULL,   -- e.g., "en", "ka", "el", "de"
    Name NVARCHAR(100) NOT NULL   -- e.g., "English", "Georgian", "Greek", "German"
);

-- 3. Create Entities Table
CREATE TABLE Entities (
    Id INT PRIMARY KEY IDENTITY(1,1),
    EntityTypeId INT,  -- Foreign key to EntityTypes
    Name NVARCHAR(255) NOT NULL,
    Description NVARCHAR(MAX) NULL,
    CONSTRAINT FK_Entity_EntityType FOREIGN KEY (EntityTypeId) REFERENCES EntityTypes(Id)
);

-- 4. Create LocalizedFields Table
CREATE TABLE LocalizedFields (
    Id INT PRIMARY KEY IDENTITY(1,1),
    EntityTypeId INT,  -- Foreign key to EntityTypes
    EntityId INT,  -- Foreign key to the actual entity (e.g., ProductId)
    FieldName NVARCHAR(100) NOT NULL,  -- e.g., "Name", "Description"
    LanguageId INT NOT NULL,  -- Foreign key to Languages table
    FieldValue NVARCHAR(MAX),  -- Localized value
    CONSTRAINT FK_LocalizedField_EntityType FOREIGN KEY (EntityTypeId) REFERENCES EntityTypes(Id),
    CONSTRAINT FK_LocalizedField_Entity FOREIGN KEY (EntityId) REFERENCES Entities(Id),
    CONSTRAINT FK_LocalizedField_Language FOREIGN KEY (LanguageId) REFERENCES Languages(Id)
);

-- 5. Insert Entity Types (Product, Order)
INSERT INTO EntityTypes (Name, Description)
VALUES
    ('Product', 'Represents a product for sale'),
    ('Order', 'Represents a customer order');

-- 6. Insert Languages (English, Georgian, Greek, German)
INSERT INTO Languages (Code, Name)
VALUES
    ('en', 'English'),
    ('ka', 'Georgian'),
    ('el', 'Greek'),
    ('de', 'German');

-- 7. Insert Entities (Product, Order)
INSERT INTO Entities (EntityTypeId, Name, Description)
VALUES
    (1, 'Red Wine', 'A fine red wine from the vineyards of Rostomaant Marani'),  -- Product
    (2, 'Order #12345', 'Customer order for red wine');  -- Order

-- 8. Insert Localized Fields for Product (Name, Description)
-- Insert localized Name for Product (ID 1)
INSERT INTO LocalizedFields (EntityTypeId, EntityId, FieldName, LanguageId, FieldValue)
VALUES
    (1, 1, 'Name', 1, 'Red Wine'),  -- English
    (1, 1, 'Name', 2, 'წითელი ღვინო'),  -- Georgian
    (1, 1, 'Name', 3, 'Κόκκινο Κρασί'),  -- Greek
    (1, 1, 'Name', 4, 'Rotwein');  -- German

-- Insert localized Description for Product (ID 1)
INSERT INTO LocalizedFields (EntityTypeId, EntityId, FieldName, LanguageId, FieldValue)
VALUES
    (1, 1, 'Description', 1, 'A fine red wine from the vineyards of Rostomaant Marani'),  -- English
    (1, 1, 'Description', 2, 'ახალი წითელი ღვინო როსტომანტ მარნიდან'),  -- Georgian
    (1, 1, 'Description', 3, 'Ένα εξαιρετικό κόκκινο κρασί από τους αμπελώνες του Rostomaant Marani'),  -- Greek
    (1, 1, 'Description', 4, 'Ein feiner Rotwein aus den Weinbergen von Rostomaant Marani');  -- German

-- 9. Update Product Name in English
UPDATE LocalizedFields
SET FieldValue = 'Updated Red Wine'
WHERE EntityTypeId = 1
  AND EntityId = 1
  AND FieldName = 'Name'
  AND LanguageId = 1;

-- 10. Update Product Description in Greek
UPDATE LocalizedFields
SET FieldValue = 'Ένα ανανεωμένο εξαιρετικό κόκκινο κρασί από τους αμπελώνες του Rostomaant Marani'
WHERE EntityTypeId = 1
  AND EntityId = 1
  AND FieldName = 'Description'
  AND LanguageId = 3;

-- 11. Select Localized Data for Product (ID 1) in all languages
SELECT e.Name AS EntityName, 
       lf.FieldName, 
       lf.FieldValue AS LocalizedValue, 
       l.Name AS Language
FROM LocalizedFields lf
JOIN Entities e ON e.Id = lf.EntityId
JOIN Languages l ON l.Id = lf.LanguageId
WHERE e.Id = 1  -- Product ID
  AND lf.EntityTypeId = 1  -- Product EntityType
ORDER BY l.Name;

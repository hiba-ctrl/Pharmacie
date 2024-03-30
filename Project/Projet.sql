DROP TABLE IF EXISTS Personnel cascade;
DROP TABLE IF EXISTS Users cascade;
DROP TABLE IF EXISTS Client cascade;
DROP TABLE IF EXISTS Fournisseur cascade;
DROP TABLE IF EXISTS Categorie cascade;
DROP TABLE IF EXISTS Produit cascade;
DROP TABLE IF EXISTS Vente cascade;
DROP TABLE IF EXISTS Caisse cascade;



DROP TABLE IF EXISTS Retour cascade;
DROP TABLE IF EXISTS Stock cascade;
DROP TABLE IF EXISTS Livraison cascade;
DROP TABLE IF EXISTS Commande_pharma cascade;
DROP TABLE IF EXISTS Ordonnance cascade;
DROP TABLE IF EXISTS Alerte cascade;
DROP TABLE IF EXISTS Depense cascade;
DROP TABLE IF EXISTS Commande_client cascade;


-- Personnel Table
CREATE TABLE Personnel (
  Id_Pers INT PRIMARY KEY,
  Nom VARCHAR(100),
  Prenom VARCHAR(100),
  num_sec VARCHAR(100)
);

-- Users Table
CREATE TABLE Users (
  Users_id INT PRIMARY KEY,
  Password VARCHAR(255),
  Usersname VARCHAR(100),
  Email VARCHAR(100),
  FOREIGN KEY (Users_id) REFERENCES Personnel(Id_Pers)
);

-- Client Table
CREATE TABLE Client (
  Id_client INT PRIMARY KEY,
  Nom VARCHAR(100),
  Nm_secu VARCHAR(100),
  Adresse VARCHAR(255),
  Tel VARCHAR(20)
);


-- Fournisseur Table
CREATE TABLE Fournisseur (
  Id_fournsr INT PRIMARY KEY,
  Nom VARCHAR(100),
  Adresse VARCHAR(255),
  Tel VARCHAR(20)
);

-- Categorie Table  
CREATE TABLE Categorie (
  Id_categ INT PRIMARY KEY,
  Nom VARCHAR(100)
);

-- Produit Table
CREATE TABLE Produit (
  Id_prod INT PRIMARY KEY,
  Id_fournsr INT,
  Id_categ INT,
  Nom VARCHAR(100),
  Prix_vente DECIMAL(10, 2),
  Prix_achat DECIMAL(10, 2),
  Date_expr DATE,
  FOREIGN KEY (Id_categ) REFERENCES Categorie(Id_categ),
  FOREIGN KEY (Id_fournsr) REFERENCES Fournisseur(Id_fournsr)
);

-- Vente Table
CREATE TABLE Vente (
  Id_vente INT PRIMARY KEY,
  Id_prod INT,
  Date DATE,
  Quantite INT,
  Total DECIMAL(10, 2),
  Id_client INT,
  FOREIGN KEY (Id_client) REFERENCES Client(Id_client),
  FOREIGN KEY (Id_prod) REFERENCES Produit(Id_prod)
);

-- Caisse table
CREATE TABLE Caisse (
    Id_caisse INT PRIMARY KEY,
    Id_Users INT,
    Id_vente INT,
    Mnt_retour DECIMAL(10,2),
    Mnt_total DECIMAL(10,2),
    Revenu_net DECIMAL(10,2),
    FOREIGN KEY (Id_Users) REFERENCES Users(Users_id),
    FOREIGN KEY (Id_vente) REFERENCES Vente (Id_vente)
);













-- Table retour
CREATE TABLE Retour (
  Id_retour INT PRIMARY KEY,
  Id_vente INT,
  Id_prod INT,
  Id_client INT,
  Date DATE,
  Quantite INT,
  FOREIGN KEY (Id_vente) REFERENCES Vente(Id_vente),
  FOREIGN KEY (Id_prod) REFERENCES Produit(Id_prod),
  FOREIGN KEY (Id_client) REFERENCES Client(Id_client)
);

-- Table Stock
CREATE TABLE Stock(
    Id_stock INT PRIMARY KEY,
    Id_prod INT,
    QuantiteEntree INT,
    QuantiteSortie INT,
    Date DATE,
    FOREIGN KEY (Id_prod) REFERENCES Produit(Id_prod)
);

-- Table Livraison
CREATE TABLE Livraison(
    Id_livr INT PRIMARY KEY,
    Id_prod INT,
    Id_fournsr INT,
    Date DATE,
    Montant DECIMAL(10,2),
    Quant INT,
    FOREIGN KEY (Id_prod) REFERENCES Produit(Id_prod),
    FOREIGN KEY (Id_fournsr) REFERENCES Fournisseur(Id_fournsr)
);

-- Table Commande_pharma
CREATE TABLE Commande_pharma(
    Id_comm INT PRIMARY KEY, 
    Id_prod INT,
    Id_fournsr INT,
    Quant_prod INT,
    Date DATE,
    FOREIGN KEY (Id_prod) REFERENCES Produit(Id_prod),
    FOREIGN KEY (Id_fournsr) REFERENCES Fournisseur (Id_fournsr)
);

-- Table Ordonnance
CREATE TABLE Ordonnance(
    Id_ord INT PRIMARY KEY,
    Id_client INT,
    Id_prod INT,
    Date DATE,
    FOREIGN KEY (Id_client) REFERENCES Client(Id_client),
    FOREIGN KEY (Id_prod) REFERENCES Produit (Id_prod)
);

-- Table Alerte 
CREATE TABLE Alerte(
    Id_alerte INT PRIMARY KEY,
    Id_prod INT,
    Id_stock INT,
    Date DATE,
    FOREIGN KEY (Id_prod) REFERENCES Produit(Id_prod),
    FOREIGN KEY (Id_stock) REFERENCES Stock(Id_stock)
);
-- Table Depense
CREATE TABLE Depense(
    Id_depense INT PRIMARY KEY,
    Id_Pers INT,
    Id_comm INT,
    Salaire DECIMAL(10,2),
    --Commande_pharma DECIMAL(10,2),
    FOREIGN KEY (Id_Pers) REFERENCES Personnel(Id_Pers),
    FOREIGN KEY (Id_comm) REFERENCES Commande_pharma(Id_comm)
);

-- Commande_client Table (many-to-many relationship)
CREATE TABLE Commande_client (
  Id_comm INT PRIMARY KEY,
  Id_client INT,
  Id_prod INT,
  Quant_prod INT,
  Date DATE,
  FOREIGN KEY (Id_client) REFERENCES Client(Id_client),
  FOREIGN KEY (Id_prod) REFERENCES Produit(Id_prod)
);

-- Indexes for performance
CREATE INDEX idx_client_name ON Client(Nom);
CREATE INDEX idx_vente_date ON Vente(Date);

-- Insert some data

-- Insert some data

-- Populating the Personnel table with sample data
INSERT INTO Personnel (Id_Pers, Nom, Prenom, num_sec) VALUES
(1, 'Doe', 'John', '123456789'),
(2, 'Smith', 'Jane', '987654321'),
(3, 'Brown', 'Charlie', '192837465');

-- Populating the Users table with sample data
INSERT INTO Users (Users_id, Password, Usersname, Email) VALUES
(1, 'password123', 'johndoe', 'john.doe@example.com'),
(2, 'password456', 'janesmith', 'jane.smith@example.com'),
(3, 'password789', 'charliebrown', 'charlie.brown@example.com');

-- Populating the Client table with sample data
INSERT INTO Client (Id_client, Nom, Nm_secu, Adresse, Tel) VALUES
(1, 'ClientA', '111222333', '123 Main St', '123-456-7890'),
(2, 'ClientB', '444555666', '456 Oak St', '098-765-4321'),
(3, 'ClientC', '777888999', '789 Pine St', '456-123-7890');

-- Populating the Client table with sample data
Insert into Fournisseur (Id_fournsr ,Nom,Adresse,Tel) values 
(1, 'fournisseurs1','123 Rue Mar',0113456789),
(2, 'fournisseurs2','456 Rue Mar',012456789),
(3, 'fournisseurs3','789 Rue Mar',0133456789);

-- Populating the Client table with sample data
Insert into Categorie (Id_categ , nom) values 
(1, 'Dermatologie'),
(2, 'Digestion et nausées'),
(3, 'Douleurs et fièvres');
(4, 'Vitamines et minéraux');
(5, 'Minceur et forme');
(6, 'Allergies');
(7, 'Santé et bien-être');
(8, 'Maman et bébé');
(9, 'Homéopathie');
(10, 'Médecines naturelles');
(11, 'Sexualité');
(12, 'Orthopédie');
(13, 'Matériel médical');
(14, 'Hygiène');
(15, 'Beauté');
(16, 'Solaire');
(17, 'Vétérinaire');
(18, 'Autres');
-- Populating the Client table with sample data
INSERT INTO Produit (Id_prod, Id_fournsr, Id_categ, Nom, Prix_vente, Prix_achat, Date_expr) VALUES 
(1, 1, 3, 'Doliprane', 10.99, 6.99, '2025-12-10'),
(2, 1, 1, 'Aclav', 12.99, 8.99, '2025-09-01'),
(3, 1, 6, 'Zyrtec', 10.99, 6.99, '2025-12-10');
(4, 1, 2, 'Oedes', 12.99, 8.99, '2025-09-01');
(5, 1, 4, 'Vitamine C', 10.99, 6.99, '2025-12-10');
(6, 1, 5, 'XLS Medical', 12.99, 8.99, '2025-09-01');
(7, 1, 7, 'Arkogélules', 10.99, 6.99, '2025-12-10');
(8, 1, 8, 'Dodie', 12.99, 8.99, '2025-09-01');
(9, 1, 9, 'Boiron', 10.99, 6.99, '2025-12-10');
(10, 1, 10, 'Arkopharma', 12.99, 8.99, '2025-09-01');
(11, 1, 11, 'Durex', 10.99, 6.99, '2025-12-10');
(12, 1, 12, 'Thuasne', 12.99, 8.99, '2025-09-01');
(13, 1, 13, 'Littmann', 10.99, 6.99, '2025-12-10');
(14, 1, 14, 'Saforelle', 12.99, 8.99, '2025-09-01');
(15, 1, 15, 'Nuxe', 10.99, 6.99, '2025-12-10');
(16, 1, 16, 'Bioderma', 12.99, 8.99, '2025-09-01');
(17, 1, 17, 'Frontline', 10.99, 6.99, '2025-12-10');
(18, 1, 18, 'Autres', 12.99, 8.99, '2025-09-01');





INSERT INTO Vente (  Id_vente, Id_prod ,Date, Quantite, Total, Id_client ) VALUES 
(1, 1, '2024-03-10', 6, 10.99*6, 1),
(2, 2, '2024-03-10', 2, 12.99*2, 2),
(3, 1, '2024-03-10', 1, 10.99 , 3),
(4, 3, '2024-03-10', 3, .99*3, 1),
(5, 2, '2024-03-10', 1, 12.99, 2),
(6, 1, '2024-03-10', 2, 10.99*2, 3),
(7, 3, '2024-03-10', 1, 10.99, 1),
(8, 2, '2024-03-10', 3, 12.99*3, 2),
(9, 1, '2024-03-10', 1, 10.99, 3),
(10, 3, '2024-03-10', 2, 10.99*2, 1),
(11, 2, '2024-03-10', 1, 12.99, 2),
(12, 1, '2024-03-10', 3, 10.99*3, 3),
(13, 3, '2024-03-10', 1, 10.99, 1),
(14, 2, '2024-03-10', 2, 12.99*2, 2),
(15, 1, '2024-03-10', 1, 10.99, 3),
(16, 3, '2024-03-10', 3, 10.99*3, 1),
(17, 2, '2024-03-10', 2, 12.99*2, 2),
(18, 1, '2024-03-10', 1, 10.99, 3),
(19, 3, '2024-03-10', 2, 10.99*2, 1),
(20, 2, '2024-03-10', 3, 12.99*3, 2),
(21, 1, '2024-03-10', 1, 10.99, 3),
(22, 3, '2024-03-10', 2, 10.99*2, 1),
(23, 2, '2024-03-10', 3, 12.99*3, 2),
(24, 1, '2024-03-10', 1, 10.99, 3),
(25, 3, '2024-03-10', 3, 10.99*3, 1),
(26, 2, '2024-03-10', 2, 12.99*2, 2),
(27, 1, '2024-03-10', 1, 10.99, 3),
(28, 3, '2024-03-10', 2, 10.99*2, 1),
(29, 2, '2024-03-10', 3, 12.99*3, 2),
(30, 1, '2024-03-10', 1, 10.99, 3),
(31, 3, '2024-03-10', 3, 10.99*3, 1),
(32, 2, '2024-03-10', 2, 12.99*2, 2),
(33, 1, '2024-03-10', 1, 10.99, 3),
(34, 3, '2024-03-10', 2, 10.99*2, 1),
(35, 2, '2024-03-10', 3, 12.99*3, 2),
(36, 1, '2024-03-10', 1, 10.99, 3),
(37, 3, '2024-03-10', 3, 10.99*3, 1),
(38, 2, '2024-03-10', 2, 12.99*2, 2),
(39, 1, '2024-03-10', 1, 10.99, 3),
(40, 3, '2024-03-10', 2, 10.99*2, 1),
(41, 2, '2024-03-10', 3, 12.99*3, 2);








CREATE OR REPLACE FUNCTION verifier_conformite_medicaments(id_client INT)
RETURNS VARCHAR AS $$
DECLARE
  message VARCHAR := '';
  medicament_record RECORD;
BEGIN
  FOR medicament_record IN
    SELECT p1.Id_prod, p2.Id_prod
    FROM Produit p1
    JOIN Vente v1 ON p1.Id_prod = v1.Id_prod AND v1.Id_client = id_client
    JOIN Produit p2
    JOIN Vente v2 ON p2.Id_prod = v2.Id_prod AND v2.Id_client = id_client
    WHERE p1.Id_prod < p2.Id_prod AND EXISTS (
      SELECT 1 FROM NonConformites
      WHERE (Id_medicament1 = p1.Id_prod AND Id_medicament2 = p2.Id_prod)
         OR (Id_medicament1 = p2.Id_prod AND Id_medicament2 = p1.Id_prod)
    )
  LOOP
    message := message || 'Attention: Les médicaments ' || medicament_record.Id_prod || ' et ' || medicament_record.Id_prod || ' ne doivent pas être pris ensemble.';
  END LOOP;

  IF message = '' THEN
    message := 'Aucune non-conformité détectée.';
  END IF;

  RETURN message;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION verifier_stock()
RETURNS TABLE(Id_prod INT, Nom VARCHAR, QuantiteRestante INT) AS $$
BEGIN
  RETURN QUERY
  SELECT p.Id_prod, p.Nom, (s.QuantiteEntree - s.QuantiteSortie) AS QuantiteRestante
  FROM Produit p
  JOIN Stock s ON p.Id_prod = s.Id_prod
  WHERE (s.QuantiteEntree - s.QuantiteSortie) <= s.Seuil_min;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION recommander_fournisseur(id_prod INT, en_urgence BOOLEAN)
RETURNS TABLE(Id_fournsr INT, Nom VARCHAR, CoutLivraison DECIMAL, DelaiLivraison INT) AS $$
BEGIN
  IF en_urgence THEN
    RETURN QUERY
    SELECT f.Id_fournsr, f.Nom, if.CoutLivraison, if.DelaiLivraison
    FROM Fournisseur f
    JOIN InfosFournisseur if ON f.Id_fournsr = if.Id_fournsr
    WHERE f.Id_fournsr IN (SELECT Id_fournsr FROM Produit WHERE Id_prod = id_prod)
    ORDER BY if.DelaiLivraison ASC
    LIMIT 1;
  ELSE
    RETURN QUERY
    SELECT f.Id_fournsr, f.Nom, if.CoutLivraison, if.DelaiLivraison
    FROM Fournisseur f
    JOIN InfosFournisseur if ON f.Id_fournsr = if.Id_fournsr
    WHERE f.Id_fournsr IN (SELECT Id_fournsr FROM Produit WHERE Id_prod = id_prod)
    ORDER BY if.CoutLivraison ASC
    LIMIT 1;
  END IF;
END;
$$ LANGUAGE plpgsql;

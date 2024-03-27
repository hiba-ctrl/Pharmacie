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
(1, 1, 1, 'prod1', 10.99, 6.99, '2025-12-10'),
(2, 1, 1, 'prod2', 12.99, 8.99, '2025-09-01'),
(3, 1, 2, 'prod1', 10.99, 6.99, '2025-12-10');

INSERT INTO Vente (  Id_vente, Id_prod ,Date, Quantite, Total, Id_client ) VALUES 
(1, 1, '2024-03-10', 6, 10.99*6, 1),
(2, 2, '2024-03-10', 2, 12.99*2, 2),
(3, 1, '2024-03-10', 1, 10.99 , 3);

CREATE OR REPLACE FUNCTION update_stock_after_sale()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE Stock
  SET QuantiteSortie = QuantiteSortie + NEW.Quantite
  WHERE Id_prod = NEW.Id_prod;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER vente_after_insert
AFTER INSERT ON Vente
FOR EACH ROW
EXECUTE FUNCTION update_stock_after_sale();

CREATE OR REPLACE FUNCTION update_stock_after_return()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE Stock
  SET QuantiteEntree = QuantiteEntree + NEW.Quantite
  WHERE Id_prod = NEW.Id_prod;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER retour_after_insert
AFTER INSERT ON Retour
FOR EACH ROW
EXECUTE FUNCTION update_stock_after_return();



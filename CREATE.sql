-- Dropa a database
-- DROP DATABASE ecommerce;

-- Criar banco de dados para E-commerce
-- CREATE DATABASE ecommerce;

-- Types Enum
-- Enum Categoria
CREATE type enum_product AS ENUM ('Eletronicos', 'Vestimenta', 'Brinquedos', 'Alimentos','Móveis');
-- Enum Pagamentos
CREATE type enum_payments AS ENUM ('Boleto', 'Dinheiro', 'Cartão', 'PIX');
-- Enum Pedidos
CREATE type enum_order_sales AS ENUM ('Cancelado', 'Confirmado', 'Em processamento');
-- Enum Produto_Pedido
CREATE type enum_product_order AS ENUM ('Disponivel', 'Sem estoque');

-- Criar tabela Endereço
CREATE TABLE address(
	idEndereco SERIAL PRIMARY KEY,
	rua varchar(100),
	numero varchar(10),
	cep varchar(15),
	complemento varchar(100)
);

-- Criar tabela Cliente
CREATE TABLE clients(
	idClient SERIAL PRIMARY KEY,
	Fname varchar(10),
	Minit char(3),
	Lname varchar(20),
	CPF char(11) NOT NULL,
	idAddress int,
	CONSTRAINT unique_cpf_client UNIQUE (cpf),
	CONSTRAINT fk_client_address FOREIGN KEY (idAddress) REFERENCES address (idEndereco)
);

-- Criar tabela Produto
CREATE TABLE product(
	idProduct SERIAL PRIMARY KEY,
	Pname varchar(30) NOT null,
	classification_kids boolean DEFAULT false,
	category enum_product NOT NULL,
	avaliacao float DEFAULT 0,
	tamanho varchar(10)
);

-- Criar tabela de pagamentos
CREATE TABLE payments(
	idPayments int,
	idClient int,
	typePayment float,
	limitAvailable float,
	primary key(idClient, idPayments),
	CONSTRAINT fk_payments_clients FOREIGN KEY (idClient) REFERENCES clients (idClient) 
);

-- Criar tabela Pedido
CREATE TABLE orders(
	idOrders SERIAL PRIMARY KEY,
	idClient int,
	order_status enum_order_sales DEFAULT 'Em processamento',
	order_description varchar(255),
	sendValue float DEFAULT 10,
	payment float,
	CONSTRAINT fk_order_client FOREIGN KEY (idClient) REFERENCES clients (idClient)
);

--Criar tabela estoque
CREATE TABLE product_storage(
	idProdStorage SERIAL PRIMARY KEY,
	category enum_product,
	quantidade int DEFAULT 0,
	storage_location varchar(255)
);

--Criar tabela fornecedor
CREATE TABLE supplier(
	idSupplier SERIAL PRIMARY KEY,
	CNPJ char(15),
	SocialName varchar(255) NOT NULL,
	contact varchar(12)
);

--Criar tabela vendedor
CREATE TABLE seller(
	idSeller SERIAL PRIMARY KEY,
	CNPJ char(15),
	SocialName varchar(255) NOT NULL,
	contact varchar(12)
);

-- Alterar tabela seller, adicionar colunas e constraints
ALTER TABLE seller
ADD CPF CHAR(9),
ADD AbstName VARCHAR(255) NOT NULL,
ADD localization VARCHAR(255),
ADD CONSTRAINT UNIQUE_cnpj_seller UNIQUE (CNPJ),
ADD CONSTRAINT UNIQUE_cpf_seller UNIQUE (CPF);



--Criar tabela vendedor
CREATE TABLE product_seller(
	idPseller SERIAL,
	idPproduct SERIAL,
	prodQuantity int DEFAULT 1,
	PRIMARY KEY (idPseller, idPproduct),
	CONSTRAINT fk_product_seller FOREIGN KEY (idPseller) REFERENCES seller (idSeller),
	CONSTRAINT fk_product_product FOREIGN KEY (idPproduct) REFERENCES product (idProduct)
);

--Criar tabela vendedor
CREATE TABLE product_order(
	idPOproduct SERIAL,
	idPOstorage SERIAL,
	poQuantity int DEFAULT 1,
	poStatus enum_product_order DEFAULT 'Disponivel',
	PRIMARY KEY (idPOproduct, idPOstorage),
	CONSTRAINT fk_productOrder_seller FOREIGN KEY (idPOproduct) REFERENCES product (idProduct),
	CONSTRAINT fk_productOrder_product FOREIGN KEY (idPOstorage) REFERENCES orders (idOrders)
);
-- Criar tabela Estoque
CREATE TABLE storage_location(
	idLproduct SERIAL,
	idLstorage SERIAL,
	location varchar(255) NOT NULL,
	PRIMARY KEY (idLproduct, idLstorage),
	CONSTRAINT fk_storageLocation_product FOREIGN KEY (idLproduct) REFERENCES product (idProduct),
	CONSTRAINT fk_storageLocation_storage FOREIGN KEY (idLstorage) REFERENCES product_storage (idProdStorage)
);

-- Criar tabela Produto-Fornecedor
CREATE TABLE product_supplier(
	idPsSupplier SERIAL,
	idPsProduct SERIAL,
	quantity int NOT NULL,
	PRIMARY KEY (idPsSupplier, idPsProduct),
	CONSTRAINT fk_productSupplier_supplier FOREIGN KEY (idPsSupplier) REFERENCES supplier (idSupplier),
	CONSTRAINT fk_productSupplier_product FOREIGN KEY (idPsProduct) REFERENCES product (idProduct)
);

-- DROP TABLE address;
-- ALTER TABLE clients DROP CONSTRAINT fk_client_address;
-- ALTER TABLE clients ADD CONSTRAINT fk_client_address FOREIGN KEY (idAddress) REFERENCES address (idEndereco);

-- SELECT column_name, data_type, character_maximum_length, is_nullable, column_default
-- FROM information_schema.columns
-- WHERE table_name = 'seller';

-- SELECT *
-- FROM information_schema.referential_constraints;

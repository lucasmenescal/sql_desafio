-- Criação inicial de todo o projeto base.

-- insert clients
INSERT INTO public.address (rua, numero, cep, complemento) VALUES('Rua silva de prata', '29', '701255-000', '');
INSERT INTO public.clients (fname, minit, lname, cpf, idaddress) VALUES('Maria', 'M', 'Silva', '12346789', 1);

  -- Valores para a tabela "address"
INSERT INTO public.address (rua, numero, cep, complemento) VALUES
  ('Rua da Liberdade', '100', '12345-678', ''),
  ('Avenida dos Girassóis', '456', '54321-876', 'Apto 302'),
  ('Praça da Paz', '789', '98765-432', ''),
  ('Alameda das Estrelas', '200', '65432-109', 'Casa 5');
SELECT idendereco, rua, numero, cep, complemento FROM public.address;

-- Valores para a tabela "clients"
INSERT INTO public.clients (fname, minit, lname, cpf, idaddress) VALUES
  ('Mariana', 'B', 'Ferreira', '23456789012', 2),
  ('Lucas', 'C', 'Rocha', '34567890123', 3),
  ('Isabela', 'A', 'Almeida', '45678901234', 4),
  ('Paulo', 'S', 'Santana', '12345678901', 5);
SELECT idclient, fname, minit, lname, cpf, idaddress FROM public.clients;

-- Valores para Order
INSERT INTO orders (  idclient, order_status, order_description, sendvalue, payment ) VALUES ( 1, default, 'Compra via Aplicativo', default, 1);
INSERT INTO orders (  idclient, order_status, order_description, sendvalue, payment ) VALUES ( 2, default, 'Compra via Aplicativo', 50, 1);
INSERT INTO orders (  idclient, order_status, order_description, sendvalue, payment ) VALUES ( 3, 'Confirmado', null, default, 1);
INSERT INTO orders (  idclient, order_status, order_description, sendvalue, payment ) VALUES ( 4, default, 'Compra via Web Site', 150, 1);
-- Deleta linhas criadas na tabela orders
DELETE FROM orders WHERE idorders IN (1,2,3,4,5,6,7,8,9,10,11,12); 
SELECT idorders, idclient, order_status, order_description, sendvalue, payment FROM public.orders;
SELECT c.fname FROM public.clients c, public.orders o WHERE o.idclient = c.idclient AND o.idclient = 2;

-- Verificando sequencia de valores do serial da primary key da tabela orders
SELECT column_name, column_default
FROM information_schema.columns
WHERE table_name = 'product' AND column_name = 'idproduct';
-- Resposta: orders_idorders_seq -- Setando sequencia da tabela orders em 1 novamente.
SELECT pg_catalog.setval('product_idproduct_seq', 1, false);

--Valores para Product
DELETE FROM product WHERE idproduct IN (1,2,3,4,5,6,7,8,9,10,11,12,13); 
INSERT INTO public.product (pname, classification_kids, category, avaliacao, tamanho) VALUES('Celular', false, 'Eletronicos', default, '');
INSERT INTO public.product (pname, classification_kids, category, avaliacao, tamanho) VALUES('Água', false, 'Alimentos', default, '');
INSERT INTO public.product (pname, classification_kids, category, avaliacao, tamanho) VALUES('Camiseta', false, 'Vestimenta', default, 'P');
INSERT INTO public.product (pname, classification_kids, category, avaliacao, tamanho) VALUES('Sofá', false, 'Móveis', default, '2mx3mx1m');

-- Valores para product_storage
INSERT INTO public.product_storage (category, quantidade, storage_location) VALUES('Eletronicos', 1000, 'Rio de Janeiro');
INSERT INTO public.product_storage (category, quantidade, storage_location) VALUES('Vestimenta', 500, 'Rio de Janeiro');
INSERT INTO public.product_storage (category, quantidade, storage_location) VALUES('Móveis', 100, 'Fortaleza');

-- Valores para product_order
INSERT INTO public.product_order (idpoproduct, idpostorage ,poquantity, postatus) VALUES(1,3,2,null);
INSERT INTO public.product_order (idpoproduct, idpostorage ,poquantity, postatus) VALUES(2,3,1,null);
INSERT INTO public.product_order (idpoproduct, idpostorage ,poquantity, postatus) VALUES(3,4,1,null);

-- Valores para Supplier
INSERT INTO public.supplier (cnpj, socialname, contact) VALUES('123456789123456', 'Almeida e cia', '12345678');
INSERT INTO public.supplier (cnpj, socialname, contact) VALUES('963258741369852', 'cia do augusto', '98765432');
INSERT INTO public.supplier (cnpj, socialname, contact) VALUES('741258932587410', 'HCE', '36985214');

-- Valores para product_supplier
INSERT INTO public.product_supplier (idpssupplier , idpsproduct ,quantity) VALUES(1,1,500);
INSERT INTO public.product_supplier (idpssupplier , idpsproduct ,quantity) VALUES(1,2,400);
INSERT INTO public.product_supplier (idpssupplier , idpsproduct ,quantity) VALUES(2,4,633);
INSERT INTO public.product_supplier (idpssupplier , idpsproduct ,quantity) VALUES(3,3,5);


-- Valores para storage_location
INSERT INTO public.storage_location (idlproduct, idlstorage, "location") VALUES(1,2,'RJ');
INSERT INTO public.storage_location (idlproduct, idlstorage, "location") VALUES(2,3,'CE');

-- Valores para seller
INSERT INTO public.seller (cnpj, socialname, contact, cpf, abstname, localization) VALUES
('12345678901234', 'ABC Distributors', 'John Doe', '987654321', 'XYZ Wholesalers', 'New York, USA'),
('98765432109876', 'XYZ Retailers', 'Jane Smith', '123456789', 'ABC Suppliers', 'London, UK'),
('56789012345678', 'PQR Traders', 'Mike Johnson', '654321987', 'LMN Retailers', 'Sydney, Australia'),
('34567890123456', 'LMN Wholesalers', 'Sarah Lee', '789012345', 'PQR Traders', 'Toronto, Canada'),
('90123456789012', 'EFG Suppliers', 'Robert Brown', '012345678', 'EFG Suppliers', 'Berlin, Germany');

-- Valores para product_seller

INSERT INTO public.product_seller (idpseller ,idpproduct ,prodquantity) VALUES(1,4,80),(2,3,10);

SELECT count(*) FROM clients; 
-- Consultando quantos clientes tem algum pedido
SELECT count(*) FROM clients c, orders o WHERE c.idclient = o.idclient; 
-- Consultando primeiro, ultimo nome e endereço de clientes com pedidos
SELECT concat(c.fname, ' ', c.lname)  FROM clients c, orders o WHERE c.idclient = o.idclient;
SELECT concat(c.fname, ' ', c.lname) AS Nome, concat(a.rua, ', ', a.numero) AS Endereço FROM clients c, orders o, address a WHERE c.idclient = o.idclient;





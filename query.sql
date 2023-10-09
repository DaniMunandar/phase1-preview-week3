-- Tabel Customers
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(255),
    customer_email VARCHAR(255)
);

-- Tabel Authors
CREATE TABLE Authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(255),
    author_email VARCHAR(255)
);

-- Tabel Orders
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Tabel BookTypes
CREATE TABLE BookTypes (
    book_type_id INT AUTO_INCREMENT PRIMARY KEY,
    book_type_name VARCHAR(255)
);

-- Tabel Books
CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    book_title VARCHAR(255),
    book_type_id INT,
    author_id INT,
    order_id INT,
    FOREIGN KEY (book_type_id) REFERENCES BookTypes(book_type_id),
    FOREIGN KEY (author_id) REFERENCES Authors(author_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- Tabel BookPrices
CREATE TABLE BookPrices (
    book_price_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- Tabel sales
CREATE TABLE sales (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255),
    quantity INT,
    price DECIMAL(10, 2),
    book_id INT, -- Menambahkan kolom "book_id" untuk mengaitkan penjualan dengan buku
    FOREIGN KEY (book_id) REFERENCES Books(book_id) -- Menambahkan kunci asing ke tabel "Books"
);


-- Insert data into Customers table
INSERT INTO Customers (customer_name, customer_email)
VALUES
    ('Mark Johnson', 'mark.johnson@email.com'),
    ('Sarah Lee', 'sarah.lee@email.com'),
    ('Paul Graham', 'paul.graham@email.com');

-- Insert data into Authors table
INSERT INTO Authors (author_name, author_email)
VALUES
    ('John Doe', 'john.doe@email.com'),
    ('Jane Smith', 'jane.smith@email.com'),
    ('Tom Brown', 'tom.brown@email.com');

-- Insert data into Orders table
INSERT INTO Orders (customer_id, order_date)
VALUES
    (1, '2023-08-10'),
    (2, '2023-08-11'),
    (3, '2023-08-12'),
    (1, '2023-08-13'),
    (2, '2023-08-14'),
    (3, '2023-08-15');

-- Insert data into BookTypes table
INSERT INTO BookTypes (book_type_name)
VALUES
    ('Physical'),
    ('E-Book');

-- Insert data into Books table
INSERT INTO Books (book_title, book_type_id, author_id, order_id)
VALUES
    ('Programming Basics', 1, 2, 1),
    ('The Art of Coding', 1, 2, 2),
    ('Web Development', 2, 3, 3),
    ('Database Design', 1, 2, 4),
    ('Data Science', 2, 1, 5),
    ('Mobile App Development', 2, 3, 6);

-- Insert data into BookPrices table
INSERT INTO BookPrices (book_id, price)
VALUES
    (1, 20.00),
    (2, 25.00),
    (3, 15.00),
    (4, 18.00),
    (5, 30.00),
    (6, 22.00);

--- Insert data into sales table
INSERT INTO sales (product_name, quantity, price, book_id)
VALUES
    ('Programming Basics', 10, 20.00, 1), -- Menambahkan "book_id" yang sesuai
    ('The Art of Coding', 15, 25.00, 2), -- Menambahkan "book_id" yang sesuai
    ('Web Development', 20, 15.00, 3),  -- Menambahkan "book_id" yang sesuai
    ('Database Design', 10, 18.00, 4),  -- Menambahkan "book_id" yang sesuai
    ('Data Science', 12, 30.00, 5),     -- Menambahkan "book_id" yang sesuai
    ('Mobile App Development', 18, 22.00, 6); -- Menambahkan "book_id" yang sesuai


-- Tabel users
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    address TEXT,
    password VARCHAR(255),
    role VARCHAR(20) CHECK (role IN ('admin', 'member'))
);

INSERT INTO users (id, name, email, phone, address, password, role) VALUES
(1, 'Admin One', 'admin1@lib.com', '0800000001', 'Jl. Merdeka 1', '$2a$10$EAGnwC/cJ/WdW4JKz83CNu/13tN7SaepIfG8io3Rq9zJjFIFu3qo2', 'admin'),
(2, 'Admin Two', 'admin2@lib.com', '0800000002', 'Jl. Merdeka 2', '$2a$10$eRzGGNnGk7KA.ro6cqyIteXdC1HXPzz5m0fvpTv0m5OWWb8qwA6AK', 'admin'),
(3, 'Member One', 'member1@lib.com', '0811000001', 'Jl. Mawar 1', '$2a$10$fNoR/TyOxHLrD478HjmMIe4e6oPETcxN9OCdOM6C2SMfzK4Kx/CAK', 'member'),
(4, 'Member Two', 'member2@lib.com', '0811000002', 'Jl. Mawar 2', '$2a$10$EAGnwC/cJ/WdW4JKz83CNu/13tN7SaepIfG8io3Rq9zJjFIFu3qo2', 'member'),
(5, 'Member Three', 'member3@lib.com', '0811000003', 'Jl. Mawar 3', '$2a$10$eRzGGNnGk7KA.ro6cqyIteXdC1HXPzz5m0fvpTv0m5OWWb8qwA6AK', 'member'),
(6, 'Member Four', 'member4@lib.com', '0811000004', 'Jl. Mawar 4', '$2a$10$fNoR/TyOxHLrD478HjmMIe4e6oPETcxN9OCdOM6C2SMfzK4Kx/CAK', 'member'),
(7, 'Member Five', 'member5@lib.com', '0811000005', 'Jl. Mawar 5', '$2a$10$EAGnwC/cJ/WdW4JKz83CNu/13tN7SaepIfG8io3Rq9zJjFIFu3qo2', 'member'),
(8, 'Member Six', 'member6@lib.com', '0811000006', 'Jl. Mawar 6', '$2a$10$eRzGGNnGk7KA.ro6cqyIteXdC1HXPzz5m0fvpTv0m5OWWb8qwA6AK', 'member'),
(9, 'Member Seven', 'member7@lib.com', '0811000007', 'Jl. Mawar 7', '$2a$10$fNoR/TyOxHLrD478HjmMIe4e6oPETcxN9OCdOM6C2SMfzK4Kx/CAK', 'member'),
(10, 'Member Eight', 'member8@lib.com', '0811000008', 'Jl. Mawar 8', '$2a$10$EAGnwC/cJ/WdW4JKz83CNu/13tN7SaepIfG8io3Rq9zJjFIFu3qo2', 'member');

-- Tabel categories
CREATE TABLE categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

INSERT INTO categories (id, name) VALUES
(1, 'Teknologi'),
(2, 'Fiksi'),
(3, 'Sejarah'),
(4, 'Biografi'),
(5, 'Sains'),
(6, 'Ekonomi'),
(7, 'Pendidikan'),
(8, 'Psikologi'),
(9, 'Hukum'),
(10, 'Seni');

-- Tabel books
CREATE TABLE books (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200),
    category_id INT,
    stock INT,
    author VARCHAR(100),
    publisher VARCHAR(100),
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

INSERT INTO books (id, title, category_id, stock, author, publisher) VALUES
(1, 'Java untuk Pemula', 1, 5, 'Andi Nugroho', 'Gramedia'),
(2, 'Psikologi Remaja', 8, 3, 'Dian Kartika', 'Erlangga'),
(3, 'Fiksi Detektif', 2, 7, 'Rizky Amalia', 'Bentang'),
(4, 'Sejarah Nusantara', 3, 4, 'Budi Santoso', 'Kompas'),
(5, 'Hukum Perdata', 9, 6, 'Siti Rahmah', 'UI Press'),
(6, 'Pendidikan Anak', 7, 5, 'Yuniarti', 'Mizan'),
(7, 'Ekonomi Mikro', 6, 3, 'Tono Saputra', 'Salemba Empat'),
(8, 'Biografi BJ Habibie', 4, 4, 'Samsul Hadi', 'Gramedia'),
(9, 'Fisika Dasar', 5, 10, 'Lilis Mulyani', 'Erlangga'),
(10, 'Teknik Gambar', 10, 2, 'Ardiansyah', 'Tiga Serangkai');

-- Tabel transactions
CREATE TABLE transactions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    book_id INT,
    borrow_date DATE,
    due_date DATE,
    return_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (book_id) REFERENCES books(id)
);

INSERT INTO transactions (id, user_id, book_id, borrow_date, due_date, return_date) VALUES
(1, 3, 1, '2025-04-01', '2025-04-10', '2025-04-08'),
(2, 4, 2, '2025-04-02', '2025-04-09', NULL),
(3, 5, 3, '2025-04-03', '2025-04-12', '2025-04-15'),
(4, 6, 4, '2025-04-04', '2025-04-14', NULL),
(5, 7, 5, '2025-04-05', '2025-04-13', '2025-04-13'),
(6, 8, 6, '2025-04-06', '2025-04-16', NULL),
(7, 9, 7, '2025-05-07', '2025-06-17', NULL),
(8, 10, 8, '2025-05-08', '2025-05-18', '2025-05-19'),
(9, 3, 9, '2025-05-09', '2025-06-19', NULL),
(10, 4, 10, '2025-05-10', '2025-06-20', NULL);

-- Tabel fines
CREATE TABLE fines (
    id INT PRIMARY KEY AUTO_INCREMENT,
    transaction_id INT,
    status INT CHECK (status IN (0, 1)),
    FOREIGN KEY (transaction_id) REFERENCES transactions(id)
);

INSERT INTO fines (id, transaction_id, status) VALUES
(1, 2, 0),
(2, 4, 0),
(3, 6, 0),
(4, 8, 1);

-- Event scheduler untuk menambah entry pada tabel fines jika due_date transaksi sudah lewat dan belum ada entry di fines
DELIMITER //
CREATE EVENT IF NOT EXISTS add_fines_for_overdue_transactions
ON SCHEDULE EVERY 1 MINUTE
DO
BEGIN
    INSERT INTO fines (transaction_id, status)
    SELECT t.id, 0
    FROM transactions t
    LEFT JOIN fines f ON t.id = f.transaction_id
    WHERE t.return_date IS NULL AND t.due_date < CURDATE() AND f.id IS NULL;
END //
DELIMITER ;

-- Aktifkan event scheduler jika belum aktif
SET GLOBAL event_scheduler = ON;

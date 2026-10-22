CREATE DATABASE marketplace_barang_bekas;

USE marketplace_barang_bekas;

-- 1. Tabel Induk: Pengguna
CREATE TABLE pengguna (
    id_pengguna INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    no_hp VARCHAR(15),
    alamat TEXT
);

-- 2. Tabel Induk: Produk
CREATE TABLE produk (
    id_produk INT AUTO_INCREMENT PRIMARY KEY,
    nama_produk VARCHAR(100) NOT NULL,
    harga DECIMAL(12,2) NOT NULL,
    stok INT NOT NULL,
    status_produk ENUM('Tersedia', 'Terjual')
        DEFAULT 'Tersedia'
);

-- 3. Tabel Transaksi
CREATE TABLE transaksi (
    id_transaksi INT AUTO_INCREMENT PRIMARY KEY,
    id_pengguna INT NOT NULL,
    id_produk INT NOT NULL,
    tanggal_transaksi DATETIME NOT NULL,
    jumlah INT NOT NULL,
    total_pembayaran DECIMAL(12,2) NOT NULL,
    status_transaksi ENUM('Menunggu', 'Selesai', 'Dibatalkan')
        DEFAULT 'Menunggu',

    FOREIGN KEY (id_pengguna)
        REFERENCES pengguna(id_pengguna),

    FOREIGN KEY (id_produk)
        REFERENCES produk(id_produk)
);

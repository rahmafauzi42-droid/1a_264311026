CREATE DATABASE IF NOT EXISTS marketplace_barang_bekas;
USE marketplace_barang_bekas;

-- 1. Tabel Pengguna
CREATE TABLE pengguna (
    ID_Pengguna INT AUTO_INCREMENT PRIMARY KEY,
    Nama VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    No_HP VARCHAR(20),
    Alamat TEXT,
    Tipe_Pengguna ENUM('Pembeli', 'Penjual', 'Admin')
        NOT NULL
);

-- 2. Tabel Pembeli
CREATE TABLE pembeli (
    ID_Pembeli INT PRIMARY KEY,
    No_Pembeli VARCHAR(30),
    FOREIGN KEY (ID_Pembeli)
        REFERENCES pengguna(ID_Pengguna)
);

-- 3. Tabel Penjual
CREATE TABLE penjual (
    ID_Penjual INT PRIMARY KEY,
    No_Penjual VARCHAR(30),
    FOREIGN KEY (ID_Penjual)
        REFERENCES pengguna(ID_Pengguna)
);

-- 4. Tabel Admin
CREATE TABLE admin (
    ID_Admin INT PRIMARY KEY,
    No_Admin VARCHAR(30),
    FOREIGN KEY (ID_Admin)
        REFERENCES pengguna(ID_Pengguna)
);

-- 5. Tabel Kategori
CREATE TABLE kategori (
    ID_Kategori INT AUTO_INCREMENT PRIMARY KEY,
    Nama_Kategori VARCHAR(100) NOT NULL UNIQUE,
    Deskripsi_Kategori TEXT
);

-- 6. Tabel Produk
CREATE TABLE produk (
    ID_Produk INT AUTO_INCREMENT PRIMARY KEY,
    ID_Penjual INT NOT NULL,
    ID_Kategori INT NOT NULL,
    Nama_Produk VARCHAR(150) NOT NULL,
    Kondisi ENUM('Baru', 'Bekas') NOT NULL,
    Harga DECIMAL(12,2) NOT NULL,
    Deskripsi TEXT,
    Foto VARCHAR(255),
    Lokasi VARCHAR(150),
    Berat DECIMAL(10,2),
    CONSTRAINT chk_harga CHECK (Harga >= 0),
    CONSTRAINT chk_berat CHECK (Berat >= 0),
    FOREIGN KEY (ID_Penjual)
        REFERENCES penjual(ID_Penjual),
    FOREIGN KEY (ID_Kategori)
        REFERENCES kategori(ID_Kategori)
);

-- 7. Tabel Stok
CREATE TABLE stok (
    ID_Stok INT AUTO_INCREMENT PRIMARY KEY,
    ID_Produk INT NOT NULL UNIQUE,
    Jumlah_Awal INT NOT NULL DEFAULT 0,
    Jumlah_Terjual INT NOT NULL DEFAULT 0,
    CONSTRAINT chk_jumlah_awal CHECK (Jumlah_Awal >= 0),
    CONSTRAINT chk_jumlah_terjual CHECK (
        Jumlah_Terjual >= 0
        AND Jumlah_Terjual <= Jumlah_Awal
    ),
    FOREIGN KEY (ID_Produk)
        REFERENCES produk(ID_Produk)
);

-- 8. Tabel Transaksi
CREATE TABLE transaksi (
    ID_Transaksi INT AUTO_INCREMENT PRIMARY KEY,
    ID_Pembeli INT NOT NULL,
    ID_Penjual INT NOT NULL,
    Tanggal_Transaksi DATETIME
        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Status_Transaksi VARCHAR(40) NOT NULL
        DEFAULT 'Menunggu Pembayaran',
    FOREIGN KEY (ID_Pembeli)
        REFERENCES pembeli(ID_Pembeli),
    FOREIGN KEY (ID_Penjual)
        REFERENCES penjual(ID_Penjual)
);

-- 9. Tabel Detail Transaksi
CREATE TABLE detail_transaksi (
    ID_Detail INT AUTO_INCREMENT PRIMARY KEY,
    ID_Transaksi INT NOT NULL,
    ID_Produk INT NOT NULL,
    Jumlah INT NOT NULL,
    Harga_Satuan DECIMAL(12,2) NOT NULL,
    Subtotal DECIMAL(12,2) NOT NULL,
    CONSTRAINT chk_jumlah CHECK (Jumlah > 0),
    CONSTRAINT chk_harga_satuan CHECK (Harga_Satuan >= 0),
    CONSTRAINT chk_subtotal CHECK (Subtotal >= 0),
    FOREIGN KEY (ID_Transaksi)
        REFERENCES transaksi(ID_Transaksi),
    FOREIGN KEY (ID_Produk)
        REFERENCES produk(ID_Produk),
    UNIQUE (ID_Transaksi, ID_Produk)
);

-- 10. Tabel Pembayaran
CREATE TABLE pembayaran (
    ID_Pembayaran INT AUTO_INCREMENT PRIMARY KEY,
    ID_Transaksi INT NOT NULL UNIQUE,
    Metode_Pembayaran VARCHAR(50) NOT NULL,
    Jumlah_Pembayaran DECIMAL(12,2) NOT NULL,
    Status_Pembayaran VARCHAR(30) NOT NULL
        DEFAULT 'Belum Dibayar',
    Tanggal_Pembayaran DATETIME,
    CONSTRAINT chk_jumlah_pembayaran
        CHECK (Jumlah_Pembayaran >= 0),
    FOREIGN KEY (ID_Transaksi)
        REFERENCES transaksi(ID_Transaksi)
);

-- 11. Tabel Pengiriman
CREATE TABLE pengiriman (
    ID_Pengiriman INT AUTO_INCREMENT PRIMARY KEY,
    ID_Transaksi INT NOT NULL UNIQUE,
    Alamat_Pengiriman TEXT NOT NULL,
    Kurir VARCHAR(50),
    No_Resi VARCHAR(100),
    Status_Pengiriman VARCHAR(30)
        DEFAULT 'Belum Dikirim',
    FOREIGN KEY (ID_Transaksi)
        REFERENCES transaksi(ID_Transaksi)
);

-- 12. Tabel Laporan
CREATE TABLE laporan (
    ID_Laporan INT AUTO_INCREMENT PRIMARY KEY,
    ID_Pengguna INT NOT NULL,
    Jenis_Laporan VARCHAR(100) NOT NULL,
    Tanggal_Laporan DATETIME
        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Keterangan TEXT,
    FOREIGN KEY (ID_Pengguna)
        REFERENCES pengguna(ID_Pengguna)
);

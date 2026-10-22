1.CREAT (INSERT)
-TABEL PENGGUNA
INSERT INTO pengguna (nama, email, no_hp, alamat) VALUES
('Dapin', 'dapin@gmail.com', '081234567801', 'Madiun'),
('Mukti', 'mukti@gmail.com', '081234567802', 'Ngawi'),
('Imam', 'imam@gmail.com', '081234567803', 'Magetan');
-TABEL PRODUK
INSERT INTO produk (nama_produk, harga, stok, status_produk) VALUES
('Laptop Bekas', 3500000, 2, 'Tersedia'),
('Jaket Bekas', 75000, 5, 'Tersedia'),
('Sepatu Bekas', 50000, 3, 'Terjual');
-TABEL TRANSAKSI
INSERT INTO transaksi
(id_pengguna, id_produk, tanggal_transaksi, jumlah,
 total_pembayaran, status_transaksi)
VALUES
(1, 1, '2026-10-20 10:00:00', 1, 3500000, 'Selesai'),
(2, 2, '2026-10-20 11:00:00', 2, 150000, 'Menunggu'),
(3, 3, '2026-10-20 12:00:00', 1, 50000, 'Dibatalkan');

2.READ
SELECT * FROM pengguna;

3.UPDATE
UPDATE transaksi
SET status_transaksi = 'Menunggu'
WHERE id_transaksi = 1;

4.DELETE
DELETE FROM transaksi
WHERE id_transaksi = 3;

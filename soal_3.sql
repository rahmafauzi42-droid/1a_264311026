SELECT
    pengguna.nama AS nama_penjual,
    COUNT(produk.id_produk) AS jumlah_produk,
    SUM(produk.harga * produk.stok) AS total_nilai_stok
FROM pengguna
JOIN produk
    ON pengguna.id_pengguna = produk.id_pengguna
WHERE produk.status_produk = 'Tersedia'
GROUP BY pengguna.id_pengguna, pengguna.nama;

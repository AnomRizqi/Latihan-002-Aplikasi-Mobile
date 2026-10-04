# Latihan 002 - Aplikasi Mobile (Dart)

Repositori ini berisi implementasi program Dart untuk menghitung total pembayaran belanja berdasarkan serangkaian **Aturan Bisnis (Business Rules)** diskon dan keanggotaan (membership).

---

## 📋 Aturan Bisnis (Business Rules)

Berikut adalah aturan bisnis yang diterapkan pada sistem perhitungan belanja:

| Kode | Business Rule | Keterangan |
| :--- | :--- | :--- |
| **BR-01** | Belanja minimal **Rp100.000** mendapat diskon **10%**. | Jika total belanja < Rp100.000, diskon awal adalah 0%. |
| **BR-02** | Member mendapat tambahan diskon **5%** (*hanya jika BR-01 terpenuhi*). | Jika belanja ≥ Rp100.000 dan berstatus Member, total diskon menjadi **15%** (10% + 5%). Jika belanja < Rp100.000, status member tidak memberikan tambahan diskon. |
| **BR-03** | Total potongan maksimal **Rp25.000**. | Nilai potongan dibatasi hingga maksimum Rp25.000, meskipun perhitungan persentase menghasilkan nominal lebih dari batas tersebut. |

---

## 🛠️ Penjelasan Fungsi Program

Program dipecah menjadi beberapa fungsi modular untuk mempermudah pengujian dan keterbacaan kode (*Clean Code*):

### 1. `int hitungDiskon(int belanja, bool member)`
- Menghitung **persentase diskon** yang berhak diterima pelanggan.
- **Logika:**
  - Inisialisasi `diskon = 0`.
  - Jika `belanja >= 100000` (memenuhi **BR-01**), diskon diset menjadi `10`.
  - Di dalam kondisi tersebut, jika pelanggan adalah `member == true` (memenuhi **BR-02**), diskon ditambah `5` sehingga menjadi `15%`.
  - Mengembalikan nilai persentase diskon.

### 2. `int hitungPotongan(int belanja, int diskon)`
- Menghitung **nominal potongan rupiah** dari persentase diskon.
- **Logika:**
  - Dihitung menggunakan operator integer division: `belanja * diskon ~/ 100`.
  - Memeriksa batas maksimal (**BR-03**): jika hasil potongan `> 25000`, maka nominal potongan dipatok menjadi `25000`.
  - Mengembalikan nominal potongan rupiah.

### 3. `int hitungTotal(int belanja, bool member)`
- Menghitung **total akhir yang harus dibayar** oleh pembeli.
- Menggabungkan pemanggilan fungsi `hitungDiskon` dan `hitungPotongan`, lalu mengembalikan `belanja - potongan`.

### 4. `void main()`
- Fungsi utama yang mengeksekusi 4 skenario pengujian untuk memvalidasi seluruh Business Rules.

---

## 🧪 Skenario Pengujian & Hasil Output

Program menguji 4 skenario kasus belanja:

| Skenario | Total Belanja | Status Member | Persentase Diskon | Nominal Potongan | Total Bayar | Aturan yang Terpenuhi |
| :---: | :---: | :---: | :---: | :---: | :---: | :--- |
| **1** | Rp70.000 | Non-Member (`false`) | 0% | Rp0 | **Rp70.000** | Belanja < Rp100.000, tidak ada diskon. |
| **2** | Rp120.000 | Non-Member (`false`) | 10% | Rp12.000 | **Rp108.000** | Memenuhi **BR-01**. |
| **3** | Rp120.000 | Member (`true`) | 15% | Rp18.000 | **Rp102.000** | Memenuhi **BR-01** dan **BR-02**. |
| **4** | Rp250.000 | Member (`true`) | 15% | Rp25.000 *(Capped)* | **Rp225.000** | Memenuhi **BR-01**, **BR-02**, dan dibatasi oleh **BR-03** (potongan seharusnya Rp37.500 dipotong maks Rp25.000). |

### Output Terminal
```text
Skenario 1
Belanja: Rp70000
Member: false
Bayar: Rp70000

Skenario 2
Belanja: Rp120000
Member: false
Bayar: Rp108000

Skenario 3
Belanja: Rp120000
Member: true
Bayar: Rp102000

Skenario 4
Belanja: Rp250000
Member: true
Bayar: Rp225000
```

---

## 💻 Kode Lengkap (`latihan002.dart`)

```dart
void main() {
  // Case 1
  int belanja1 = 70000;
  bool member1 = false;

  print("Skenario 1");
  print("Belanja: Rp$belanja1");
  print("Member: $member1");
  print("Bayar: Rp${hitungTotal(belanja1, member1)}");

  print("");

  // Case 2
  int belanja2 = 120000;
  bool member2 = false;

  print("Skenario 2");
  print("Belanja: Rp$belanja2");
  print("Member: $member2");
  print("Bayar: Rp${hitungTotal(belanja2, member2)}");

  print("");

  // Case 3
  int belanja3 = 120000;
  bool member3 = true;

  print("Skenario 3");
  print("Belanja: Rp$belanja3");
  print("Member: $member3");
  print("Bayar: Rp${hitungTotal(belanja3, member3)}");

  print("");

  // Case 4
  int belanja4 = 250000;
  bool member4 = true;

  print("Skenario 4");
  print("Belanja: Rp$belanja4");
  print("Member: $member4");
  print("Bayar: Rp${hitungTotal(belanja4, member4)}");
}

int hitungDiskon(int belanja, bool member) {
  int diskon = 0;

  if (belanja >= 100000) {
    diskon = 10;

    if (member) {
      diskon += 5;
    }
  }

  return diskon;
}

int hitungPotongan(int belanja, int diskon) {
  int potongan = belanja * diskon ~/ 100;

  if (potongan > 25000) {
    potongan = 25000;
  }

  return potongan;
}

int hitungTotal(int belanja, bool member) {
  int diskon = hitungDiskon(belanja, member);
  int potongan = hitungPotongan(belanja, diskon);

  return belanja - potongan;
}
```

---

## 🚀 Cara Menjalankan

Pastikan SDK Dart / Flutter telah terpasang pada perangkat Anda, lalu jalankan perintah:

```bash
dart run latihan002.dart
```

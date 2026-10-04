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

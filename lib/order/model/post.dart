class WorkOrders {
  late String mpsNo;
  late String mamulAdi;
  late String stokKodu;
  late String uretimMik;
  late String baslangicTarihi;
  late String teslimTarihi;
  late String musteriAdi;
  late String foto;

  WorkOrders(
    String mpsNo,
    String mamulAdi,
    String stokKodu,
    String uretimMik,
    String baslangicTarihi,
    String teslimTarihi,
    String musteriAdi,
    String foto,
  ) {
    this.mpsNo = mpsNo;
    this.mamulAdi = mamulAdi;
    this.stokKodu = stokKodu;
    this.uretimMik = uretimMik;
    this.baslangicTarihi = baslangicTarihi;
    this.teslimTarihi = teslimTarihi;
    this.musteriAdi = musteriAdi;
    this.foto = foto;
  }
}

class InsideOrders {
  late int operasyonNo;
  late String tezgah;
  late String operasyonAdi;
  late int uretimMiktari;
  late int cevrimSuresi;
  late int toplamSure;
  late String receteNotu;
  late bool isWorking;

  InsideOrders(
      int operasyonNo,
      String tezgah,
      String operasyonAdi,
      int uretimMiktari,
      int cevrimSuresi,
      int toplamSure,
      String receteNotu,
      bool isWorking) {
    this.operasyonNo = operasyonNo;
    this.tezgah = tezgah;
    this.operasyonAdi = operasyonAdi;
    this.uretimMiktari = uretimMiktari;
    this.cevrimSuresi = cevrimSuresi;
    this.toplamSure = toplamSure;
    this.receteNotu = receteNotu;
    this.isWorking = isWorking;
  }
}

import 'package:flutter/material.dart';

class FinalProvider extends ChangeNotifier {
  String _ayar = "AYAR";
  String _kesinti = "KESİNTİ";
  final String _mola = "MOLA";
  final String _lorem = "LOREM";
  final String _gunSonu = "GÜN SONU";
  final String _isBitimi = "İŞ BİTİMİ";
  bool checkState = false;

  String get ayar => _ayar;
  String get kesinti => _kesinti;
  String get mola => _mola;
  String get lorem => _lorem;
  String get gunSonu => _gunSonu;
  String get isBitimi => _isBitimi;

  void ayarState() {
    final isAyar = _ayar == "AYAR";
    if (isAyar) {
      _ayar = "AYARI DURDUR";
      checkState = !checkState;
    } else {
      _ayar = "AYAR";
      checkState = !checkState;
    }
    notifyListeners();
  }

  void kesintiState() {
    final isKesinti = _kesinti == "KESİNTİ";
    if (isKesinti) {
      _kesinti = "KESİNTİYİ DURDUR";
      checkState = !checkState;
    } else {
      _kesinti = "KESİNTİ";
      checkState = !checkState;
    }
    notifyListeners();
  }
}

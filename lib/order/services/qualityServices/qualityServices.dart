class QualityServices {
  static Future<dynamic> isQualityCaseStarted(
    String evrakNo,
    String notes,
  ) async {
    print(evrakNo + "-" + notes);
  }

  static Future<void> sendProduceInfo(Map<String, dynamic> body) async {
    print(body.toString());
  }

  static Future<void> endOfDayQuality(Map<String, dynamic> body) async {
    print(body.toString());
  }

 static Future<void> endOfWorkQuality(Map<String, dynamic> body) async {
    print(body.toString());
  }

    static Future<void> stopReasonInfo(Map<String, dynamic> body) async {
    print(body.toString());
  }
     static Future<void> continueProcess(Map<String, dynamic> body) async {
    print(body.toString());
  }
  
}

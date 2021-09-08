// To parse this JSON data, do
//
//     final myCoinData = myCoinDataFromJson(jsonString);

import 'dart:convert';

MyCoinData myCoinDataFromJson(String str) =>
    MyCoinData.fromJson(json.decode(str));

String myCoinDataToJson(MyCoinData data) => json.encode(data.toJson());

class MyCoinData {
  MyCoinData({
    this.time,
    this.assetIdBase,
    this.assetIdQuote,
    this.rate,
  });

  DateTime time;
  String assetIdBase;
  String assetIdQuote;
  var rate;

  factory MyCoinData.fromJson(Map<String, dynamic> json) => MyCoinData(
        time: DateTime.parse(json["time"]),
        assetIdBase: json["asset_id_base"],
        assetIdQuote: json["asset_id_quote"],
        rate: json["rate"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "time": time.toIso8601String(),
        "asset_id_base": assetIdBase,
        "asset_id_quote": assetIdQuote,
        "rate": rate,
      };

  @override
  String toString() {
    return 'Crypto time: $time, assetIdBase: $assetIdBase, assetIdQuote: $assetIdQuote, rate: $rate';
  }
}

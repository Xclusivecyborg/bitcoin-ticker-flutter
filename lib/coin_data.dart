import 'dart:convert';
import 'dart:io';

import 'package:bitcoin_ticker/models.dart';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const apiKey = '607EBCA6-755E-417D-893C-E48BED046F80';

class CoinData {
  Future getBTC({String currency}) async {
    String coinAPIURL =
        'https://rest.coinapi.io/v1/exchangerate/BTC/$currency?apiKey=$apiKey';
    try {
      http.Response response = await http.get(
        Uri.parse(coinAPIURL),
        headers: {'X-CoinAPI-Key': '607EBCA6-755E-417D-893C-E48BED046F80'},
      );
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return MyCoinData.fromJson(responseBody);
      } else {
        print(response.statusCode);
      }
    } on SocketException {
      throw "You're not connected to the internet";
    } catch (e) {
      print(e.toString());
    }
  }

  Future getETH({String currency}) async {
    String coinAPIURL =
        'https://rest.coinapi.io/v1/exchangerate/ETH/$currency?apiKey=$apiKey';
    try {
      http.Response response = await http.get(
        Uri.parse(coinAPIURL),
        headers: {'X-CoinAPI-Key': '607EBCA6-755E-417D-893C-E48BED046F80'},
      );
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return MyCoinData.fromJson(responseBody);
      } else {
        print(response.statusCode);
      }
    } on SocketException {
      throw "You're not connected to the internet";
    } catch (e) {
      print(e.toString());
    }
  }

  Future getLTC({String currency}) async {
    String coinAPIURL =
        'https://rest.coinapi.io/v1/exchangerate/LTC/$currency?apiKey=$apiKey';
    try {
      http.Response response = await http.get(
        Uri.parse(coinAPIURL),
        headers: {'X-CoinAPI-Key': '607EBCA6-755E-417D-893C-E48BED046F80'},
      );
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return MyCoinData.fromJson(responseBody);
      } else {
        print(response.statusCode);
      }
    } on SocketException {
      throw "You're not connected to the internet";
    } catch (e) {
      print(e.toString());
    }
  }
}

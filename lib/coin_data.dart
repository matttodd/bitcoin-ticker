import 'package:http/http.dart' as http;
import 'dart:convert';

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

const urlBase = "https://rest.coinapi.io/v1/exchangerate/";

const apiKey = "0A763A20-936B-49B5-AE52-921D0487FAF2";

class CoinData {
  Map<String, String> tickerValues = Map.fromIterable(
    cryptoList,
    key: (k) => k,
    value: (v) => '?',
  );
//  Map<String, int> tickerValues = {'BTC': null, 'ETH': null, 'LTE': null};

  Future<Map<String, String>> getCoinData(String fiat) async {
    var client = http.Client();
    for (String ticker in tickerValues.keys) {
      var response = await client.get(urlBase + "$ticker/$fiat?apiKey=$apiKey");
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        tickerValues[ticker] = data['rate'].toInt().toString();
      } else {
        print(response.statusCode);
        print(response.body);
      }
    }
    return tickerValues;
  }
}

import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String currencyChosen = 'AUD';

  Container androidPicker() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currenciesList) {
      var item = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownItems.add(item);
    }
    return Container(
      padding: EdgeInsets.all(15),
      height: 50.0,
      width: 100.0,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(15),
        color: Colors.lightBlue,
      ),
      child: DropdownButton<String>(
        dropdownColor: Colors.lightBlue,
        underline: SizedBox(),
        value: currencyChosen,
        items: dropDownItems,
        onChanged: (value) {
          setState(() {
            currencyChosen = value;
            getData();
            print(currencyChosen);
          });
        },
      ),
    );
  }

  CupertinoPicker iosPicker() {
    List<Widget> listItem = [];
    for (String currency in currenciesList) {
      var item = Text(currency);
      listItem.add(item);
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (int index) {
        setState(() {
          currencyChosen = currenciesList[index];
        });
      },
      children: listItem,
    );
  }

  bool isLoading = true;

  String bitPrice, ethePrice, litPrice;

  Future getData() async {
    try {
      var btcPrice = await CoinData().getBTC(currency: currencyChosen);
      var ethPrice = await CoinData().getETH(currency: currencyChosen);
      var ltcPrice = await CoinData().getLTC(currency: currencyChosen);

      setState(() {
        double bitcoinPrice = btcPrice.rate;
        bitPrice = bitcoinPrice.toStringAsFixed(0);
        double ethereumPrice = ethPrice.rate;
        ethePrice = ethereumPrice.toStringAsFixed(0);
        double litecoinPrice = ltcPrice.rate;
        litPrice = litecoinPrice.toStringAsFixed(0);
        isLoading = false;
      });
      print(btcPrice);
      print(ethPrice);
      print(ltcPrice);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              PriceDisplay(
                  currency: cryptoList[0],
                  isLoading: isLoading,
                  price: bitPrice,
                  currencyChosen: currencyChosen),
              PriceDisplay(
                  currency: cryptoList[1],
                  isLoading: isLoading,
                  price: ethePrice,
                  currencyChosen: currencyChosen),
              PriceDisplay(
                  currency: cryptoList[2],
                  isLoading: isLoading,
                  price: litPrice,
                  currencyChosen: currencyChosen),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isAndroid ? androidPicker() : iosPicker(),
          ),
        ],
      ),
    );
  }
}

class PriceDisplay extends StatelessWidget {
  const PriceDisplay({
    Key key,
    @required this.isLoading,
    @required this.price,
    @required this.currencyChosen,
    @required this.currency,
  }) : super(key: key);

  final bool isLoading;
  final String price;
  final String currencyChosen;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Text(
                  '1 $currency = $price $currencyChosen',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}

// Container(
              // padding: EdgeInsets.all(15),
              // height: 50.0,
              // width: 100.0,
              // decoration: BoxDecoration(
              //   border: Border.all(color: Colors.white),
              //   borderRadius: BorderRadius.circular(15),
              //   color: Colors.lightBlueAccent,
              // ),
              // child: DropdownButton<String>(
              //   dropdownColor: Colors.lightBlueAccent,
              //   underline: SizedBox(),
              //   value: currencyChosen,
              //   items: getCurrency(),
              //   onChanged: (value) {
              //     setState(() {
              //       currencyChosen = value;
              //     });
              //   },
              // ),
            // ),
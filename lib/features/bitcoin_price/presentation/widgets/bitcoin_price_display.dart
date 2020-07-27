import 'package:btclean/features/bitcoin_price/domain/entities/bitcoin_price.dart';
import 'package:flutter/material.dart';

class BitcoinPriceDisplay extends StatelessWidget {
  final BitcoinPrice bitcoinPrice;

  const BitcoinPriceDisplay({@required this.bitcoinPrice});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '${bitcoinPrice.eurRate.toString()} USD',
            style: TextStyle(fontSize: 20),
          ),
          Text(
            '${bitcoinPrice.usdRate.toString()} EUR',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'last update:',
            style: TextStyle(fontSize: 20),
          ),
          Text(
            '${bitcoinPrice.time}',
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}

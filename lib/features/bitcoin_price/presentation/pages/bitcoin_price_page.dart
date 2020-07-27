import 'package:btclean/features/bitcoin_price/presentation/bloc/bitcoin_price_bloc.dart';
import 'package:btclean/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BitcoinPricePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BITCOIN PRICE NOW'),
      ),
      body: BlocProvider(
        create: (_) => sl<BitcoinPriceBloc>(),
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 3,
              child: Placeholder(),
            ),
            FlatButton(),
          ],
        ),
      ),
    );
  }
}

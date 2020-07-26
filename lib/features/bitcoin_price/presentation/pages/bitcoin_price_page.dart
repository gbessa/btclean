import 'package:btclean/features/bitcoin_price/presentation/bloc/bitcoin_price_bloc.dart';
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
        builder: (_) => BitcoinPriceBloc(),
        child: Container(),
      ),
    );
  }
}

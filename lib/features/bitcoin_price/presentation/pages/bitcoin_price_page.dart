import 'package:btclean/core/config/app_colors.dart';
import 'package:btclean/features/bitcoin_price/presentation/bloc/bitcoin_price_bloc.dart';
import 'package:btclean/features/bitcoin_price/presentation/widgets/widgets.dart';
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
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<BitcoinPriceBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<BitcoinPriceBloc>(),
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            BlocBuilder<BitcoinPriceBloc, BitcoinPriceState>(
              builder: (context, state) {
                if (state is Empty) {
                  return MessageDisplay(
                      message:
                          'Click at the button to fetch the current Bitcoin price...');
                } else if (state is Loading) {
                  return LoadingWidget();
                } else if (state is Loaded) {
                  return BitcoinPriceDisplay(
                    bitcoinPrice: state.bitcoinPrice,
                  );
                } else if (state is Error) {
                  return MessageDisplay(message: state.message);
                } else {
                  return MessageDisplay(message: 'State Unknown');
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
            GetPriceButton(),
          ],
        ),
      ),
    );
  }
}

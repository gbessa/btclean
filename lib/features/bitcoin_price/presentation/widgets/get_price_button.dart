import 'package:btclean/core/config/app_colors.dart';
import 'package:btclean/features/bitcoin_price/presentation/bloc/bitcoin_price_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetPriceButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: AppColors.mainColor,
      child: Text('Get current price...'),
      onPressed: () {
        BlocProvider.of<BitcoinPriceBloc>(context)
            .add(GetBitCoinCurrentPrice());
      },
    );
  }
}

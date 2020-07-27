import 'package:btclean/features/bitcoin_price/presentation/pages/bitcoin_price_page.dart';
import 'package:flutter/material.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(); // Guarantee that the future dependencies will be initiated
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bitcoin Price',
      theme: ThemeData(primaryColor: Color.fromRGBO(112, 199, 115, 1.0)),
      home: BitcoinPricePage(),
    );
  }
}

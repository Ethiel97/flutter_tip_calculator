import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Tip Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // This is the default bill amount 1
  static const defaultBillAmount = 0.0;

  // This is the default tip percentage 2
  static const defaultTipPercentage = 15;

  // This is the TextEditingController which is used to keep track of the change in bill amount 3
  final _billAmountController =
      TextEditingController(text: defaultBillAmount.toString());

  // This is the TextEditingController which is used to keep track of the change in tip percentage 4
  final _tipPercentageController =
      TextEditingController(text: defaultTipPercentage.toString());

  // This stores the latest value of bill amount calculated 5
  double _billAmount = defaultBillAmount;

  // This stores the latest value of tip percentage calculated 6
  int _tipPercentage = defaultTipPercentage;

  @override
  void initState() {
    super.initState();

    //TODO: ADD code for listeners here
    _billAmountController.addListener(_onBillAmountChanged);
    _tipPercentageController.addListener(_onTipAmountChanged);
  }

  @override
  void dispose() {
    // TODO: ADD code to remove listeners
    //1
    _billAmountController.removeListener(_onBillAmountChanged);
    //2
    _tipPercentageController.removeListener(_onTipAmountChanged);
    super.dispose();
  }

  //TODO: ADD compute functions
  //1
  void _onBillAmountChanged() {
    setState(() {
      _billAmount = double.tryParse(_billAmountController.text) ?? 0.0;
    });
  }

  //2
  void _onTipAmountChanged() {
    setState(() {
      _tipPercentage = int.tryParse(_tipPercentageController.text) ?? 0;
    });
  }

  //3
  double _getTipAmount() => _billAmount * _tipPercentage / 100;

  //4
  double _getTotalAmount() => _billAmount + _getTipAmount();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white70,
          title: const Text(
            'Tip Calculator',
            style: TextStyle(color: Colors.black87),
          ),
        ),
        body: Container(
          color: Colors.white70,
          padding: const EdgeInsets.all(32.0),
          child: Center(
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    key: const Key('billAmount'),
                    controller: _billAmountController,
                    keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      hintText: 'Enter the Bill Amount',
                      labelText: 'Bill Amount',
                      labelStyle: TextStyle(
                        fontSize: 25,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                      ),
                      fillColor: Colors.white,
                      border: UnderlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    key: const Key('tipPercentage'),
                    controller: _tipPercentageController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Enter the Tip Percentage',
                      labelText: 'Tip Percentage',
                      labelStyle: TextStyle(
                        fontSize: 25,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                      ),
                      fillColor: Colors.white,
                      border: UnderlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.all(15),
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Text(
                          'Tip Amount: ${_getTipAmount()}',
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Total Amount: ${_getTotalAmount()}',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

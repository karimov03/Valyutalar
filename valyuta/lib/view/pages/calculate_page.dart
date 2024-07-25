import 'package:flutter/material.dart';
import '../../model/api_data.dart';

class CalculatePage extends StatefulWidget {
  final List<ApiData> alldata;

  const CalculatePage(this.alldata, {Key? key}) : super(key: key);

  @override
  _CalculatePageState createState() => _CalculatePageState();
}

class _CalculatePageState extends State<CalculatePage> {
  String? _fromCurrency;
  String? _toCurrency;
  String _inputValue = '';
  double? _result;

  void _calculate() {
    if (_fromCurrency != null &&
        _toCurrency != null &&
        _inputValue.isNotEmpty) {
      var fromCurrencyData =
          widget.alldata.firstWhere((data) => data.Ccy == _fromCurrency);
      var toCurrencyData =
          widget.alldata.firstWhere((data) => data.Ccy == _toCurrency);

      double fromRate = double.parse(fromCurrencyData.Rate);
      double toRate = double.parse(toCurrencyData.Rate);

      setState(() {
        _result = (double.parse(_inputValue) * fromRate) / toRate;
      });
    }
  }

  void _onNumberPress(String number) {
    setState(() {
      _inputValue += number;
    });
  }

  void _onClear() {
    setState(() {
      _inputValue = '';
      _result = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 11, 12, 21),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 22, 24, 39),
        title: Text(
          "Valyuta Kalkulyatori",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DropdownButton<String>(
                  hint: Text("Qaysi valyutadan",
                      style: TextStyle(color: Colors.green)),
                  value: _fromCurrency,
                  items: widget.alldata.map((data) {
                    return DropdownMenuItem<String>(
                      value: data.Ccy,
                      child: Text(
                        data.Ccy,
                        style: TextStyle(
                          color: Colors.green,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _fromCurrency = value;
                    });
                  },
                ),
                DropdownButton<String>(
                  hint: Text("Qaysi valyutaga",
                      style: TextStyle(color: Colors.red)),
                  value: _toCurrency,
                  items: widget.alldata.map((data) {
                    return DropdownMenuItem<String>(
                      value: data.Ccy,
                      child:
                          Text(data.Ccy, style: TextStyle(color: Colors.red)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _toCurrency = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              _inputValue,
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            SizedBox(height: 20),
            _buildNumberPad(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculate,
              child: Text("Hisoblash"),
            ),
            SizedBox(height: 20),
            _result != null
                ? Text(
                    "Natija: ${_result!.toStringAsFixed(2)} $_toCurrency",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberPad() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNumberButton('1'),
            _buildNumberButton('2'),
            _buildNumberButton('3'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNumberButton('4'),
            _buildNumberButton('5'),
            _buildNumberButton('6'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNumberButton('7'),
            _buildNumberButton('8'),
            _buildNumberButton('9'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNumberButton('0'),
            _buildNumberButton('.'),
            ElevatedButton(
              onPressed: _onClear,
              child: Text('C'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNumberButton(String number) {
    return ElevatedButton(
      onPressed: () => _onNumberPress(number),
      child: Text(number),
    );
  }
}

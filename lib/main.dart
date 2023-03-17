import 'package:flutter/material.dart';

void main() {
  runApp(BMICalculator());
}

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      home: Scaffold(
        appBar: AppBar(
          title: Text('BMI Calculator'),
        ),
        body: Center(
          child: BMICalculatorForm(),
        ),
      ),
    );
  }
}

class BMICalculatorForm extends StatefulWidget {
  @override
  _BMICalculatorFormState createState() => _BMICalculatorFormState();
}

class _BMICalculatorFormState extends State<BMICalculatorForm> {
  final _formKey = GlobalKey<FormState>();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _ageController = TextEditingController();
  late double _bmiResult=0.0;

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _calculateBMI() {
    double height = double.tryParse(_heightController.text) ?? 0;
    double weight = double.tryParse(_weightController.text) ?? 0;
    double age = double.tryParse(_ageController.text) ?? 0;

    if (height > 0 && weight > 0) {
      setState(() {
        _bmiResult = weight / ((height / 100) * (height / 100));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: _ageController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Enter your age',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your age';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _heightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Enter your height in cm',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your height';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _weightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Enter your weight in kg',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your weight';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _calculateBMI();
              }
            },
            child: Text('Calculate'),
          ),
          SizedBox(height: 16),
          if (_bmiResult != null)
            Text(
              'Your BMI is ${_bmiResult.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 24),
            ),
        ],
      ),
    );
  }
}
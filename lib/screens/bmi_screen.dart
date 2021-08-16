import 'package:flutter/material.dart';
import '../shared/menu_bottom.dart';
import '../shared/menu_drawer.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({Key? key}) : super(key: key);

  @override
  _BmiScreenState createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  final TextEditingController txtHeight = TextEditingController();
  final TextEditingController txtWeight = TextEditingController();
  final double fontSize = 18;
  String result = '';
  bool isMetric = true;
  bool isImperial = false;
  double? height;
  double? weight;
  String? heightMessage;
  String? weightMessage;
  late List<bool> isSelected;

  @override
  void initState() {
    isSelected = [isMetric, isImperial];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    heightMessage =
        'Please insert your height in ' + ((isMetric) ? 'metres' : 'inches');
    weightMessage =
        'Please insert your weight in ' + ((isMetric) ? 'kilograms' : 'pounds');
    return Scaffold(
      appBar: AppBar(title: Text('BMI Calculator')),
      bottomNavigationBar: MenuBottom(),
      drawer: MenuDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ToggleButtons(
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child:
                          Text('Metric', style: TextStyle(fontSize: fontSize))),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text('Imperial',
                          style: TextStyle(fontSize: fontSize))),
                ],
                isSelected: isSelected,
                onPressed: toggleMeasure,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: TextField(
                controller: txtHeight,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: heightMessage,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: TextField(
                controller: txtWeight,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: weightMessage,
                ),
              ),
            ),
            ElevatedButton(
              child: Text('Calculate BMI',
                  style: TextStyle(
                    fontSize: fontSize,
                  )),
              onPressed: findBMI,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(result, style: TextStyle(fontSize: fontSize)),
            ),
          ],
        ),
      ),
    );
  }

  void toggleMeasure(value) {
    if (value == 0) {
      isMetric = true;
      isImperial = false;
    } else {
      isMetric = false;
      isImperial = true;
    }
    setState(() {
      isSelected = [isMetric, isImperial];
    });
  }

  void findBMI() {
    double bmi = 0;
    double height = double.tryParse(txtHeight.text) ?? 0;
    double weight = double.tryParse(txtWeight.text) ?? 0;
    if (isMetric) {
      bmi = weight / (height * height);
    } else {
      bmi = weight * 703 / (height * height);
    }
    setState(() {
      if (bmi.isNaN) {
        result = 'Please enter the values correctly';
      } else {
        result = 'Your BMI is ' + bmi.toStringAsFixed(2);
      }
    });
  }
}

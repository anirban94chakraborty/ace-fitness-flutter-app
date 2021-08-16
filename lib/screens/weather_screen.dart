import 'package:flutter/material.dart';
import '../shared/menu_drawer.dart';
import '../data/weather.dart';
import '../data/http_helper.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController txtCity = TextEditingController();
  Weather result = Weather('', '', 0, 0, 0, 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Weather')),
        drawer: MenuDrawer(),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: ListView(
            children: [
              Padding(
                  padding: EdgeInsets.all(16),
                  child: TextField(
                    controller: txtCity,
                    decoration: InputDecoration(
                        hintText: 'Enter a city',
                        suffixIcon: IconButton(
                            icon: Icon(Icons.search), onPressed: getData)
                        ),
                  )
              ),
              weatherRow('Place: ', result.name),
              weatherRow('Description: ', result.description),
              weatherRow('Temperature: ', result.temperature.toStringAsFixed(2) + ' ℃'),
              weatherRow('Feels Like: ', result.perceived.toStringAsFixed(2) + ' ℃'),
              weatherRow('Humidity: ', result.humidity.toStringAsFixed(2)),
              weatherRow('Pressure: ', result.pressure.toStringAsFixed(2)),
            ],
          ),
        ));
  }

  Future getData() async {
    HttpHelper helper = HttpHelper();
    result = await helper.getWeather(txtCity.text);
    setState(() {});
  }

  Widget weatherRow(String label, String value) {
    Widget row = Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).hintColor,
                  ),
                )),
            Expanded(
                flex: 4,
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).primaryColor,
                  ),
                ))
          ],
        ));
    return row;
  }
}

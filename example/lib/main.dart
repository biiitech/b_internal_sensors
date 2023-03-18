import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_sensor_controller/flutter_sensor_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _tempAvailable = false;
  bool _humidityAvailable = false;
  bool _lightAvailable = false;
  bool _pressureAvailable = false;
  final FlutterSensorController = FlutterSensorController();

  @override
  void initState() {
    super.initState();
    FlutterSensorController.pressure.listen((pressure) {
      print(pressure.toString());
    });
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    bool tempAvailable;
    bool humidityAvailable;
    bool lightAvailable;
    bool pressureAvailable;

    tempAvailable = await FlutterSensorController.getSensorAvailable(
        SensorType.AmbientTemperature);
    humidityAvailable =
        await FlutterSensorController.getSensorAvailable(SensorType.Humidity);
    lightAvailable =
        await FlutterSensorController.getSensorAvailable(SensorType.Light);
    pressureAvailable =
        await FlutterSensorController.getSensorAvailable(SensorType.Pressure);

    setState(() {
      _tempAvailable = tempAvailable;
      _humidityAvailable = humidityAvailable;
      _lightAvailable = lightAvailable;
      _pressureAvailable = pressureAvailable;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Environment Sensors'),
          ),
          body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            (_tempAvailable)
                ? StreamBuilder<double>(
                    stream: FlutterSensorController.humidity,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return CircularProgressIndicator();
                      return Text(
                          'The Current Humidity is: ${snapshot.data.toStringAsFixed(2)}%');
                    })
                : Text('No relative humidity sensor found'),
            (_humidityAvailable)
                ? StreamBuilder<double>(
                    stream: FlutterSensorController.temperature,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return CircularProgressIndicator();
                      return Text(
                          'The Current Temperature is: ${snapshot.data.toStringAsFixed(2)}');
                    })
                : Text('No temperature sensor found'),
            (_lightAvailable)
                ? StreamBuilder<double>(
                    stream: FlutterSensorController.light,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return CircularProgressIndicator();
                      return Text(
                          'The Current Light is: ${snapshot.data.toStringAsFixed(2)}');
                    })
                : Text('No light sensor found'),
            (_pressureAvailable)
                ? StreamBuilder<double>(
                    stream: FlutterSensorController.pressure,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return CircularProgressIndicator();
                      return Text(
                          'The Current Pressure is: ${snapshot.data.toStringAsFixed(2)}');
                    })
                : Text('No pressure sensure found'),
            //ElevatedButton(onPressed: initPlatformState , child: Text('Get'))
          ])),
    );
  }
}

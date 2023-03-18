import 'package:flutter/material.dart';
import 'dart:async';

import 'package:b_internal_sensors/b_internal_sensors.dart';

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
  final sensorController = BInternalSensors();

  @override
  void initState() {
    super.initState();
    sensorController.pressure.listen((pressure) {
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

    tempAvailable = await sensorController
        .getSensorAvailable(BInternalSensorType.AMBIENT_TEMPERATURE);
    humidityAvailable =
        await sensorController.getSensorAvailable(BInternalSensorType.HUMIDITY);
    lightAvailable =
        await sensorController.getSensorAvailable(BInternalSensorType.LIGHT);
    pressureAvailable =
        await sensorController.getSensorAvailable(BInternalSensorType.PRESSURE);

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
                    stream: sensorController.humidity,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return CircularProgressIndicator();
                      return Text(
                          'The Current Humidity is: ${snapshot.data.toStringAsFixed(2)}%');
                    })
                : Text('No relative humidity sensor found'),
            (_humidityAvailable)
                ? StreamBuilder<double>(
                    stream: sensorController.temperature,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return CircularProgressIndicator();
                      return Text(
                          'The Current Temperature is: ${snapshot.data.toStringAsFixed(2)}');
                    })
                : Text('No temperature sensor found'),
            (_lightAvailable)
                ? StreamBuilder<double>(
                    stream: sensorController.light,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return CircularProgressIndicator();
                      return Text(
                          'The Current Light is: ${snapshot.data.toStringAsFixed(2)}');
                    })
                : Text('No light sensor found'),
            (_pressureAvailable)
                ? StreamBuilder<double>(
                    stream: sensorController.pressure,
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

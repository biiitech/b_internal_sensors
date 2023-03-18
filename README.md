# Environment Sensors


Flutter plugin for accessing ambient temperature, relative humidity, ambient light, and barometric pressure sensors of a device.
## Install
Add ```flutter_sensor_controller``` as a dependency in  `pubspec.yaml`.
For help on adding as a dependency, view the [documentation](https://flutter.io/using-packages/).

## Usage
Check for availability of sensors
```dart
final FlutterSensorController = FlutterSensorController();   

    var tempAvailable = await FlutterSensorController.getSensorAvailable(SensorType.AmbientTemperature);
    var humidityAvailable = await FlutterSensorController.getSensorAvailable(SensorType.Humidity);
    var lightAvailable = await FlutterSensorController.getSensorAvailable(SensorType.Light);
    var pressureAvailable = await FlutterSensorController.getSensorAvailable(SensorType.Pressure);
```

Get sensor stream
```dart
final FlutterSensorController = FlutterSensorController();

  FlutterSensorController.pressure.listen((pressure) {
    //Pressure in Millibars
    print(pressure.toString());
  });
```



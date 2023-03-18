# Environment Sensors


Flutter plugin for accessing ambient temperature, relative humidity, ambient light, and barometric pressure sensors of a device.
## Install
Add ```b_internal_sensors``` as a dependency in  `pubspec.yaml`.
For help on adding as a dependency, view the [documentation](https://flutter.io/using-packages/).

## Usage
Check for availability of sensors
```dart
final BInternalSensors = BInternalSensors();   

    var tempAvailable = await BInternalSensors.getSensorAvailable(BInternalSensorType.AmbientTemperature);
    var humidityAvailable = await BInternalSensors.getSensorAvailable(BInternalSensorType.Humidity);
    var lightAvailable = await BInternalSensors.getSensorAvailable(BInternalSensorType.Light);
    var pressureAvailable = await BInternalSensors.getSensorAvailable(BInternalSensorType.Pressure);
```

Get sensor stream
```dart
final BInternalSensors = BInternalSensors();

  BInternalSensors.pressure.listen((pressure) {
    //Pressure in Millibars
    print(pressure.toString());
  });
```



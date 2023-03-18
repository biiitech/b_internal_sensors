import Flutter
import UIKit
import CoreMotion

let TYPE_ACCELEROMETER = 1
let TYPE_MAGNETIC_FIELD = 2
let TYPE_GYROSCOPE_LIMITED_AXIS = 3
let TYPE_GYROSCOPE = 4
let TYPE_LIGHT = 5
let TYPE_PRESSURE = 6
let TYPE_TEMPERATURE = 7
let TYPE_PROXIMITY = 8
let TYPE_GRAVITY = 9
let TYPE_USER_ACCELEROMETER = 10
let TYPE_ROTATION_VECTOR = 11
let TYPE_HUMIDITY = 12
let TYPE_AMBIENT_TEMPERATURE = 13

public class SwiftBInternalSensorsPlugin: NSObject, FlutterPlugin {
   private let pressureStreamHandler = PressureStreamHandler()
   private let lightStreamHandler = PressureStreamHandler()


  public static func register(with registrar: FlutterPluginRegistrar) {
    let METHOD_CHANNEL_NAME = "b_internal_sensors/method"
    let instance = SwiftBInternalSensorsPlugin(registrar:registrar)
    let channel = FlutterMethodChannel(name: METHOD_CHANNEL_NAME, binaryMessenger: registrar.messenger())
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  init(registrar: FlutterPluginRegistrar) {
          let PRESSURE_CHANNEL_NAME = "b_internal_sensors/pressure"

          let pressureChannel = FlutterEventChannel(name: PRESSURE_CHANNEL_NAME, binaryMessenger: registrar.messenger())
          pressureChannel.setStreamHandler(pressureStreamHandler)

      }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
           case "isSensorAvailable":
               result(isSensorAvailable(call.arguments as! Int))
           default:
               result(FlutterMethodNotImplemented)
           }
  }
    
public func isSensorAvailable(_ sensorType: Int) -> Bool {
    let motionManager = CMMotionManager()
    switch sensorType {
        case TYPE_ACCELEROMETER: 
            return motionManager.isAccelerometerAvailable
        case TYPE_MAGNETIC_FIELD: 
            return motionManager.isMagnetometerAvailable
        case TYPE_GYROSCOPE_LIMITED_AXIS: 
            return false
        case TYPE_GYROSCOPE: 
            return motionManager.isGyroAvailable
        case TYPE_LIGHT: 
            return false
        case TYPE_PRESSURE:
            return CMAltimeter.isRelativeAltitudeAvailable()
        case TYPE_TEMPERATURE: 
            return false
        case TYPE_PROXIMITY: 
            return false
        case TYPE_GRAVITY: 
            return false
        case TYPE_USER_ACCELEROMETER : 
            return motionManager.isDeviceMotionAvailable
        case TYPE_ROTATION_VECTOR : 
            return false
        case TYPE_HUMIDITY : 
            return false
        case TYPE_AMBIENT_TEMPERATURE : 
            return false
        default:
            return false
        }
    }
}

class PressureStreamHandler: NSObject, FlutterStreamHandler {
    let altimeter = CMAltimeter()
    private let queue = OperationQueue()
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        

        if CMAltimeter.isRelativeAltitudeAvailable() {
            altimeter.startRelativeAltitudeUpdates(to: queue) { (data, error) in
                if data != nil {
                    //Get Pressure and convert kilopascals to millibars
                    var pressurePascals = data?.pressure
                    events(pressurePascals!.doubleValue * 10.0)
                }
            }
        }
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        altimeter.stopRelativeAltitudeUpdates()
        return nil
    }
    
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:etapp/recording_screen2.dart';
import 'package:flutter/services.dart';
import 'package:sensors_plus/sensors_plus.dart';


class recordScreen extends StatefulWidget {
  const recordScreen({super.key});

  @override
  State<recordScreen> createState() => _recordScreenState();
}

class _recordScreenState extends State<recordScreen> {
  List<double>? _restingAccelerometerValues;
  List<double>? _restingaccelerometerValues;
  List<double>? _restinggyroscopeValues;
  List<double>? _restingmagnetometerValues;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  List<String>? rAccelerometer;
  List<String>? raccelerometer;
  List<String>? rgyroscope;
  List<String>? rmagnetometer;




  static const thirtySeconds = 5;
  int totalSeconds = thirtySeconds;
  bool isRunning = false;
  bool done = false;
  late Timer timer;

  void onTick(Timer timer){
    if(totalSeconds ==0){
      setState(() {
        isRunning = false;
        done = true;
      });
      timer.cancel();
    } else{
      setState(() {
        totalSeconds = totalSeconds -1;
      });
    }
  }
  void onStopPressed(){
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }
  void onStartPressed(){
    timer = Timer.periodic(Duration(seconds: 1),
        onTick);
    setState(() {
      isRunning = true;
    });
  }
  void onResetPressed(){
    timer.cancel();
    setState(() {
      isRunning = false;
      totalSeconds = thirtySeconds;
    });
  }
  String format(int seconds){
    var duration = Duration(seconds: seconds);
    return duration.toString().substring(2,7);
  }
  @override
  void initState() {
    super.initState();
    _streamSubscriptions.add(
      userAccelerometerEvents.listen(
            (UserAccelerometerEvent event) {
          setState(() {
            _restingAccelerometerValues= <double>[event.x, event.y, event.z];
          });
        },
        onError: (e) {
          showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  title: Text("Sensor Not Found"),
                  content: Text(
                      "It seems that your device doesn't support Accelerometer Sensor"),
                );
              });
        },
        cancelOnError: true,
      ),
    );
    _streamSubscriptions.add(
      accelerometerEvents.listen(
            (AccelerometerEvent event) {
          setState(() {
            _restingaccelerometerValues = <double>[event.x, event.y, event.z];
          });
        },
        onError: (e) {
          showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  title: Text("Sensor Not Found"),
                  content: Text(
                      "It seems that your device doesn't support Gyroscope Sensor"),
                );
              });
        },
        cancelOnError: true,
      ),
    );
    _streamSubscriptions.add(
      gyroscopeEvents.listen(
            (GyroscopeEvent event) {
          setState(() {
            _restinggyroscopeValues = <double>[event.x, event.y, event.z];
          });
        },
        onError: (e) {
          showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  title: Text("Sensor Not Found"),
                  content: Text(
                      "It seems that your device doesn't support User Accelerometer Sensor"),
                );
              });
        },
        cancelOnError: true,
      ),
    );
    _streamSubscriptions.add(
      magnetometerEvents.listen(
            (MagnetometerEvent event) {
          setState(() {
            _restingmagnetometerValues = <double>[event.x, event.y, event.z];
          });
        },
        onError: (e) {
          showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  title: Text("Sensor Not Found"),
                  content: Text(
                      "It seems that your device doesn't support Magnetometer Sensor"),
                );
              });
        },
        cancelOnError: true,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    if(isRunning==true){
      setState(() {
         rAccelerometer = _restingAccelerometerValues?.map((double v) => v.toStringAsFixed(1)).toList();
         raccelerometer = _restingaccelerometerValues?.map((double v) => v.toStringAsFixed(1)).toList();
         rgyroscope = _restinggyroscopeValues?.map((double v) => v.toStringAsFixed(1)).toList();
         rmagnetometer = _restingmagnetometerValues?.map((double v) => v.toStringAsFixed(1)).toList();
      });
    }else{
    }
    return
      Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Measuring resting tremor', style: Theme.of(context).textTheme.titleMedium),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical:20),
            child: Flexible(
                flex:1,
                child: Text('Hold your arm still until the timer ends',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color:Colors.black),
                  textAlign: TextAlign.center
                ),
            ),
          ),
          Flexible(
              flex:1,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Text(format(totalSeconds),
                  style: TextStyle(color: Colors.black,
                    fontSize:50,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )),
          Flexible(
            flex: 4,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 120,
                    color: Colors.black,
                    onPressed: isRunning ? onStopPressed : onStartPressed,
                    icon: Icon(isRunning ? Icons.pause_circle_outline: Icons.play_circle_outline),
                  ),
                  Text('Press to start!', style:
                  TextStyle(color:Colors.orange,
                    fontSize:18,
                    fontWeight: FontWeight.w800,)
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 45,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              iconSize:30,
                              color: Colors.black,
                              onPressed: onResetPressed,
                              icon: Icon(Icons.restart_alt)),
                          Text('restart', style:
                          TextStyle(color:Colors.grey,
                            fontSize:10,
                            fontWeight: FontWeight.w500,)
                          ),
                        ],
                      ),
                        IconButton(
                            iconSize:30,
                            color: Colors.black,
                            onPressed: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => recordScreen2()
                                      ),
                                     );
                                },
                            icon: Icon( done ? Icons.navigate_next_outlined: null))
                           //시간이 지나야 데이터를 무조건 정해놓은 시간동안 다 받아야 다음 페이지 넘어가는 아이콘이 보이도록
                    ],
                  )
                  ]
            ),),
          Flexible(
            flex: 1,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('UserAccelerometer: $rAccelerometer'),
              Text('Accelerometer: $raccelerometer'),
              Text('Gyroscope: $rgyroscope'),
              Text('Magnetometer: $rmagnetometer')
            ],
          ),)
        ],
      ),
    );
  }
}

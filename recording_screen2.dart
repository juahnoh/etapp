import 'dart:async';
import 'package:flutter/material.dart';

class recordScreen2 extends StatefulWidget {
  const recordScreen2({super.key});

  @override
  State<recordScreen2> createState() => _recordScreen2State();
}

class _recordScreen2State extends State<recordScreen2> {
  static const thirtySeconds = 30;
  int totalSeconds = thirtySeconds;
  bool isRunning = false;
  late Timer timer;

  void onTick(Timer timer){
    if(totalSeconds ==0){
      setState(() {
        isRunning = false;
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Measuring intention tremor', style: Theme.of(context).textTheme.titleMedium),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical:20),
            child: Flexible(
              flex:1,
              child: Text('Move your arm as described until the timer ends',
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
                  IconButton(
                      iconSize:30,
                      color: Colors.black,
                      onPressed: onResetPressed,
                      icon: Icon(Icons.restart_alt)),
                  Text('restart', style:
                  TextStyle(color:Colors.grey,
                    fontSize:10,
                    fontWeight: FontWeight.w500,)
                  )
                ]
            ),),
        ],
      ),
    );
  }
}

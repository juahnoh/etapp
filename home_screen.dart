import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:etapp/recording_screen.dart';
import 'package:etapp/changerate_screen.dart';
import 'package:etapp/patientInfo_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String tButton = 'Tremor check';
  String cButton = 'View average in tremor rate';
  String pButton = 'Edit patient information';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text('Home Screen', style: Theme.of(context).textTheme.titleLarge),
      ),
      backgroundColor: Colors.white,
      body:
      Padding(
        padding: const EdgeInsets.all(40),
        child: Center(
          child:
          Column(
            children: [
              SizedBox(height: 20,),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.black,
                    fixedSize: Size.fromHeight(50),
                    backgroundColor: Colors.grey
                  ),
                    child: Center(
                      child: Text( tButton,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    onPressed: (){
                      Navigator.push(
                          context,
                      MaterialPageRoute(
                        builder: (context) =>
                          recordScreen()),
                        );
                    }
                  )
                ),
              SizedBox(height: 70,),
              Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shadowColor: Colors.black,
                          fixedSize: Size.fromHeight(50),
                          backgroundColor: Colors.grey
                      ),
                      child: Center(
                        child: Text( cButton,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  changeRate()),
                        );
                      }
                  )
              ),
              SizedBox(height: 70,),
              Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shadowColor: Colors.black,
                          fixedSize: Size.fromHeight(50),
                          backgroundColor: Colors.grey
                      ),
                      child: Center(
                        child: Text( pButton,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  patientInfo()),
                        );
                      }
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:ui';



class patientInfo extends StatefulWidget {
  const patientInfo({super.key});
  @override
  State<patientInfo> createState() => _patientInfoState();
}


class _patientInfoState extends State<patientInfo> {
  String patientName='';
  late  DateTime startDate;
  TextEditingController dateInput = TextEditingController();
  String tremorFrequency='NA';
  bool history=false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Edit patient information', style: Theme.of(context).textTheme.titleMedium),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 100),
        child: Center(
          child: Column(
            children: [
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Patient name:',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600 ),),
                    Container(
                        width: 200,
                        child: TextField(
                          onChanged: (name){
                            setState(() {
                              patientName=name;
                            }
                            );
                          },
                          decoration: InputDecoration(
                            labelText: 'NAME'
                          ),
                        )
                    )
                  ],
                ),
                flex:1 ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Symtom started date:',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600 ),),
                    Container(
                      width: 200,
                      child: TextField(
                        controller: dateInput,
                        decoration: InputDecoration(
                          icon: Icon(Icons.calendar_month_outlined),
                          labelText: 'Enter Date'
                        ),
                        readOnly: true,
                        onTap: () async{
                            DateTime? pickedDate=await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime.now());
                            if (pickedDate != null){
                              print(pickedDate);
                              String formedDate= pickedDate.toString().substring(0,10);
                              print(formedDate);
                              setState(() {
                                dateInput.text= formedDate;
                              });
                            }else {}
                          },
                      ),)
                  ],
                ),
                flex:1 ),
              Flexible(
                  child: Column(
                    children: [
                      Text('Tremor frequency:',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600 )),
                      Container(
                        width: 200,
                        child: DropdownButton<String>(
                            value: tremorFrequency,
                            items: const[
                              DropdownMenuItem(
                                child: Text('NA'), value: ('NA'),),
                              DropdownMenuItem(
                                child: Text('3~4 times/day'), value: ('3~4 times/day'),),
                              DropdownMenuItem(
                                child: Text('1~2 times/day'), value: ('1~2 times/day'),),
                              DropdownMenuItem(
                                child: Text('less than once a day'), value: ('less than once a day'),),
                              DropdownMenuItem(
                                child: Text('less than once a week'), value: ('less than once a week'),),
                            ],
                            onChanged: (String? value){
                              setState(() {
                                tremorFrequency = value!;
                              });
                            }
                        ),
                      ),
                    ],
                  ),
                  flex:1 ),
              Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Diagnosed history:',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600 ),),
                      Container(
                        width: 200,
                        child: DropdownButton<bool>(
                            value: history,
                            items: const[
                              DropdownMenuItem(
                                child: Text('No'), value: (false),),
                              DropdownMenuItem(
                                child: Text('Yes'), value: (true),),
                            ],
                            onChanged: (bool? value){
                              setState(() {
                                history = value!;
                              });
                            }
                        ),
                      ),
                    ],
                  ),
                  flex:1 ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Sensor extends StatefulWidget {
  const Sensor({super.key});

  @override
  State<Sensor> createState() => _SensorState();
}

class _SensorState extends State<Sensor> {
  bool isDataLoaded = false;
  String Percentage_Moisture = '0';
  DatabaseReference Percentage_MoistureRef =
      FirebaseDatabase.instance.ref('Percentage_Moisture');

  void getData() async {
    Percentage_MoistureRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        Percentage_Moisture = event.snapshot.value.toString();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.only(top: 10, right: 10, left: 10),
      child: ListView(
        children: [
          Container(
            height: 50,
            child: Row(
              children: [
                Text(
                  'Humidity',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                Spacer(),
                isDataLoaded
                    ? CircularProgressIndicator()
                    : Text(
                        Percentage_Moisture,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                Icon(
                  Icons.percent,
                  size: 30,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    ));
  }
}

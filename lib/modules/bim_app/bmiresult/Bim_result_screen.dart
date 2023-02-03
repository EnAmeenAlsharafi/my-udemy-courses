import 'package:flutter/material.dart';

class BIMResultScreen extends StatelessWidget {
  int? result;
  int? age;
  bool? isMale;

  BIMResultScreen({
    this.age,
    this.isMale,
    this.result,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BIM Result'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Gender:${isMale! ? 'Male' : 'female'}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            'Result:$result',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            'Age:$age',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      )),
    );
  }
}

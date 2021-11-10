

import 'package:flutter/material.dart';
class ScreenOne extends StatelessWidget {
  String? text;
  String? dln;
  String? iss;
  String? dob;
  String? exp;

void jsonConverter()
{
  RegExp dlnExp = RegExp(r"DLN: .*");
  RegExp dateExp = RegExp(r" [0-9][0-9]/[0-9][0-9]/[0-9][0-9][0-9][0-9]");


  var matches = dlnExp.firstMatch(text!) ;
  var matchesDate = dateExp.allMatches(text!);

  if(matches!=null)
    {
      dln = matches.group(0);
      print(dln);
    }



}

  ScreenOne(String txt)
  {
    text = txt;
    jsonConverter();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('OCR')),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(top:20.0),
          child: Column(

            children: [
              Container(
                width: 350,
                height: 550,
                color: Colors.grey,
                child: Center(
                    child: Text('$text',style: TextStyle(color: Colors.white),)
                ),
              ),
              /*TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white30),

                ),

                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                      ScreenOne(content!)));
                },

                child: Text('EXTRACT TEXT'),
              )*/
            ],
          ),
        ),
      ),
    );

  }
}


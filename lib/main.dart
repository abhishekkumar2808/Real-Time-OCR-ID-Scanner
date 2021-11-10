
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';

import 'firstScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);



  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  File? imageFile;
  final _picker = ImagePicker();
  String? content;

  Future getImg(ImageSource source) async {


      final img = await _picker.getImage(source: source);


    setState(() {
      imageFile = File(img!.path);

    });
    retrText();

  }

  Future<void> retrText()
  async {
    final inputImage = InputImage.fromFile(imageFile!);
    final textDetector = GoogleMlKit.vision.textDetector();
    final RecognisedText recognisedText = await textDetector.processImage(inputImage);

    String text = recognisedText.text;
    for (TextBlock block in recognisedText.blocks) {
      final Rect rect = block.rect;
      final List<Offset> cornerPoints = block.cornerPoints;
      final String text = block.text;
      final List<String> languages = block.recognizedLanguages;

      for (TextLine line in block.lines) {
        // Same getters as TextBlock
        for (TextElement element in line.elements) {
          // Same getters as TextBlock

        }
      }
    }
    content = text;
    debugPrint(text);

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('OCR')),
      ),

      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Container(
              child: (imageFile==null)? Container(
                width: 300,
                height: 450,
                color: Colors.grey,
                child: Center(child: Text('Your photo will appear here!',style: TextStyle(color: Colors.white),)),
              ) :
              Container(
                width: 300,
                height: 450,
                child: Image.file(imageFile!),
              ),
            ),
            IconButton(
                padding: EdgeInsets.all(25.0),
                iconSize: 50.0,
                icon: Icon(Icons.camera_alt),
                tooltip: 'Take a picture',
                onPressed: () async{
                  await getImg(ImageSource.camera);
                  //Navigator.push(context, MaterialPageRoute(builder: (context) =>
                      //screenOne(_image)));

                }
            ),
            IconButton(
                iconSize: 50.0,
                padding: EdgeInsets.all(25.0),
                icon: Icon(Icons.add_photo_alternate_outlined),
                tooltip: 'Choose from gallery',
                onPressed: () async{
                  await getImg(ImageSource.gallery);


                }
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white30),
                
              ),

              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                ScreenOne(content!)));
              },

              child: Text('EXTRACT TEXT'),
            )



          ],
        ),
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
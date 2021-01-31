import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snap/imageLabellerClass.dart';
import 'package:snap/playground.dart';
import 'UIPage.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black38,
          title: Center(
              child: Text(
            'Snappy',
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
                textStyle: Theme.of(context).textTheme.display1,
                color: Colors.white,
                fontSize: 14),
          ))),
      backgroundColor: Color(0xFF0E0F1B),
      body: Container(
        //color: Colors.deepPurple,
        decoration: BoxDecoration(
            // color: Colors.black
//          image: DecorationImage(
//            image: AssetImage("images/ss.jpg"),
//            fit: BoxFit.cover,
//          ),
            ),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width / 2 + 700,
                    //child: Image.asset('images/back.jpeg'),
                    //constraints: BoxConstraints.tight(),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ReusableCard(
                      'face',
                      '1.jpeg',
                      Colors.orange,
                      Icon(
                        Icons.tag_faces,
                        color: Colors.orange,
                        size: 100,
                      )),
                  ReusableCard(
                      'Object',
                      '3.jpg',
                      Colors.white,
                      Icon(
                        Icons.shopping_cart,
                        size: 100,
                        // color: Colors.blue,
                      )),
                  ReusableCard(
                      '',
                      'logo.png',
                      Colors.green,
                      Icon(
                        Icons.text_format,
                        //semanticLabel: "sa",
                        color: Colors.green,
                        size: 100,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReusableCard extends StatelessWidget {
  ReusableCard(@required this.version, this.image, this.colour, this.text);
  final String version;
  final String image;
  final Color colour;
  final Icon text;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      //flex: 1,
      child: Container(
        height: 10,
        child: FlatButton(
          onPressed: () {
            print(version);
            if (version == 'face') {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => FacePage()));
            } else if (version == 'Object') {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ObjectLabeller()));
            } else {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TextRecog()));
            }
          },
          //   color: colour,
//          child: Text(
//            '$text',
//            style: TextStyle(
//                fontFamily: 'Times new Roman',
//                fontSize: 30,
//                fontStyle: FontStyle.italic,
//                color: Colors.black54),
//            textAlign: TextAlign.center,
//          ),
          child: Container(
            decoration: BoxDecoration(
                // color: Colors.black
                ),
            child: text,
          ),
        ),
      ),
    );
  }
}

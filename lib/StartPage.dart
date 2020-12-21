//import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
//import 'package:snap/HomePage.dart';
//
//class HomePagee extends StatefulWidget {
//  @override
//  _HomePageeState createState() => _HomePageeState();
//}
//
//class _HomePageeState extends State<HomePagee> {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: SafeArea(
//        child: Container(
//          decoration: BoxDecoration(
//              image: DecorationImage(
//                  image: AssetImage('images/Main.jpg'), fit: BoxFit.cover)),
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.stretch,
//            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//            children: <Widget>[
//              Container(
//                child: Text(
//                  "Assist your vision with snap",
//                  style: GoogleFonts.lato(
//                      textStyle: Theme.of(context).textTheme.display1,
//                      color: Colors.grey,
//                      fontSize: 20),
//                  textAlign: TextAlign.center,
//                ),
//              ),
//              Padding(
//                padding: EdgeInsets.fromLTRB(50, 50, 50, 0),
//                child: Container(
//                  decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(50),
//                      color: Colors.black54),
//                  child: FlatButton(
//                      onPressed: () {
//                        Navigator.push(context,
//                            MaterialPageRoute(builder: (context) => Home()));
//                      },
//                      child: Text("Start")),
//                ),
//              ),
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//}

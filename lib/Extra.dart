//import 'package:flutter/material.dart';
//import 'package:translator/translator.dart';
//
//class LanguageTranslate extends StatefulWidget {
//  @override
//  _LanguageTranslateState createState() => _LanguageTranslateState();
//}
//
//class _LanguageTranslateState extends State<LanguageTranslate> {
//  String text;
//  String transText;
//  bool flag = true;
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Center(
//        child: Padding(
//          padding: const EdgeInsets.all(8.0),
//          child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              TextField(
//                decoration: InputDecoration(hintText: 'Enter text'),
//                maxLines: 10,
//                minLines: 1,
//                onChanged: (value) {
//                  text = value;
//                },
//              ),
//              Padding(
//                padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
//                child: Container(
//                  color: Colors.blue,
//                  child: FlatButton(
//                      onPressed: () async {
//                        final translator = GoogleTranslator();
//
//                        final input = "Здравствуйте. Ты в порядке?";
//
//                        translator
//                            .translate(input, to: 'bn')
//                            .then((s) => print("Source: " +
//                            input +
//                            "\n"
//                                "Translated: " +
//                            s +
//                            "\n"));
//
//                        // You can also call the extension method directly on the input
//                        print('Translated: ${await input.translate(to: 'en')}');
//
//                        // For countries that default base URL doesn't work
//                        translator.baseUrl =
//                        "https://translate.google.cn/translate_a/single";
//                        translator.translateAndPrint(
//                            "This means 'testing' in chinese",
//                            to: 'zh-cn');
//                        //prints 这意味着用中文'测试'
//
//                        var translation = await translator.translate(
//                            "I would buy a car, if I had money.",
//                            from: 'en',
//                            to: 'it');
//                        print("translation: " + translation);
//
//
//                        this.setState(() {
//                          flag = false;
//                        });
//                      },
//                      child: Text('Translate')),
//                ),
//              ),
//              flag
//                  ? Text("")
//                  : Expanded(
//                child: ListView(
//                  scrollDirection: Axis.vertical,
//                  children: <Widget>[Text(text)],
//                ),
//              )
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//}

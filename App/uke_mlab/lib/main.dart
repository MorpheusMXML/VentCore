//just a widget to play with
import 'package:english_words/english_words.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  // We need to call it manually,
  // because we going to call setPreferredOrientations()
  // before the runApp() call
  WidgetsFlutterBinding.ensureInitialized();

  // Than we setup preferred orientations,
  // and only after it finished we run our app
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]).then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return MaterialApp(
      title: 'Welcome to the UKE Mlab Team',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to the UKE Mlab Team'),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Dialog(
                  backgroundColor: Colors.transparent,
                  insetPadding: EdgeInsets.all(10),
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                          width: double.infinity,
                          height: 280,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.lightBlue),
                          padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                          child: ListView(children: [
                            const Text("We can make cool stuff!",
                                style: TextStyle(fontSize: 24),
                                textAlign: TextAlign.center),
                            Text(
                                "We have random words: " +
                                    wordPair.asPascalCase,
                                style: const TextStyle(fontSize: 36),
                                textAlign: TextAlign.center),
                            const Text('This is the Team:',
                                style: TextStyle(fontSize: 36),
                                textAlign: TextAlign.center),
                            const Text('Fynn',
                                style: TextStyle(fontSize: 24),
                                textAlign: TextAlign.center),
                            const Text('Mudassar',
                                style: TextStyle(fontSize: 24),
                                textAlign: TextAlign.center),
                          ])),
                      Positioned(
                          top: -100,
                          child: Image.network(
                              "https://i.imgur.com/2yaf2wb.png",
                              width: 150,
                              height: 150))
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

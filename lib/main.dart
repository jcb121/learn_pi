import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(new MyApp());

const String pi = '1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Learn Pi',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.red,
      ),
      home: new MyHomePage(title: 'Learn Pi'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _index = 0;
  int _count = 4;
  String _snippet = '3.' + pi.substring(0, 4);
  bool _showingHint = true;

  void _hideTimeout(){
    setState((){
      _showingHint = false;
    });
  }
  void _next(){
    setState(() {
      _index++;
      _snippet = pi.substring(_index * _count, _index * _count + _count);
      _showingHint = true;
      var future = new Future.delayed(const Duration(milliseconds: 1000), _hideTimeout);
    });
  }
  void _showHint(TapDownDetails details){
    setState(() {
      _showingHint = true;
    });
  }
  void _hideHint(TapUpDetails details){
    setState((){
      if(_index > 0){
        _showingHint = false;
      }
    });
  }
  void _reset(){
    setState((){
      _index = 0;
      _snippet = '3.' + pi.substring(_index * _count, _index * _count + _count);
      _showingHint = true;
    });
  }

  void _inputChange(String change){
    if(_controller.text == pi.substring(_index * _count, _index * _count + _count)){
      _controller.clear();
      _next();
    }
  }
  final TextEditingController _controller = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.


    return new GestureDetector(
      onTapDown: _showHint,
      onTapUp: _hideHint,
      child: new Scaffold(
        drawer: new Drawer(
          child: new Column(
            children: <Widget>[
              new Container(
                height: 50.0,
              ),
              new Slider(
                onChanged: (double value) {
                  setState(() {
                    _count = value.toInt();
                  });
                  _reset();
                },
                value: _count.toDouble(),
                min: 1.toDouble(),
                max: 10.toDouble(),
                label: 'Count',
              ),
              new Text(
                '$_count',
                style: Theme.of(context).textTheme.display1,
              ),
            ],
          )
        ),
        appBar: new AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: new Text(widget.title),
        ),
        body: new Column(
          children: <Widget>[
            new Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: new Column(
                // Column is also layout widget. It takes a list of children and
                // arranges them vertically. By default, it sizes itself to fit its
                // children horizontally, and tries to be as tall as its parent.
                //
                // Invoke "debug paint" (press "p" in the console where you ran
                // "flutter run", or select "Toggle Debug Paint" from the Flutter tool
                // window in IntelliJ) to see the wireframe for each widget.
                //
                // Column has various properties to control how it sizes itself and
                // how it positions its children. Here we use mainAxisAlignment to
                // center the children vertically; the main axis here is the vertical
                // axis because Columns are vertical (the cross axis would be
                // horizontal).
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(_snippet,
                  style: new TextStyle(
                      fontSize: Theme.of(context).textTheme.display2.fontSize,
                      fontWeight: FontWeight.bold,
                      color: _showingHint ? Colors.black : Colors.black.withOpacity(0.05)
                    ),
                  ),
                ],
              ),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Container(
                  child: new Text(
                    _index == 0 ? '3.' : '',
                    style: Theme.of(context).textTheme.display2
                  ),
                  padding: const EdgeInsets.only(bottom: 22.0),
                ),
                new Container(
                  width: 26 * _count.toDouble(),
                  child: new TextField(
                    autocorrect: false,
                    maxLength: _count,
                    keyboardType: TextInputType.number,
                    controller: _controller,
                    autofocus: true,
                    onChanged: _inputChange,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.display2
                  ),
                ),
              ],
            )
          ],
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: _reset,
          tooltip: 'Reset',
          child: new Icon(Icons.undo),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      )
    );
  }
}

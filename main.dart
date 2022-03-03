import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'Инкремент'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void reset() {
    _counter = 0;
    setState(() {});
  }
  void _decrementCounter() {
  setState((){
    _counter--;
    });
  }
  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
                  'Значение инкримента',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),

        Row(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            FloatingActionButton(
            onPressed: _decrementCounter,
            tooltip: 'decrement',
            child: const Icon(Icons.remove),
        ),

              FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
       // This trailing comma makes auto-formatting nicer for build methods.

                             ],

            ),
        TextButton(
          onPressed: reset,
          child: const Text('обновить'),
            ),

    ],  ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: reset,
        tooltip: 'reset',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

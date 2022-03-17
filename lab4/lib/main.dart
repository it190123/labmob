import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(title: 'Список'),
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
  List<String> arr = [];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title, style: const TextStyle(color: Colors.white)),
          backgroundColor: Colors.pinkAccent,
        ),

        body: ListView.builder(
          itemBuilder: (BuildContext context, int i) {

            if (i%2 != 0) return const Divider();

            int _pow = i~/2;
            if (_pow >= arr.length) arr.addAll(['2^$_pow = ${pow(2, _pow)}', '2^${_pow+1} = ${pow(2, _pow+1)}', '2^${_pow+2} = ${pow(2, _pow+2)}']);

            print('i = ${i}, pow = $_pow, current_array_L = ${arr.length}');
            return ListTile(title: Text(arr[_pow]));
          },

        )
      //)
    );
  }
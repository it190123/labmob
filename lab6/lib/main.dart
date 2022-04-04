import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main()
{
  runApp(const MaterialApp(
    home: MainScreen(),
  ));
}

class MainScreen extends StatelessWidget{
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
        appBar: AppBar(title: const Text("Возвращение значения"),),
        body: Center(child: ElevatedButton(
          onPressed: (){
            Show(context);
          },
          child: const Text("Приступить к выбору.."),
        )));}}


void Show(BuildContext context) async{
  final res = await Navigator.push(context, MaterialPageRoute(builder: (context) => const SecondScreen()));

  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text("$res")));
}


class SecondScreen extends StatelessWidget{
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(title: const Text("Выберите вариант"),),
    body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    ElevatedButton(
    onPressed: (){
    Navigator.pop(context, "Да");
    },
    child: const Text("Да"),
    ),
    ElevatedButton(
    onPressed: (){
    Navigator.pop(context, "Нет");
    },
    child: const Text("Нет"),
    )

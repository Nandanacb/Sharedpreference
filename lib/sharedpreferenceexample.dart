import 'package:shared_preferences/shared_preferences.dart';
import'package:flutter/material.dart';

class Sharedpreferenceexample extends StatefulWidget{
  const  Sharedpreferenceexample({super.key});
  @override

   State<Sharedpreferenceexample> createState()=> _SharedpreferenceexampleState();
}

class  _SharedpreferenceexampleState extends State< Sharedpreferenceexample>{

String _name='';

@override

void initstate(){
  super.initState();
  loadName();
}

loadName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  setState(() {
    _name = prefs.getString('name') ?? 'No name saved';
  });
}

saveName(String name) async{
  SharedPreferences prefs= await SharedPreferences.getInstance();
  prefs.setString('name', name);
  loadName();
}

@override
Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(title: Text("SharedPreferences Example")),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("saved name:$_name"),
          TextField(
            onSubmitted:(val){
            saveName(val);
            },
            decoration: InputDecoration(
              hintText: 'Enter your name'
            ),
          )
        ],

      ),
    ),
  );
}
}

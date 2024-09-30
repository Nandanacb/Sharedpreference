import 'package:shared_preferences/shared_preferences.dart';
import'package:flutter/material.dart';

class Listexample extends StatefulWidget{
  const  Listexample({super.key});
  @override

   State<Listexample> createState()=> _ListexampleState();
}

class _ListexampleState extends State<Listexample>{

List<String> _items =[];
@override
void initState(){
  super.initState();
  loadItems();
}
loadItems() async {
  SharedPreferences prefs= await SharedPreferences.getInstance();
  setState(() {
   _items=prefs.getStringList('items') ?? [];
  });
}
saveItems(List<String> items) async {
  SharedPreferences prefs=await SharedPreferences.getInstance();
  prefs.setStringList('items', _items);
}

void Additem(String item) {
  setState(() {
    _items.add(item);
  });
  saveItems( _items);

}

@override
Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(title: Text("Listexample"),),
    body: Column(
      children: [
        TextField(
          onSubmitted: (val){
            Additem(val);
          },
          decoration: InputDecoration(hintText: 'Enter an item'),
        ),
        Expanded(
          child: ListView.builder(itemCount: _items.length,itemBuilder: (context,index){
            return ListTile(title: Text(_items[index]),
            );
          }),
        )
      ],
    ),
  );

}
}
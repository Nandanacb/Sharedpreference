import'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Todoexample extends StatefulWidget{
  const  Todoexample({super.key});
  @override

   State<Todoexample> createState()=> _TodoexampleState();
}

class _TodoexampleState extends State<Todoexample>{

   List<Color> colorList=[
    Colors.amber,
    Colors.red,
    Colors.green,
    Colors.purple,


   ];

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
      appBar: AppBar(
        title: Text("ToDo Example"),
      
      ),
      body: Column(
        
        children: [
      
        
          Expanded(
            child: ListView.builder(itemCount:_items.length,itemBuilder: (context,index){
              return Container(
              height: 100,
              width: double.infinity,
              child: Text(_items[index])
                
              );
            }),
          )
        
      ]),
      floatingActionButton: FloatingActionButton(
                        child: Icon(Icons.play_arrow_outlined),onPressed: (){
                          showModalBottomSheet(
                             context: context, builder:(BuildContext context){
                            return Container(
                              height: 450,
                              width: double.infinity,
                              color: Colors.white,
                              child: Column(
                                children: [
                                  TextField(decoration: InputDecoration(border: OutlineInputBorder(),hintText: 'Enter a task'),),
                                  SizedBox(height: 16,),
                                 Text("choose any color:",style: TextStyle(fontSize: 17),),
                                  
                                  
                                 Expanded(
                                   child: ListView.separated(
                                    
                                    scrollDirection: Axis.horizontal,itemBuilder: (context, index){
                                    return Container(
                                      height: 50,
                                      width: 80,
                                      child: CircleAvatar(
                                        radius: 15,
                                        backgroundColor:colorList[index],
                                      ),
                                      
                                    );
                                   }, separatorBuilder:(context,index){
                                    return SizedBox(
                                      width: 10,
                                    );
                                   }, itemCount: 4),
                                   
                                 ),
                                 SizedBox(height: 20,),
                                 
                         Padding(
                           padding: const EdgeInsets.all(20),
                           child: ElevatedButton(onPressed: (){}, child: Text("Add",style: TextStyle(fontSize: 25),)),
                         ),
              ]
              )
                             );
                             });
                        }
                ),
    );  








     }

                          
      }
        
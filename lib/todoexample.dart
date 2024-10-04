import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class NewtodoApp extends StatefulWidget {
  const NewtodoApp({super.key});

  @override
  State<NewtodoApp> createState() => _NewtodoAppState();
}

class _NewtodoAppState extends State<NewtodoApp> {
   List<Map<String,dynamic>> _items =[];
  Color _selectedColor=Colors.blue;
  List<Color> _colorlist = [
    Colors.blue,
    Colors.pink,
    Colors.purple,
    Colors.orange,
    Colors.green
  ];
  
@override
void initState(){
  super.initState();
  _loadItems();
}
_loadItems() async {
  SharedPreferences prefs= await SharedPreferences.getInstance();
  List<String>? tasks=prefs.getStringList('items');
   List<String>? colors=prefs.getStringList('colors');
   if(tasks != null && colors != null){
    setState(() {
      _items=List.generate(tasks.length,(index){
        return {
          'task':tasks[index],
          'color': Color(int.parse(colors[index]))
        };
      });
    });
   }
}

  
_saveItems() async {
  SharedPreferences prefs=await SharedPreferences.getInstance();
  List<String> tasks=
  _items.map((item)=>item['task'] as String).toList();
  List<String>colors =_items
  .map((item)=>(item['color'] as Color).value.toString()).toList();

  prefs.setStringList('items', tasks);
  prefs.setStringList('colors', colors);

}

void _additem(String task) {
  if(task.isNotEmpty){
    setState(() {
      _items.add({'task':task, 'color':_selectedColor});
    });
  
  _saveItems();

}
}

void _removeItem(int index){
  setState(() {
    _items.removeAt(index);
  });
  _saveItems();
}

void _promptItem(){
  String newTask="";
  showModalBottomSheet(context: context, builder: (BuildContext context){
    return Container(
      height: 500,
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [TextField(
          decoration: InputDecoration(border: OutlineInputBorder()),
          autofocus: true,
          onChanged: (val){
            newTask=val;
          },
        ),
        SizedBox(height: 20,),
        Text('pick a task color:'),
        SizedBox(
          height: 100,
          child: ListView.separated(
            separatorBuilder: (context,index){
              return SizedBox(
                height: 10,
              );
            },
            
      
          scrollDirection: Axis.horizontal, itemCount:_colorlist.length, itemBuilder: (context,index){
             return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor=_colorlist[index];
                });
              },
              child: CircleAvatar(
                radius: 15,
                backgroundColor: _colorlist[index],
              ),
             );
          },
        ),
        ),
        TextButton( child: Text('Add'),onPressed:(){
          if(newTask.isNotEmpty){
            _additem(newTask);
          Navigator.of(context).pop();
          }
        },),
        ],
      ),
    );
  },
  );
}


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Todo Example")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: _items[index]['color'],),
                    child: Row(
                      children: [
                        Text(_items[index]['task']),
                        Spacer(),
                        IconButton(onPressed: ()=>_removeItem(index), icon: Icon(Icons.delete)),
                      ],
                    ),
                    ),
                  );
                
                
              },
            ),
          ),
        
        ]),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Add Task',
        onPressed: _promptItem,
          
      ),
    );
  }
}

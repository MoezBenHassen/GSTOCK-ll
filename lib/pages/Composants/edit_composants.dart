import 'package:flutter/material.dart';
import 'package:gstock/BackEnd/Models/composant_model.dart';
import 'package:gstock/BackEnd/database_creation.dart';

class ComponentEdit extends StatefulWidget {
  final int id;
  final String name;
  final String obtenue;
  final int stock;
  final int category;


  const ComponentEdit({
    Key? key,
    required this.id,
    required this.name,
    required this.obtenue,
    required this.stock,
    required this.category
  }): super(key: key);

  @override
  _ComponentEditState createState() => _ComponentEditState();
}

class _ComponentEditState extends State<ComponentEdit> {

  TextEditingController nameController = TextEditingController();
  TextEditingController obtenueController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController categoryController = TextEditingController();


  @override
  void initState() {
    getData();
    super.initState();
  }

  getData(){
    nameController.text = widget.name;
    obtenueController.text = widget.obtenue;
    //stockController.value = widget.stock as TextEditingValue;
    //categoryController.value = widget.category as TextEditingValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer : Drawer (
          child : ListView(
            padding : EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration : BoxDecoration(
                  color : Colors.blue,
                ),
                child : Text ("Menu"),
              ),
              ListTile(
                title : const Text ('Members'),
                onTap:(){
                  Navigator.pushNamed(context, 'memberlist');
                },
              ),
              ListTile(
                title : const Text ('Categories'),
                onTap:(){
                  Navigator.pushNamed(context, 'categorylist');
                },
              ),

            ],
          )
      ),
      appBar: AppBar(
        title: Text('Edit Component'),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(children: [
          TextField(
            controller: nameController,
          ),
          TextField(
            controller: obtenueController,
          ),
          TextField(
            controller: stockController,
          ),
          TextField(
            controller: categoryController,
          ),
          ElevatedButton(
              onPressed: () {
                var comp = Composant(
                    name: nameController.text,
                    obtenue: obtenueController.text,
                    stock: int.parse(stockController.text),
                    category: int.parse(categoryController.text)
                    );
                Dbcreate().updateComp(widget.id, comp);
                Navigator.pushNamed(context, 'componentlist');
              },
              child: Text('Edit Component'))
        ]),
      ),
    );
  }
}

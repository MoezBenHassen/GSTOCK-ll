import 'package:flutter/material.dart';
import 'package:gstock/BackEnd/Models/composant_model.dart';
import 'package:gstock/BackEnd/database_creation.dart';

class AddComponent extends StatefulWidget {
  const AddComponent({Key? key}) : super(key: key);

  @override
  _AddComponentState createState() => _AddComponentState();
}

class _AddComponentState extends State<AddComponent> {
  TextEditingController nameController = TextEditingController();
  TextEditingController obtenueController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

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
        title: Text('Add component'),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(hintText: 'component Name'),
          ),
          TextField(
            controller: obtenueController,
            decoration: InputDecoration(hintText: 'taken when ?'),
          ),
          TextField(
            controller: stockController,
            decoration: InputDecoration(hintText: 'quantity'),
          ),
          TextField(
            controller: categoryController,
            decoration: InputDecoration(hintText: 'category'),
          ),
          ElevatedButton(
              onPressed: () {
                var component = Composant(
                    name: nameController.text,
                    obtenue: obtenueController.text,
                    stock: stockController.hashCode,
                    category: categoryController.hashCode,


                );
                Dbcreate().insertComp(component);
                Navigator.pushNamed(context, 'componentlist');
              },
              child: Text('save component'))
        ]),
      ),
    );
  }
}

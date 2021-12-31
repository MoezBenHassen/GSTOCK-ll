import 'package:flutter/material.dart';
import 'package:gstock/BackEnd/Models/composant_model.dart';
import 'package:gstock/BackEnd/database_creation.dart';
import 'package:gstock/pages/Composants/list_composants.dart';

class ComponentEdit extends StatefulWidget {
  final int id;
  final Composant comp;


  const ComponentEdit({
    Key? key,
    required this.id,
    required this.comp,
  }): super(key: key);

  @override
  _ComponentEditState createState() => _ComponentEditState();
}

class _ComponentEditState extends State<ComponentEdit> {

  TextEditingController nameController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();


  @override
  void initState() {
    getData();
    super.initState();
  }

  getData(){
    nameController.text = widget.comp.name;
    stockController.text = widget.comp.stock.toString();
    dateController.text= widget.comp.obtenue.toString();
    selectedDate = widget.comp.obtenue;
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
            controller: dateController,
          ),
          TextField(
            controller: stockController,
          ),

          ElevatedButton(
              onPressed: () {
                Composant comp = Composant(
                    name: nameController.text,
                    obtenue: selectedDate,
                    stock: int.parse(stockController.text),
                    category: widget.id,
                    );
                Dbcreate().updateComp(widget.comp.id!, comp);
                Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) =>
                    ComponentList(id: widget.id)));
              },
              child: Text('Edit Component'))
        ]),
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gstock/BackEnd/Models/composant_model.dart';
import 'package:gstock/BackEnd/database_creation.dart';
import 'package:gstock/pages/Composants/list_composants.dart';

class AddComponent extends StatefulWidget {
  final int id;
  const AddComponent({Key? key, required this.id}) : super(key: key);



  @override
  _AddComponentState createState() => _AddComponentState();
}

class _AddComponentState extends State<AddComponent> {
  TextEditingController nameController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController obtenueController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  void initState(){
    getData();
    super.initState();
  }

  getData() async{
    setState(() {});
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate){
      setState(() {
        selectedDate = picked;
        obtenueController.text = picked.toIso8601String();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer : Drawer (
          child : ListView(
            padding : EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration : BoxDecoration(
                  gradient : LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Color(0xFFFFA53E), Color(0xFFFF7643)],
                  ),
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
        backgroundColor: Color(0xFFFF7643),
        title: Text('Add component'),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
                hintText: 'component Name',
                floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
          TextField(
            controller: obtenueController,
            decoration: InputDecoration(hintText: 'taken when ?'),
            onTap: (){
              _selectDate(context);
            },
          ),
          TextField(
            controller: stockController,
            decoration: InputDecoration(hintText: 'Stock'),
          ),

          ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromWidth(300),
                textStyle: const TextStyle(fontSize: 20),
                padding: const EdgeInsets.all(16),
                primary: Color(0xFFFF7643),
              ),
              onPressed: () {
                Composant comp = Composant(
                    name: nameController.text,
                    obtenue: selectedDate,
                    stock: int.parse(stockController.text),
                    category: widget.id,

                );
                Dbcreate().insertComp(comp);
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>
                ComponentList(id: widget.id)));
              },
              child: Text('save component'))
        ]),
      ),
    );
  }
}

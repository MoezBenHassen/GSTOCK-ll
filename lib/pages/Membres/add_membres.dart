import 'package:flutter/material.dart';
import 'package:gstock/BackEnd/Models/membre_model.dart';
import 'package:gstock/BackEnd/database_creation.dart';

class AddMembre extends StatefulWidget {
  const AddMembre({Key? key}) : super(key: key);

  @override
  _AddMembreState createState() => _AddMembreState();
}

class _AddMembreState extends State<AddMembre> {

  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController tel1Controller = TextEditingController();
  TextEditingController tel2Controller = TextEditingController();

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
        title: Text('Add Membre'),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(children: [
          TextField(
            controller: nomController,
            decoration: InputDecoration(hintText: 'First Name'),
          ),
          TextField(
            controller: prenomController,
            decoration: InputDecoration(hintText: 'Last Name'),
          ),
          TextField(
            controller: tel1Controller,
            decoration: InputDecoration(hintText: 'Telephone 1'),
          ),
          TextField(
            controller: tel2Controller,
            decoration: InputDecoration(hintText: 'Telephone 2'),
          ),
          ElevatedButton(
              onPressed: () {
                var mem = Membre(
                    nom: nomController.text,
                    prenom: prenomController.text,
                    tel1: int.parse(tel1Controller.text),
                    tel2: int.parse(tel1Controller.text));
                Dbcreate().insertMem(mem);
                Navigator.pushNamed(context, 'memberlist');
              },
              child: Text('Save Membre'))
        ]),
      ),
    );
  }
}

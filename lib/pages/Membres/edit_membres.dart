import 'package:flutter/material.dart';
import 'package:gstock/BackEnd/database_creation.dart';
import 'package:gstock/BackEnd/Models/membre_model.dart';

class MembreEdit extends StatefulWidget {
  final Membre membre;
  final int id;
  const MembreEdit({Key? key, required this.membre, required this.id}) : super(key: key);

  @override
  _MembreEditState createState() => _MembreEditState();
}

class _MembreEditState extends State<MembreEdit> {

  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController tel1Controller = TextEditingController();
  TextEditingController tel2Controller = TextEditingController();

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData(){
    nomController.text = widget.membre.nom;
    prenomController.text = widget.membre.prenom;
    tel1Controller.text = widget.membre.tel1.toString();
    tel2Controller.text = widget.membre.tel2.toString();
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
                  color : Color(0xFFFF7643),
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
        title: Text('Edit Member'),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(children: [
          TextField(
            controller: nomController,
          ),
          TextField(
            controller: prenomController,
          ),
          TextField(
            controller: tel1Controller,
          ),
          TextField(
            controller: tel2Controller,
          ),
          ElevatedButton(
              onPressed: () {
                var mem = Membre(
                    nom: nomController.text,
                    prenom: prenomController.text,
                    tel1: int.parse(tel1Controller.text),
                    tel2: int.parse(tel1Controller.text));
                Dbcreate().updateMem(widget.id,mem);
                Navigator.pushNamed(context, 'memberlist');
              },
              child: Text('Edit Member'))
        ]),
      ),
    );
  }
}

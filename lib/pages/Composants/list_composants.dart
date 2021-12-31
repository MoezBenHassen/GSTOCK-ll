import 'package:flutter/material.dart';
import 'package:gstock/BackEnd/Models/composant_model.dart';
import 'package:gstock/BackEnd/database_creation.dart';

import 'add_composants.dart';
import 'edit_composants.dart';


class ComponentList extends StatefulWidget {

  final int id;

  const ComponentList({Key? key, required this.id}): super(key: key);



  @override
  _ComponentListState createState() => _ComponentListState();
}

class _ComponentListState extends State<ComponentList> {

  List<Map> compList = [];
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    var list = await Dbcreate().fetchComp();
    for (var element in list) {
      compList.add({
        'id' : element.id,
        'name' : element.name,
        'obtenue' : element.obtenue.toIso8601String(),
        'stock' : element.stock,
        'category': element.category,
      });}
    setState(() {});
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
        title: const Text('Components'),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.search,
                  size: 26.0,
                ),
              )
          ),
        ],
      ),
      body: SingleChildScrollView(
          child : Container(
            child: compList.isEmpty?Text("No components to show."):
            Column(
              children: compList.map((comp){
                return Card(
                  child: ExpansionTile(
                    title: Text(comp['name']),
                    trailing: Wrap(
                      children: [
                        IconButton(
                            onPressed: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ComponentEdit(
                                        comp: Composant(
                                          id: comp['id'],
                                          name: comp['name'],
                                          obtenue: DateTime.parse(comp['obtenue']),
                                          stock: comp['stock'],
                                          category: comp['category'],),
                                      id : widget.id)));
                            }, icon: Icon(Icons.edit)),


                        IconButton(
                            onPressed: (){
                              Dbcreate().deleteComp(comp['id']);
                              Navigator.push(
                                context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                    ComponentList(id: widget.id)));
                            }, icon: Icon(Icons.delete, color: Colors.red,
                        )),
                      ],
                    ),
                    children: <Widget>[
                      Text('stock: '+comp['stock'].toString()),
                      Text('Date: ' +comp['obtenue'].toString().replaceRange(10, comp['obtenue'].length, '')),
                    ],
                  ),
                );
              }).toList(),
            ),
          )
      ),
      floatingActionButton: FloatingActionButton(
        child : const Icon(Icons.add),
        onPressed:(){
          Navigator.push(context,
              MaterialPageRoute(
                  builder: (context) =>
                      AddComponent(id: widget.id)));
        },
      ),
    );
  }

}

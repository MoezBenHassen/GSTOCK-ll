import 'package:flutter/material.dart';
import 'package:gstock/BackEnd/Models/membre_model.dart';
import 'package:gstock/BackEnd/database_creation.dart';
import 'package:gstock/pages/Membres/edit_membres.dart';

class MemberList extends StatefulWidget {
  const MemberList({Key? key}) : super(key: key);

  @override
  _MemberListState createState() => _MemberListState();
}

class _MemberListState extends State<MemberList> {
  List<Map> memlist = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    var list = await Dbcreate().fetchMem();
    for (var element in list) {
      memlist.add({
        'id': element.id,
        'nom': element.nom,
        'prenom': element.prenom,
        'tel1': element.tel1,
        'tel2': element.tel2
      });
    }
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
        title: const Text('Members'),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.search,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: DataTable(
        columnSpacing: 1.0,
        columns: [
          DataColumn(label: Container(
            width: 80,
            child: Text('First name',style: TextStyle(fontSize: 12),),
          ),),
          DataColumn(label: Container(
            width: 80,
            child: Text('Last name',style: TextStyle(fontSize: 12),),
          ),),
          DataColumn(label: Container(
            width: 80,
            child: Text('Telephone',style: TextStyle(fontSize: 12),),
          ),),
          DataColumn(label: Container(
            width: 100,
            child: Text('Action',style: TextStyle(fontSize: 12),),
          ),),
        ],
        rows: List.generate(memlist.length, (index) {
          return DataRow(cells: <DataCell>[
            DataCell(Text(memlist.elementAt(index)['nom'],style: TextStyle(fontSize: 12),)),
            DataCell(Text(memlist.elementAt(index)['prenom'],style: TextStyle(fontSize: 12),)),
            DataCell(Text(memlist.elementAt(index)['tel1'].toString() +
                '/' +
                memlist.elementAt(index)['tel2'].toString(),style: TextStyle(fontSize: 12),)),
            DataCell(Wrap(direction: Axis.horizontal,
              children: <Widget>[
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MembreEdit(
                                  membre: Membre(
                                      nom: memlist.elementAt(index)['nom'],
                                      prenom:
                                          memlist.elementAt(index)['prenom'],
                                      tel1: memlist.elementAt(index)['tel1'],
                                      tel2:
                                          memlist.elementAt(index)['tel2']),
                                  id: memlist.elementAt(index)['id'],
                              )));
                    },
                    icon: Icon(Icons.edit)),
                IconButton(
                    onPressed: () {
                      Dbcreate().deleteMem(memlist.elementAt(index)['id']);
                      Navigator.pushNamed(context, 'memberlist');
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
              ],
            ))
          ]);
        }),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, 'addmem');
        },
      ),
    );
  }
}

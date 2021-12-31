import 'package:flutter/material.dart';

import 'package:gstock/BackEnd/database_creation.dart';
import 'package:gstock/pages/Categories/edit_categories.dart';
import 'package:gstock/pages/Composants/list_composants.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {

  List<Map> categlist = [];
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    var list = await Dbcreate().fetchCateg();
    for (var element in list) {categlist.add({'id' : element.id, 'name' : element.name});}
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
        //foregroundColor: Color(0xFFFF7643),
        backgroundColor: Color(0xFFFF7643),
        title: const Text('Categories'),

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
          child: categlist.isEmpty?Text("No categories to show."):
          Column(
            children: categlist.map((categ){
              return Card(
                child: ListTile(
                  title: Text(categ['name']),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                        builder:
                          (context) => ComponentList(
                            id: categ['id'],
                          )));
                            print(categ['id']);
                          },

                  trailing: Wrap(children: [
                    IconButton(
                        onPressed: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) =>
                                  CategoryEdit(
                                      id: categ['id'],
                                      name: categ['name']
                                  )));
                        }, icon: Icon(Icons.edit)),

                    IconButton(
                        onPressed: (){
                          Dbcreate().deleteCateg(categ['id']);
                          Navigator.pushNamed(context, 'categorylist');
                        }, icon: Icon(Icons.delete, color: Colors.red,)),


                  ],),
                ),
              );
            }).toList(),
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        child : const Icon(Icons.add),
        backgroundColor: Color(0xFFFF7643),
        onPressed: (){Navigator.pushNamed(context, 'addcateg');},
      ),
    );
  }

}

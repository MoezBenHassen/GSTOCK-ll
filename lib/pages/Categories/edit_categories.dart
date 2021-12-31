import 'package:flutter/material.dart';
import 'package:gstock/BackEnd/Models/category_model.dart';
import 'package:gstock/BackEnd/database_creation.dart';

class CategoryEdit extends StatefulWidget {
  final int id;
  final String name;

  const CategoryEdit({Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  _CategoryEditState createState() => _CategoryEditState();
}

class _CategoryEditState extends State<CategoryEdit> {

   TextEditingController nameController = TextEditingController();

   @override
   void initState() {
     getData();
     super.initState();
   }

   getData(){
     nameController.text = widget.name;
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
        title: Text('Edit Category'),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(children: [
          TextField(
            controller: nameController,
          ),
          ElevatedButton(
              onPressed: () {
                var categ = Category(name: nameController.text);
                Dbcreate().updateCateg(widget.id, categ);
                Navigator.pushNamed(context, 'categorylist');
              },
              child: Text('Edit Category'))
        ]),
      ),
    );
  }
}

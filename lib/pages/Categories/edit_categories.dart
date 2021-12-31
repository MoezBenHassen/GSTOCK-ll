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
        title: Text('Edit Category'),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(children: [
          TextField(
            controller: nameController,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromWidth(300),
                textStyle: const TextStyle(fontSize: 20),
                padding: const EdgeInsets.all(16),
                primary: Color(0xFFFF7643),
              ),
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

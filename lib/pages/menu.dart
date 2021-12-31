import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          backgroundColor: Color(0xFFFF7643),
          //foregroundColor: Color(0xFFFF7643),
          title: const Text('Home Menu'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size.fromWidth(300),
                    textStyle: const TextStyle(fontSize: 20),
                    padding: const EdgeInsets.all(16),
                    primary: Color(0xFFFF7643),
                    //color: const Color(0xFFFF7643),
                ),

                child: const Text('Members'),
                onPressed: (){Navigator.pushNamed(context, 'memberlist');},
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size.fromWidth(300),
                    textStyle: const TextStyle(fontSize: 20),
                    padding: const EdgeInsets.all(16),
                    primary: Color(0xFFFF7643),
                ),
                child: const Text('Categories'),
                onPressed: (){Navigator.pushNamed(context, 'categorylist');},
              ),
              const SizedBox(height: 20),
            ],
          ),
        )

    );
  }
}

import 'package:flutter/material.dart';
import 'package:gstock/BackEnd/Models/admin_model.dart';
import 'package:gstock/BackEnd/database_creation.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Color(0xFF2C2F33),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:AssetImage('assets/login.png'), fit: BoxFit.cover
                ),
              ),
             /* padding: EdgeInsets.only(left: 35, top: 130),
              child: Text(
                'Welcome\n\n',
                style: TextStyle(color: Color(0xFFFFA53E), fontSize: 33),
              ),*/
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        children: [
                          TextField(
                            controller:nameController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Color(0xFFFFA53E),
                                  ),
                                ),
                                fillColor: Color(0xFF2C2F33),
                                filled: true,
                                labelText: 'Name',
                                labelStyle: TextStyle(color: Color(0xFFFFA53E)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xFFFFA53E), width: 2.0),
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextField(
                            controller:passwordController,
                            style: TextStyle(),
                            obscureText: true,
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Color(0xFFFFA53E),
                                  ),
                                ),
                                fillColor: Color(0xFF2C2F33),
                                filled: true,
                                labelText: "Password",
                                labelStyle: TextStyle(color: Color(0xFFFFA53E)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xFFFFA53E), width: 2.0),
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Sign in',
                                style: TextStyle(
                                  color: Color(0xFFFFA53E),
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Color(0xFF2C2F33),
                                child: IconButton(
                                    color:Color(0xFFFFA53E),
                                    onPressed: () async {
                                      var admins = await Dbcreate().fetchAdmin();
                                      for (var map in admins){
                                        if(map.name == nameController.text && map.password == passwordController.text){
                                          Navigator.pushNamed(context, 'menu');
                                        }
                                      }

                                    },
                                    icon: Icon(
                                      Icons.arrow_forward_ios ,
                                    )),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, 'register');
                                },
                                child: Text(
                                  'Sign Up',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Color(0xFFFFA53E),
                                      fontSize: 14),
                                ),
                                style: ButtonStyle(),
                              ),

                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
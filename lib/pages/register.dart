import 'package:flutter/material.dart';
import 'package:gstock/BackEnd/Models/admin_model.dart';
import 'package:gstock/BackEnd/database_creation.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image:AssetImage('assets/register.png'), fit: BoxFit.cover
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          TextField(
                            controller: nameController,
                            style: TextStyle(color: Color(0xFF2C2F33)),
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Color(0xFF2C2F33),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xFF2C2F33), width: 2.0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: "Name",
                                labelStyle: TextStyle(color: Color(0xFFFFA53E)),
                                ),
                          ),

                          SizedBox(
                            height: 30,
                          ),
                          TextField(
                            controller: passwordController,
                            style: TextStyle(color: Colors.white),
                            obscureText: true,
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Color(0xFF2C2F33),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xFF2C2F33), width: 2.0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: "Password",
                                labelStyle: TextStyle(color: Color(0xFF2C2F33)),
                                border: OutlineInputBorder(
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
                                'Sign Up',
                                style: TextStyle(
                                    color: Color(0xFF2C2F33),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Color(0xFF2C2F33),
                                child: IconButton(
                                    color: Color(0xFFFFA53E),
                                    onPressed: () {
                                      var admin = Admin(name: nameController.text,
                                          password: passwordController.text);
                                      Dbcreate().insertAdmin(admin);
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward_ios,
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
                                  Navigator.pushNamed(context, 'login');
                                },
                                child: Text(
                                  'Sign In',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color(0xFF2C2F33),
                                      fontSize: 18),
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
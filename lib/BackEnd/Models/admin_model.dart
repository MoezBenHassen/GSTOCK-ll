import 'dart:async';

import 'package:gstock/BackEnd/Models/category_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

  class Admin{
    final int? id;
    final String name;
    final String password;

    Admin({
      this.id,
      required this.name,
      required this.password,
    });

    Map<String, dynamic> toMap(){
      return{
        'name' : name,
        'password' : password,
      };
    }

    @override
  String toString() {
    return 'Admin{name: $name, password: $password}';
  }

  }
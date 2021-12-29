import 'dart:async';

import 'package:gstock/BackEnd/Models/composant_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

  class Category{
    final int? id;
    final String name;

    Category({
      this.id,
      required this.name,
    });

    Map<String, dynamic> toMap(){
      return{
        'name' : name,
      };
    }

    @override
  String toString() {
    return 'Category{name : $name}';
  }
  }
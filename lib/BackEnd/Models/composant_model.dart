import 'dart:async';

import 'package:gstock/BackEnd/Models/category_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

  class Composant{
    final int? id;
    final String name;
    final DateTime obtenue;
    final int stock;
    final int category;

    Composant({
      this.id,
      required this.name,
      required this.obtenue,
      required this.stock,
      required this.category,
    });

    Map<String, dynamic> toMap(){
      return{
        'name' : name,
        'obtenue' : obtenue.toIso8601String(),
        'stock' : stock,
        'FK_category' : category,
      };
    }

    @override
    String toString() {
      return 'Composant{name : $name, obtenue : $obtenue, stock : $stock, category : $category}';
    }
  }
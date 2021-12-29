import 'dart:async';

import 'package:gstock/BackEnd/Models/category_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


  class Retour {
    final int? id;
    final int composant;
    final DateTime date;
    final String etat;

    Retour({
      this.id,
      required this.composant,
      required this.date,
      required this.etat,
    });

    Map<String, dynamic> toMap(){
      return{
        'FK_composant' : composant,
        'date' : date.toIso8601String(),
        'etat' : etat,
      };
    }

    @override
    String toString() {
      return 'Retour{composant : $composant, date : $date, etat : $etat}';
    }
  }
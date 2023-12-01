import 'package:crud_app/nutricionista/nutricionista_gateway.dart';
import 'package:crud_app/nutricionista/nutricionista_modelo.dart';
import 'package:crud_app/usuario/usuario_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class NutricionistaController extends ChangeNotifier {

  

  List<NutricionistaModelo> get nutricionistas {
  return Hive.box('nutricionistas').values.cast<Map<String, dynamic>>().map((e) => NutricionistaModelo.fromJson(e)).toList();}



  Future<void> salvar(NutricionistaModelo nutricionista) async {
    try {
    var nutricionistas = Hive.box('nutricionistas');
    nutricionistas.put(nutricionista.email,nutricionista.toJson());
    } catch (e) {
      print('Erro ao salvar nutricionista: $e');
    }
  }

  Future<void> excluir(NutricionistaModelo nutricionista) async {
    var nutricionistas = Hive.box('nutricionistas');
    nutricionistas.delete(nutricionista.email);
    notifyListeners();
    }
  }

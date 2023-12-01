import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:crud_app/usuario/usuario_model.dart';
import 'paciente_modelo.dart';

class PacienteController extends ChangeNotifier {
List<PacienteModelo> get pacientes {
    return Hive.box('pacientes').values.cast<Map<String, dynamic>>().map((e) => PacienteModelo.fromJson(e)).toList();}


  Future<void> salvar(PacienteModelo paciente) async {
       var pacientes = Hive.box('pacientes');
       pacientes.put(paciente.email,paciente.toJson());
    }
  

Future<void> excluir(PacienteModelo paciente) async {
    var pacientes = Hive.box('pacientes');
    pacientes.delete(paciente.email);
    notifyListeners();
    }
   


  }
 
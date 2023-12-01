import 'package:crud_app/nutricionista/nutricionista_form.dart';
import 'package:crud_app/nutricionista/nutricionista_lista.dart';
import 'package:crud_app/pacientes/paciente_form.dart';
import 'package:crud_app/pacientes/paciente_lista.dart';
import 'package:crud_app/usuario/login_form.dart';
import 'package:crud_app/tela_inicial.dart';
import 'package:crud_app/usuario/usuario_form.dart';
import 'package:crud_app/usuario/usuarios_lista.dart'; 
import 'package:flutter/material.dart';

class Rotas {
  // Rotas principais
  static const String TELA_INICIAL = '/tela_inicial'; 
  static const String LOGIN = '/login';
  static const String REGISTRAR = '/registrar';
  static const String PACIENTES = '/pacientes';
  static const String NUTRICIONISTAS ='/nutricionistas';
  static const String USUARIOS = '/usuarios';

  // Sub-rotas
  static const String PACIENTES_ADD = '/pacientes/add';
  static const String NUTRICIONISTAS_ADD ='/nutricionistas/add';
  static const String USUARIOS_ADD ='/usarios/add';

  // Mapeamento de rotas para telas
  static Map<String, WidgetBuilder> widgetsMap() {
    return {
      TELA_INICIAL: (context) => TelaInicial(), 
      PACIENTES: (context) => const PacientesLista(),
      PACIENTES_ADD: (context) => PacienteForm(),
      LOGIN: (context) => const LoginForm(),
      NUTRICIONISTAS: (contex) => const NutricionistasLista(),
      NUTRICIONISTAS_ADD: (context) => NutricionistaForm(),
      USUARIOS: (contex) =>  UsuarioForm(),
      USUARIOS_ADD: (context) => UsuariosLista(),
    };
  }
}
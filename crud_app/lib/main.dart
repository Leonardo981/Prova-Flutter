import 'package:crud_app/navegacao_controller.dart';
import 'package:crud_app/nutricionista/nutricionista_controller.dart';
import 'package:crud_app/nutricionista/nutricionista_modelo.dart';
import 'package:crud_app/pacientes/paciente_controller.dart';
import 'package:crud_app/pacientes/paciente_modelo.dart';
import 'package:crud_app/rotas.dart';
import 'package:crud_app/usuario/usuario_controller.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Hive.openBox('pacientes'),
      builder: (context, pacientesSnapshot) {
        if (pacientesSnapshot.connectionState == ConnectionState.done) {
          if (pacientesSnapshot.error != null) {
            return ErrorWidget(pacientesSnapshot.error!);
          } else {
            return FutureBuilder(
              future: Hive.openBox('nutricionistas'),
              builder: (context, nutricionistasSnapshot) {
                if (nutricionistasSnapshot.connectionState == ConnectionState.done) {
                  if (nutricionistasSnapshot.error != null) {
                    return ErrorWidget(nutricionistasSnapshot.error!);
                  } else {
                    return MultiProvider(
                      providers: [
                        ChangeNotifierProvider(create: (context) => PacienteController()),
                        ChangeNotifierProvider(create: (context) => NavegacaoController()),
                        ChangeNotifierProvider(create: (context) => UsuarioController()),
                        ChangeNotifierProvider(create: (context) => NutricionistaController()),
                        ChangeNotifierProvider(create: (context) => UsuarioController()),
                      ],
                      child: MaterialApp(
                        initialRoute: Rotas.LOGIN,
                        routes: Rotas.widgetsMap(),
                        theme: ThemeData(
                          useMaterial3: true,
                          colorSchemeSeed: Colors.lightBlue,
                        ),
                      ),
                    );
                  }
                } else {
                  return const CircularProgressIndicator();
                }
              },
            );
          }
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

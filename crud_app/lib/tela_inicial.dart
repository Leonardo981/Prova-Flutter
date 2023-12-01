import 'package:crud_app/usuario/usuarios_lista.dart';
import 'package:flutter/material.dart';
import 'package:crud_app/pacientes/paciente_lista.dart';
import 'package:crud_app/nutricionista/nutricionista_lista.dart';

class TelaInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela Inicial'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PacientesLista()),
                );
              },
              child: Text('Ir para Lista de Pacientes'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NutricionistasLista()),
                );
              },
              child: Text('Ir para Lista de Nutricionistas'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UsuariosLista()),
                );
              },
              child: Text('Ir para Lista de Usuários'),
            ),
          ],
        ),
      ),
    );
  }
}
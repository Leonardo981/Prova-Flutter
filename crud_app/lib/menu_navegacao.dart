import 'package:crud_app/navegacao_controller.dart';
import 'package:crud_app/rotas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuNavegacao extends StatefulWidget {
  const MenuNavegacao({super.key});

  @override
  State<MenuNavegacao> createState() => _MenuNavegacaoState();
}

class _MenuNavegacaoState extends State<MenuNavegacao> {
  String _getRotaSelecionada(int index) {
    return {
          0: Rotas.PACIENTES,
        }[index] ??
        Rotas.PACIENTES;
  }

  @override
  Widget build(BuildContext context) {
    var navegacaoController = Provider.of<NavegacaoController>(context);

    return NavigationBar(
      onDestinationSelected: (int index) {
        navegacaoController.atualizarTelaSelecionada(index);
        Navigator.pushReplacementNamed(context, _getRotaSelecionada(index));
      },
      indicatorColor: Colors.blue[800],
      selectedIndex: navegacaoController.telaSelecionada,
      destinations: const <Widget>[
        NavigationDestination(
          selectedIcon: Icon(Icons.person_2),
          icon: Icon(Icons.person_2_outlined),
          label: 'Pessoas',
        ),
      ],
    );
  }
}

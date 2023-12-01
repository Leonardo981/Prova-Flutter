import 'package:crud_app/pacientes/paciente_controller.dart';
import 'package:crud_app/pacientes/paciente_form.dart';
import 'package:crud_app/rotas.dart';
import 'package:crud_app/usuario/usuario_controller.dart';
import 'package:crud_app/usuario/usuario_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PacientesLista extends StatefulWidget {
  const PacientesLista({super.key});

  @override
  State<PacientesLista> createState() => _PacientesListaState();
}

class _PacientesListaState extends State<PacientesLista> {
  UsuarioModelo? usuarioLogado;

  @override
  Widget build(BuildContext context) {
    var pacienteController = Provider.of<PacienteController>(context);
    var usuarioController = Provider.of<UsuarioController>(context);
    usuarioLogado = usuarioController.usuarioLogado;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro de Pacientes'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, Rotas.PACIENTES_ADD);
          },
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: ListView.builder(
            itemCount: pacienteController.pacientes.length,
            itemBuilder: (BuildContext context, int index) {
              final paciente = pacienteController.pacientes[index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Confirmar Exclusão"),
                          content: const Text("Tem certeza que deseja excluir?"),
                          actions: [
                            TextButton(
                              child: const Text('Confirmar'),
                              onPressed: () {
                                pacienteController.excluir(paciente);
                                // Mostrar mensagem de sucesso após exclusão
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text('Paciente excluído com sucesso.'),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                                                              Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('Cancelar'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.delete),
                  ),
                  title: Text('Nome: ${paciente.nome}'),
                  subtitle: Text('Email: ${paciente.email}'),
                  onTap: () {},
                  onLongPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            PacienteForm(pacienteSelecionada: paciente),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
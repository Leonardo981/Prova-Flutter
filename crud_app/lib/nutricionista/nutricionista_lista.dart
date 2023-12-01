import 'package:crud_app/nutricionista/nutricionista_controller.dart';
import 'package:crud_app/nutricionista/nutricionista_form.dart';
import 'package:crud_app/rotas.dart';
import 'package:crud_app/usuario/usuario_controller.dart';
import 'package:crud_app/usuario/usuario_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NutricionistasLista extends StatefulWidget {
  const NutricionistasLista({Key? key}) : super(key: key);

  @override
  _NutricionistasListaState createState() => _NutricionistasListaState();
}

class _NutricionistasListaState extends State<NutricionistasLista> {
  UsuarioModelo? usuarioLogado;

  @override
  Widget build(BuildContext context) {
    var nutricionistaController = Provider.of<NutricionistaController>(context);
    var usuarioController = Provider.of<UsuarioController>(context);
    usuarioLogado = usuarioController.usuarioLogado;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro de Nutricionistas'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, Rotas.NUTRICIONISTAS_ADD);
          },
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: ListView.builder(
            itemCount: nutricionistaController.nutricionistas.length,
            itemBuilder: (BuildContext context, int index) {
              final nutricionista = nutricionistaController.nutricionistas[index];
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
                                nutricionistaController.excluir(nutricionista);
                                // Mostrar mensagem de sucesso após exclusão
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text('Nutricionista excluído com sucesso.'),
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
                  title: Text('Nome: ${nutricionista.nome}'),
                  subtitle: Text('Email: ${nutricionista.email}'),
                  onTap: () {},
                  onLongPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            NutricionistaForm(nutricionistaSelecionado: nutricionista),
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
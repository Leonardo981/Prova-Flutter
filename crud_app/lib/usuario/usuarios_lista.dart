import 'package:crud_app/usuario/usuario_controller.dart';
import 'package:crud_app/usuario/usuario_form.dart';
import 'package:crud_app/rotas.dart';
import 'package:crud_app/usuario/usuario_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsuariosLista extends StatefulWidget {
  const UsuariosLista({Key? key}) : super(key: key);

  @override
  State<UsuariosLista> createState() => _UsuariosListaState();
}

class _UsuariosListaState extends State<UsuariosLista> {
  UsuarioModelo? usuarioLogado;

  @override
  Widget build(BuildContext context) {
    var usuarioController = Provider.of<UsuarioController>(context);
    usuarioLogado = usuarioController.usuarioLogado;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Usuários'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, Rotas.USUARIOS_ADD);
          },
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: FutureBuilder<List<UsuarioModelo>>(
            future: usuarioController.buscarUsuarios(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              } else {
                List<UsuarioModelo>? usuarios = snapshot.data;
                return ListView.builder(
                  itemCount: usuarios?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    final usuario = usuarios![index];
                    return Card(
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        title: Text('Usuário: ${usuario.usuario}'),
                        subtitle: Text('Senha: ${usuario.senha}'),
                        onTap: () {},
                        onLongPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  UsuarioForm(usuarioSelecionado: usuario),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
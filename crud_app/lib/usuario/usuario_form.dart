import 'package:flutter/material.dart';
import 'package:crud_app/usuario/usuario_controller.dart';
import 'package:crud_app/usuario/usuario_model.dart';
import 'package:provider/provider.dart';

class UsuarioForm extends StatefulWidget {
  final UsuarioModelo? usuarioSelecionado;

  UsuarioForm({Key? key, this.usuarioSelecionado}) : super(key: key);

  @override
  _UsuarioFormState createState() => _UsuarioFormState();
}

class _UsuarioFormState extends State<UsuarioForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _usuario = '';
  String _senha = '';

  @override
  Widget build(BuildContext context) {
    var usuarioController = Provider.of<UsuarioController>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cadastro de Usuário'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  initialValue: widget.usuarioSelecionado?.usuario ?? '',
                  decoration: InputDecoration(labelText: 'Usuário'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Digite o nome de usuário';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _usuario = value!;
                  },
                ),
                TextFormField(
                  initialValue: widget.usuarioSelecionado?.senha ?? '',
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Senha'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Digite a senha';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _senha = value!;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      await usuarioController.cadastrarUsuario(_usuario, _senha);
                    }
                  },
                  child: Text('Cadastrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
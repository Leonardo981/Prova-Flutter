import 'package:crud_app/rotas.dart';
import 'package:crud_app/usuario/usuario_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_auth/local_auth.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  bool _salvarCredenciais = false;

  final LocalAuthentication _localAuth = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    var usuarioController = Provider.of<UsuarioController>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Entrar no Sistema'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _usuarioController,
                    autofocus: true,
                    decoration: const InputDecoration(labelText: 'Usuário'),
                    validator: (value) {
                      if ((value ?? '').isEmpty) {
                        return 'Informe o usuário';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _senhaController,
                    autocorrect: false,
                    obscureText: true,
                    autofocus: true,
                    decoration: const InputDecoration(labelText: 'Senha'),
                    validator: (value) {
                      if ((value ?? '').isEmpty) {
                        return 'Informe a senha';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Checkbox(
                        value: _salvarCredenciais,
                        onChanged: (value) {
                          setState(() {
                            _salvarCredenciais = value ?? false;
                          });
                        },
                      ),
                      const Text('Salvar Credenciais'),
                    ],
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        // Salvar credenciais se a opção estiver marcada
                        if (_salvarCredenciais) {
                          await _salvarCredenciaisLocal();
                        }

                        // Tenta autenticação biométrica
                        bool authenticated = false;
                        try {
                          authenticated = await _autenticacaoBiometrica();
                        } catch (e) {
                          print('Erro durante a autenticação biométrica: $e');
                        }

                        if (authenticated ||
                            await usuarioController.login(
                                _usuarioController.text,
                                _senhaController.text)) {
                          Navigator.pushReplacementNamed(
                              context, Rotas.TELA_INICIAL);
                        } else {
                          const snackBar = SnackBar(
                            content: Text('Usuário ou senha inválidos!'),
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBar);
                        }
                      }
                    },
                    child: const Text('Entrar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

 Future<bool> _autenticacaoBiometrica() async {
    bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
    if (canCheckBiometrics) {
      List<BiometricType> availableBiometrics =
          await _localAuth.getAvailableBiometrics();
      if (availableBiometrics.isNotEmpty) {
        return await _localAuth.authenticate(
          localizedReason: 'Toque no sensor para autenticar',
        );
      }
    }
    return false;
  }
  Future<void> _salvarCredenciaisLocal() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('usuario', _usuarioController.text);
    await prefs.setString('senha', _senhaController.text);
  }
}
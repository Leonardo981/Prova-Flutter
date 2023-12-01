import 'package:crud_app/usuario/usuario_gateway.dart';
import 'package:crud_app/usuario/usuario_model.dart';
import 'package:flutter/material.dart';

class UsuarioController extends ChangeNotifier {
  final UsuarioApiGateway _usuarioApiGateway = UsuarioApiGateway();
  List<UsuarioModelo>? _usuarios;

  List<UsuarioModelo> get usuarios => List.unmodifiable(_usuarios ?? []);

  UsuarioModelo? get usuarioLogado => null;

  Future<bool> login(String usuario, String senha) async {
    try {
      UsuarioModelo? usuarioLogado = await _usuarioApiGateway.login(usuario, senha);
      if (usuarioLogado != null) {
    
        _usuarios = [usuarioLogado];
        notifyListeners();
        return true;
      }
    } catch (e) {
      print('Erro no login: $e');
    }
    return false;
  }

  Future<void> cadastrarUsuario(String usuario, String senha) async {
    try {
      await _usuarioApiGateway.cadastrarUsuario(usuario, senha);
    
      buscarUsuarios();
    } catch (e) {
      print('Erro ao cadastrar usuário: $e');
    }
  }

  Future<List<UsuarioModelo>> buscarUsuarios() async {
    try {
      _usuarios = await _usuarioApiGateway.fetchUsuarios();
      notifyListeners();
    } catch (e) {
      print('Erro ao buscar usuários: $e');
    }
      return [];
  }

  Future<void> atualizarUsuario(UsuarioModelo usuario) async {
    try {
      await _usuarioApiGateway.atualizarUsuario(usuario);
      buscarUsuarios();
    } catch (e) {
      print('Erro ao atualizar usuário: $e');
    }
  }

  Future<void> excluirUsuario(UsuarioModelo usuario) async {
    try {
      await _usuarioApiGateway.excluirUsuario(usuario);
      buscarUsuarios();
    } catch (e) {
      print('Erro ao excluir usuário: $e');
    }
  }
}
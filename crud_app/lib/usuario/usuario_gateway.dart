import 'package:dio/dio.dart';
import 'package:crud_app/usuario/usuario_model.dart';
import 'package:logging/logging.dart';

class UsuarioApiGateway {
  static const LOGIN_URL = "http://10.0.2.2:8080/publico/usuarios/login";
  static const CADASTRO_URL = "http://10.0.2.2:8080/publico/usuarios/cadastrar";
  static const ATUALIZAR_URL = "http://10.0.2.2:8080/publico/usuarios/atualizar";
  static const EXCLUIR_URL = "http://10.0.2.2:8080/publico/usuarios/excluir";
  static const FETCH_USUARIOS_URL = "http://10.0.2.2:8080/geral/usuarios"; // Substitua pela URL real

  final Dio dio = Dio();
  final log = Logger('UsuarioApiGateway');

  Future<UsuarioModelo?> login(String usuario, String senha) async {
    try {
      var response = await dio.post(LOGIN_URL, data: {
        "usuario": usuario,
        "senha": senha,
      });
      if (response.statusCode == 200) {
        return UsuarioModelo(usuario, senha);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        log.severe(e.response!.data);
        log.severe(e.response!.headers);
        log.severe(e.response!.requestOptions);
      } else {
        log.severe(e.requestOptions);
        log.severe(e.message);
      }
    }
    return null;
  }

  Future<void> cadastrarUsuario(String usuario, String senha) async {
    try {
      var response = await dio.post(CADASTRO_URL, data: {
        "usuario": usuario,
        "senha": senha,
      });

      if (response.statusCode == 201) {
        log.info('Usuário cadastrado com sucesso.');
      } else {
        _handleError(response);
      }
    } on DioException catch (e) {
      _handleError(e.response!);
    }
  }

  Future<void> atualizarUsuario(UsuarioModelo usuario) async {
    try {
      var response = await dio.put('$ATUALIZAR_URL/${usuario.usuario}', data: {
        "senha": usuario.senha,
      });

      if (response.statusCode == 200) {
        log.info('Usuário atualizado com sucesso.');
      } else {
        _handleError(response);
      }
    } on DioException catch (e) {
      _handleError(e.response!);
    }
  }

  Future<void> excluirUsuario(UsuarioModelo usuario) async {
    try {
      var response = await dio.delete('$EXCLUIR_URL/${usuario.usuario}');

      if (response.statusCode == 204) {
        log.info('Usuário excluído com sucesso.');
      } else {
        _handleError(response);
      }
    } on DioException catch (e) {
      _handleError(e.response!);
    }
  }

  Future<List<UsuarioModelo>> fetchUsuarios() async {
    try {
      var response = await dio.get(FETCH_USUARIOS_URL);

      if (response.statusCode == 200) {
        var usuariosData = response.data as List<dynamic>;
        var usuarios = usuariosData.map((userData) => UsuarioModelo.fromJson(userData)).toList();
        return usuarios;
      } else {
        _handleError(response);
        throw Exception("Erro ao buscar usuários");
      }
    } on DioError catch (e) {
      _handleError(e.response!);
      throw Exception("Erro ao buscar usuários");
    }
  }

  void _handleError(Response response) {
    log.severe('Erro na requisição HTTP:');
    log.severe('Status Code: ${response.statusCode}');
    log.severe('Data: ${response.data}');
    log.severe('Headers: ${response.headers}');
    log.severe('Request Options: ${response.requestOptions}');
  }
}
import 'package:crud_app/pacientes/paciente_modelo.dart';
import 'package:crud_app/usuario/usuario_model.dart';
import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

class PacienteApiGateway {
  static const String PACIENTE_API_URL = "http://10.0.2.2:8080/geral/pessoas";
  final Dio dio = Dio();
  final Logger log = Logger('PacienteApiGateway');

  Future<List<PacienteModelo>?> fetchAllPaciente(UsuarioModelo usuario) async {
    try {
      final Map<String, dynamic> headers = {
        'authorization': 'Basic ${usuario.toBase64()}',
      };

      final Response response = await dio.get(
        PACIENTE_API_URL,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        final result = (response.data as List)
            .map((item) => PacienteModelo.fromJson(item))
            .toList();
        return result;
      } else {
        _handleError(response);
      }
    } on DioError catch (e) {
      _handleError(e as Response);
    }

    return null;
  }

  Future<void> incluirPaciente(PacienteModelo paciente) async {
    try {
      final Response response = await dio.post(
        PACIENTE_API_URL,
        data: paciente.toJson(),
      );

      if (response.statusCode == 201) {
        log.info('Paciente incluído com sucesso.');
      } else {
        _handleError(response);
      }
    } on DioError catch (e) {
      _handleError(e as Response);
    }
  }

  Future<void> atualizarPaciente(PacienteModelo paciente) async {
    try {
      final Response response = await dio.put(
        '$PACIENTE_API_URL/${paciente.id}',
        data: paciente.toJson(),
      );

      if (response.statusCode == 200) {
        log.info('Paciente atualizado com sucesso.');
      } else {
        _handleError(response);
      }
    } on DioError catch (e) {
      _handleError(e as Response);
    }
  }

  Future<void> excluirPaciente(PacienteModelo paciente) async {
    try {
      final Response response = await dio.delete(
        '$PACIENTE_API_URL/${paciente.id}',
      );

      if (response.statusCode == 204) {
        log.info('Paciente excluído com sucesso.');
      } else {
        _handleError(response);
      }
    } on DioError catch (e) {
      _handleError(e as Response);
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
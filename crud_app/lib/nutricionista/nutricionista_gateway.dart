import 'package:crud_app/nutricionista/nutricionista_modelo.dart';
import 'package:crud_app/usuario/usuario_model.dart';
import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

class NutricionistaApiGateway {
  static const String NUTRICIONISTA_API_URL = "http://10.0.2.2:8080/geral/nutricionistas";
  final Dio dio = Dio();
  final Logger log = Logger('NutricionistaApiGateway');

  Future<List<NutricionistaModelo>?> fetchAllNutricionista(UsuarioModelo usuario) async {
    try {
      final Map<String, dynamic> headers = {
        'authorization': 'Basic ${usuario.toBase64()}',
      };

      final Response response = await dio.get(
        NUTRICIONISTA_API_URL,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        final result = (response.data as List)
            .map((item) => NutricionistaModelo.fromJson(item))
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

 Future<void> incluirNutricionista(NutricionistaModelo nutricionista) async {
    try {
      final Response response = await dio.post(
        NUTRICIONISTA_API_URL,
        data: nutricionista.toJson(),
      );

      if (response.statusCode == 201) {
        log.info('Nutricionista incluído com sucesso.');
      } else {
        _handleError(response);
      }
    } on DioError catch (e) {
      _handleError(e as Response);
    }
  }

  Future<void> atualizarNutricionista(NutricionistaModelo nutricionista) async {
    try {
      final Response response = await dio.put(
        '$NUTRICIONISTA_API_URL/${nutricionista.id}',
        data: nutricionista.toJson(),
      );

      if (response.statusCode == 200) {
        log.info('Nutricionista atualizado com sucesso.');
      } else {
        _handleError(response);
      }
    } on DioError catch (e) {
      _handleError(e as Response);
    }
  }

  Future<void> excluirNutricionista(NutricionistaModelo nutricionista) async {
    try {
      final Response response = await dio.delete(
        '$NUTRICIONISTA_API_URL/${nutricionista.id}',
      );

      if (response.statusCode == 204) {
        log.info('Nutricionista excluído com sucesso.');
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
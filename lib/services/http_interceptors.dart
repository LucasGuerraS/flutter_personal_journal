import 'package:http_interceptor/http_interceptor.dart';
import 'package:logger/logger.dart';

class LoggingInterceptor implements InterceptorContract {
  Logger logger = Logger();

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    logger.v(
        "Requisição para ${data.baseUrl}\nCabeçalho: ${data.headers}\nCorpo: ${data.body}");
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    if (data.statusCode ~/ 100 == 2) {
      logger.i(
          "Requisição de ${data.url}\nStaus: ${data.statusCode}\nCabeçalho: ${data.headers}\nCorpo: ${data.body}");
    } else {
      logger.e(
          "Requisição de ${data.url}\nStaus: ${data.statusCode}\nCabeçalho: ${data.headers}\nCorpo: ${data.body}");
    }

    return data;
  }
}

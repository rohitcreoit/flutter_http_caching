
import 'package:flutter_http_caching/src/constant/prefs.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoggingInterceptor implements InterceptorContract {
  static int lastApiCallStatusCode = 0;
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {

    data.headers.forEach((key, value) {

    });
    longLogPrint(data.body);
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {

    if(data.statusCode == 401) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setInt(PrefKeys.lastApiStatusCode, data.statusCode);
    }
    data.headers?.forEach((key, value) {

    });
    longLogPrint(data.body);
    return data;
  }

  static void longLogPrint(Object? object) async {
    int defaultPrintLength = 1020;
    if (object == null || object.toString().length <= defaultPrintLength) {

    } else {
      String log = object.toString();

      int endIndex = defaultPrintLength;
      int logLength = log.length;
      int tmpLogLength = log.length;
      while (endIndex < logLength) {

        endIndex += defaultPrintLength;

        tmpLogLength -= defaultPrintLength;
      }
      if (tmpLogLength > 0) {

      }
    }
  }
}

Client addInterceptor(bool? isLogging, List<InterceptorContract> interceptor, Client client) {
  if(isLogging == true){
    List<InterceptorContract> data = [LoggingInterceptor(),];
    if(interceptor.isNotEmpty ==  true){
      data.addAll(interceptor);
    }
    client =  InterceptedClient.build(interceptors: data);
  }else if(interceptor.isNotEmpty ==  true){
    List<InterceptorContract> data = [];
    if(interceptor.isNotEmpty ==  true){
      data.addAll(interceptor );
    }
    client =  InterceptedClient.build(interceptors: data);
  }
  return client;
}

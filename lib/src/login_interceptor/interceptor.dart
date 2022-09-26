
import 'package:flutter_http_caching/src/constant/prefs.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoggingInterceptor implements InterceptorContract {
  static int lastApiCallStatusCode = 0;
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    print("${data.method} ${data.url}");
    data.headers.forEach((key, value) {
      print("$key: $value");
    });
    longLogPrint(data.body);
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print("${data.statusCode} ${data.url}");
    if(data.statusCode == 401) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print("Setting statusCode: ${data.statusCode}");
      prefs.setInt(PrefKeys.LAST_API_STATUS_CODE, data.statusCode);
    }
    data.headers?.forEach((key, value) {
      print("$key: $value");
    });
    longLogPrint(data.body);
    return data;
  }

  static void longLogPrint(Object? object) async {
    int defaultPrintLength = 1020;
    if (object == null || object.toString().length <= defaultPrintLength) {
      print(object.toString());
    } else {
      String log = object.toString();
      int start = 0;
      int endIndex = defaultPrintLength;
      int logLength = log.length;
      int tmpLogLength = log.length;
      while (endIndex < logLength) {
        print(log.substring(start, endIndex));
        endIndex += defaultPrintLength;
        start += defaultPrintLength;
        tmpLogLength -= defaultPrintLength;
      }
      if (tmpLogLength > 0) {
        print(log.substring(start, logLength));
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

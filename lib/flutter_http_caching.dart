library flutter_http_caching;

import 'package:flutter_http_caching/src/cache_manager/database_service.dart';
import 'package:flutter_http_caching/src/login_interceptor/interceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/interceptor_contract.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

export 'src/main.dart';

Future<Response> httpGet(Client client, String url,
    {header,
    body,
    List<InterceptorContract>? interceptor,
    bool? isLogging}) async {
  client = addInterceptor(isLogging, interceptor ?? [], client);

  bool result = await InternetConnectionChecker().hasConnection;
  var database = DBService();

  if (result) {
    var reqId =
        await database.addRequest(type: "get", url: url, header: header);

    Response response = await client.get(Uri.parse(url), headers: header);

    await database.addResponse(
        type: 'get', url: url, body: response.body, requestId: reqId);
    return response;
  } else {
    var responseRow = await database.getResponse(url);
    if (responseRow['response_body'] != null) {
      return Response(responseRow['response_body'], 200);
    } else {
      return Response("No Internet", 404);
    }
  }
}

Future<Response> httpPut(Client client, String url,
    {header,
    body,
    List<InterceptorContract>? interceptor,
    bool? isLogging}) async {
  client = addInterceptor(isLogging, interceptor ?? [], client);

  bool result = await InternetConnectionChecker().hasConnection;
  var database = DBService();

  if (result) {
    await database.addRequest(type: "put", url: url);
    var response = client.put(
      Uri.parse(url),
    );

    await database.addResponse(type: 'put', url: url, body: response);
    return response;
  } else {
    var responseRow = await database.getResponse(url);
    if (responseRow['response_body'] != null) {
      return Response(responseRow['response_body'], 200);
    } else {
      return Response("No Internet", 404);
    }
  }
}

Future<Response> httpPost(Client client, String url,
    {header,
    body,
    List<InterceptorContract>? interceptor,
    bool? isLogging}) async {
  client = addInterceptor(isLogging, interceptor ?? [], client);
  bool result = await InternetConnectionChecker().hasConnection;
  var database = DBService();

  if (result) {
    await database.addRequest(type: "post", url: url, body: body);
    var response = client.post(Uri.parse(url), headers: header, body: body);
    await database.addResponse(type: 'post', url: url, body: response);
    return response;
  } else {
    var responseRow = await database.getResponse(url);
    if (responseRow['response_body'] != null) {
      return Response(responseRow['response_body'], 200);
    } else {
      return Response("No Internet", 404);
    }
  }
}

Future<Response> httpPatch(Client client, String url,
    {header,
    body,
    List<InterceptorContract>? interceptor,
    bool? isLogging}) async {
  client = addInterceptor(isLogging, interceptor ?? [], client);
  bool result = await InternetConnectionChecker().hasConnection;
  var database = DBService();

  if (result) {
    await database.addRequest(type: "patch", url: url, body: body);
    var response = client.patch(Uri.parse(url), headers: header, body: body);

    await database.addResponse(type: 'patch', url: url, body: response);
    return response;
  } else {
    var responseRow = await database.getResponse(url);
    if (responseRow['response_body'] != null) {
      return Response(responseRow['response_body'], 200);
    } else {
      return Response("No Internet", 404);
    }
  }
}

Future<Response> httpDelete(Client client, String url,
    {header,
    body,
    List<InterceptorContract>? interceptor,
    bool? isLogging}) async {
  client = addInterceptor(isLogging, interceptor ?? [], client);
  bool result = await InternetConnectionChecker().hasConnection;
  var database = DBService();

  if (result) {
    await database.addRequest(type: "delete", url: url, body: body);
    var response = client.delete(Uri.parse(url), headers: header, body: body);

    await database.addResponse(type: 'delete', url: url, body: response);
    return response;
  } else {
    var responseRow = await database.getResponse(url);
    if (responseRow['response_body'] != null) {
      return Response(responseRow['response_body'], 200);
    } else {
      return Response("No Internet", 404);
    }
  }
}

// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter_http_caching/src/cache_manager/database_service.dart';
// import 'package:http/http.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
//
// Future<Response> getData(
//   Client client, {
//   String? url,
//   header,
//   body,
// }) async {
//   bool result = await InternetConnectionChecker().hasConnection;
//   var database = DBService();
//
//
//   if (result) {
//     var reqId =
//         await database.addRequest(type: "get", url: url, header: header);
//
//     Response response = await client.get(Uri.parse(url ?? ''), headers: header);
//
//     await database.addResponse(
//         type: 'get', url: url, body: response.body, requestId: reqId);
//     return response;
//   } else {
//     var responseRow = await database.getResponse(url);
//     if (responseRow['response_body'] != null) {
//       return Response(responseRow['response_body'], 200);
//     } else {
//       return Response("No Internet", 404);
//     }
//   }
// }
//
// putData(
//   Client client, {
//   url,
//   header,
//   body,
// }) async {
//   bool result = await InternetConnectionChecker().hasConnection;
//   var database = DBService();
//
//   if(result){
//     await database.addRequest(type: "put", url: url);
//     var response = client.put(
//       Uri.parse(url),
//     );
//
//     await database.addResponse(type: 'put', url: url, body: response);
//     return response;
//   }else{
//     var responseRow = await database.getResponse(url);
//     if (responseRow['response_body'] != null) {
//       return Response(responseRow['response_body'], 200);
//     } else {
//       return Response("No Internet", 404);
//     }
//   }
//
//
// }
//
// postData(
//   Client client, {
//   url,
//   header,
//   body,
// }) async {
//   var database = DBService();
//
//   await database.addRequest(type: "post", url: url);
//   var response = client.post(
//     Uri.parse(url),
//   );
//
//   await database.addResponse(type: 'post', url: url, body: response);
// }

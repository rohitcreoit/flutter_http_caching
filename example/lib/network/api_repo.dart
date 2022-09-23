
import 'dart:html';

import 'package:http/http.dart' as http;
import 'package:flutter_http_caching/flutter_http_caching.dart';

var baseUrl = 'https://api.spaceflightnewsapi.net/v3/articles?_start=1';

Future getNewsData() async {

  var client = http.Client();
  var response = getData(client,url:baseUrl );

  return response;

}
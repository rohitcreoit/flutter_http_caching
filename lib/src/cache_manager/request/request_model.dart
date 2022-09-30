
class ApiRequestData {
  ApiRequestData(
      {this.id,this.body, required this.type, this.header, required this.reqUrl});

  int? id;
  String reqUrl;
  String type;
  String? header;
  String? body;
}

ApiRequestData getRequestItems(Map<String, dynamic> map) {
  return ApiRequestData(
    id: map['_id'],
      reqUrl: map['request_url'],
      type: map['request_type'],
      header: map['request_header'],
      body: map['request_body'],);
}
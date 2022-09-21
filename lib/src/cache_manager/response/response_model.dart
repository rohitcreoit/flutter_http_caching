class ApiResponseData {
  ApiResponseData(
      {this.id, required this.type, this.responseId, this.response});

  int? id;
  String? responseId;
  String type;
  String? response;
}

ApiResponseData getResponseItems(Map<String, dynamic> map) {
  return ApiResponseData(
    id: map['_id'],
    responseId: map['request_id'],
    type: map['request_type'],
    response: map['response'],
  );
}

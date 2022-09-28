import 'database_helper.dart';

abstract class DBOperation {
  addResponse({
    required String type,
    url,
    body,
    requestId,
  });

  removeResponse({var id});

  getResponse(var url);

  clearAllResponse();

  addRequest({
    required String type,
    url,
    body,
    header,
  });

  removeRequest({var id});

  clearAllRequest();
}

class DBService implements DBOperation {
  final db = DBHelper.instance;

  @override
  addResponse({required String type, url, body, requestId}) async {
    // row to insert
    Map<String, dynamic> row = {
      DBHelper.type: type,
      DBHelper.response: '$body',
      DBHelper.requestId: "$requestId",
      DBHelper.url: "$url"
    };
    await db.insertResponse(row);
  }

  @override
  removeResponse({id}) async {
    await db.deleteResponse(id);
  }

  @override
  clearAllResponse() async {
    await db.deleteAllResponse();
  }

  @override
  getResponse(var url) async {
    List<String> columnsToSelect = [
      DBHelper.type,
      DBHelper.response,
      DBHelper.requestId,
      DBHelper.url,
    ];
    String whereString = '${DBHelper.url} = ?';
    List<dynamic> whereArguments = [url];
    List<Map> result = await db.querySingleResponse(
        column: columnsToSelect, where: whereString, whereArgs: whereArguments);

    return result[0];
  }

  @override
  addRequest({
    required String type,
    url,
    body,
    header,
  }) async {
    // row to insert
    Map<String, dynamic> row = {
      DBHelper.type: type,
      DBHelper.body: '$body',
      DBHelper.header: "$header",
      DBHelper.url: "$url"
    };
    final id = await db.insertRequest(row);

    return id;
  }

  @override
  removeRequest({id}) async {
    await db.deleteRequest(id);
  }

  @override
  clearAllRequest() async {
    await db.deleteAllResponse();
  }
}

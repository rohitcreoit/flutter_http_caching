import 'package:flutter_http_caching/src/cache_manager/response/response_database_helper.dart';
import 'package:flutter_http_caching/src/cache_manager/response/response_model.dart';

abstract class ResponseDBOperation {
  addResponse({
    required String type,
    url,
    body,
    requestId,
  });

  removeResponse({var id});

  getResponse();

  getAllResponse();

  clearAllRespones();
}

class ResponseDBService implements ResponseDBOperation {
  final db = ResponseDBHelper.instance;

  @override
  addResponse({required String type, url, body, requestId}) async {
    // row to insert
    Map<String, dynamic> row = {
      ResponseDBHelper.type: type,
      ResponseDBHelper.response: '$body',
      ResponseDBHelper.requestId: "$requestId",
      ResponseDBHelper.url: "$url"
    };
    final id = await db.insert(row);
  }

  @override
  removeResponse({id}) async {
    final rowsDeleted = await db.delete(id);
  }

  @override
  Future<List<ApiResponseData>> getAllResponse() async {
    final allRows = await db.queryAllRows();
    allRows.forEach(print);
    return List.generate(
        allRows.length, (index) => getResponseItems(allRows[index]));
  }

  @override
  clearAllRespones() async {
    final rowsDeleted = await db.deleteAll();
  }

  @override
  getResponse() async {
    List<String> columnsToSelect = [
      ResponseDBHelper.type,
      ResponseDBHelper.response,
      ResponseDBHelper.requestId,
      ResponseDBHelper.url,
    ];
    String whereString = '${ResponseDBHelper.url} = ?';
    int rowId = 1;
    List<dynamic> whereArguments = [rowId];
    List<Map> result = await db.querySingleRows(
        column: columnsToSelect, where: whereString, whereArgs: whereArguments);

    result.forEach((row) => print(row));
  }
}

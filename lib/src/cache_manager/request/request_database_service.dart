import 'package:flutter_http_caching/src/cache_manager/request/request_database_helper.dart';
import 'package:flutter_http_caching/src/cache_manager/request/request_model.dart';

abstract class RequestDBOperation {
  addRequest({
    required String type,
    url,
    body,
    header,
  });

  removeRequest({var id});

  getAllRequests();

  clearAllRequest();
}

class RequestDBService implements RequestDBOperation {
  final db = RequestDBHelper.instance;

  @override
  addRequest({
    required String type,
    url,
    body,
    header,
  }) async {
    // row to insert
    Map<String, dynamic> row = {
      RequestDBHelper.type: type,
      RequestDBHelper.body: '$body',
      RequestDBHelper.header: "$header",
      RequestDBHelper.url: "$url"
    };
    final id = await db.insert(row);

    return id;
  }

  @override
  removeRequest({id}) async {
    await db.delete(id);
  }

  @override
  Future<List<ApiRequestData>> getAllRequests() async {
    final allRows = await db.queryAllRows();
    allRows.forEach(print);
    return List.generate(
        allRows.length, (index) => getRequestItems(allRows[index]));
  }

  @override
  clearAllRequest() async {
    await db.deleteAll();
  }
}

import '../common.dart';

class BasePagination<T> {
  List<T>? items;

  int total;
  int page;
  int size;

  BasePagination({this.items, this.total = 0, this.page = 0, this.size = 0});

  factory BasePagination.dataFromJson({required dynamic json, required dynamic Function(dynamic) onDeserialize}) {
    var resp = BasePagination<T>();

    try {
      if (json is Map<String, dynamic>) {
        resp.items = onDeserialize(json['items']) as List<T>;

        resp.size = json.getInt('size') ?? 0;
        resp.page = json.getInt('page') ?? 0;
        resp.total = json.getInt('total') ?? 0;
      }
    } catch (error) {
      LogUtil.e("${T.toString()} Data parsing exception...! => " + error.toString());
      resp.items = null;
      resp.size = 0;
      resp.page = 0;
      resp.total = 0;
    }
    return resp;
  }

  bool hasNextPage() {
    return size * page < total;
  }
}

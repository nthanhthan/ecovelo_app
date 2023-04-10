import 'package:ecoveloapp/app/core.dart';

/// a HiveObject whose key is integer
abstract class IntHiveObject extends HiveObject {
  @override
  int get key => super.key as int;
}

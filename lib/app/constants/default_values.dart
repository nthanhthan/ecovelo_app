
import 'package:ecoveloapp/app/core.dart';

class DefaultValues {
  static const List<int> addMoneyValues = [1, 2, 5, 10, 20, 50];
  static const List<Map<String, String>> bankList = [
    {
        "title" : "Techcombank (TCB)",
        "body"  : "Ngân hàng TMCP Kỹ thương Việt Nam",
        "asset" : AssetsConst.techcombank
    },
    {
        "title" : "Vietinbank (CTG)",
        "body"  : "Ngân hàng TMCP Công thương Việt Nam",
        "asset" : AssetsConst.vietinbank
    },
  ];
  static const List<Map<String, String>> paymentMethodList = [
    {
        "title" : "Add New Card",
        "asset" : AssetsConst.addRectangle
    },
    {
        "title" : "Link Momo Wallet",
        "asset" : AssetsConst.momo
    },
  ];
}
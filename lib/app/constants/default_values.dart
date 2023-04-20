import 'package:ecoveloapp/app/core.dart';

class DefaultValues {
  static const List<int> addMoneyValues = [1, 2, 5, 10, 20, 50];
  static const List<Map<String, String>> bankList = [
    {
      "title": "Techcombank (TCB)",
      "body": "Ngân hàng TMCP Kỹ thương Việt Nam",
      "asset": AssetsConst.techcombank
    },
    {
      "title": "Vietinbank (CTG)",
      "body": "Ngân hàng TMCP Công thương Việt Nam",
      "asset": AssetsConst.vietinbank
    },
  ];
  static const List<Map<String, String>> paymentMethodList = [
    {"title": "Add New Card", "asset": AssetsConst.addRectangle},
    {"title": "Link Momo Wallet", "asset": AssetsConst.momo},
  ];
  static List<StationModel> listStation = [
    StationModel(
      stationId: 0,
      address:
          "68 Bach Dang Street Da Nang DAD, 68 Bạch Đằng, Hải Châu 1, Hải Châu, Đà Nẵng 550000, Vietnam",
      lat: 16.0706181,
      lng: 108.2240623,
      numBicycle: 5,
    ),
    StationModel(
      stationId: 1,
      address:
          "68 Bach Dang Street Da Nang DAD, 68 Bạch Đằng, Hải Châu 1, Hải Châu, Đà Nẵng 550000, Vietnam",
      lat: 16.0698183,
      lng: 108.223155,
      numBicycle: 4,
    ),
    StationModel(
      stationId: 2,
      address:
          "68 Bach Dang Street Da Nang DAD, 68 Bạch Đằng, Hải Châu 1, Hải Châu, Đà Nẵng 550000, Vietnam",
      lat: 16.0706952,
      lng: 108.221169,
      numBicycle: 3,
    ),
    StationModel(
      stationId: 3,
      address:
          "68 Bach Dang Street Da Nang DAD, 68 Bạch Đằng, Hải Châu 1, Hải Châu, Đà Nẵng 550000, Vietnam",
      lat: 16.0677079,
      lng: 108.224045,
      numBicycle: 10,
    ),
    StationModel(
      stationId: 4,
      address:
          "68 Bach Dang Street Da Nang DAD, 68 Bạch Đằng, Hải Châu 1, Hải Châu, Đà Nẵng 550000, Vietnam",
      lat: 16.0664569,
      lng: 108.2237714,
      numBicycle: 8,
    ),
    StationModel(
      stationId: 5,
      address:
          "68 Bach Dang Street Da Nang DAD, 68 Bạch Đằng, Hải Châu 1, Hải Châu, Đà Nẵng 550000, Vietnam",
      lat: 16.064702,
      lng: 108.2226695,
      numBicycle: 3,
    ),
    StationModel(
      stationId: 6,
      address:
          "68 Bach Dang Street Da Nang DAD, 68 Bạch Đằng, Hải Châu 1, Hải Châu, Đà Nẵng 550000, Vietnam",
      lat: 16.0624815,
      lng: 108.2189809,
      numBicycle: 2,
    ),
    StationModel(
      stationId: 7,
      address:
          "68 Bach Dang Street Da Nang DAD, 68 Bạch Đằng, Hải Châu 1, Hải Châu, Đà Nẵng 550000, Vietnam",
      lat: 16.0634036,
      lng: 108.2123245,
      numBicycle: 0,
    ),
    StationModel(
      stationId: 8,
      address:
          "68 Bach Dang Street Da Nang DAD, 68 Bạch Đằng, Hải Châu 1, Hải Châu, Đà Nẵng 550000, Vietnam",
      lat: 16.0626833,
      lng: 108.2170185,
      numBicycle: 1,
    ),
    StationModel(
      stationId: 9,
      address:
          "68 Bach Dang Street Da Nang DAD, 68 Bạch Đằng, Hải Châu 1, Hải Châu, Đà Nẵng 550000, Vietnam",
      lat: 16.0629839,
      lng: 108.2183471,
      numBicycle: 5,
    ),
    StationModel(
      stationId: 10,
      address:
          "68 Bach Dang Street Da Nang DAD, 68 Bạch Đằng, Hải Châu 1, Hải Châu, Đà Nẵng 550000, Vietnam",
      lat: 16.0635167,
      lng: 108.218908,
      numBicycle: 6,
    ),
    StationModel(
      stationId: 11,
      address:
          "68 Bach Dang Street Da Nang DAD, 68 Bạch Đằng, Hải Châu 1, Hải Châu, Đà Nẵng 550000, Vietnam",
      lat: 16.0519938,
      lng: 108.2153035,
      numBicycle: 9,
    ),
    StationModel(
      stationId: 12,
      address:
          "68 Bach Dang Street Da Nang DAD, 68 Bạch Đằng, Hải Châu 1, Hải Châu, Đà Nẵng 550000, Vietnam",
      lat: 16.0496056,
      lng: 108.2166593,
      numBicycle: 4,
    ),
    StationModel(
      stationId: 13,
      address:
          "68 Bach Dang Street Da Nang DAD, 68 Bạch Đằng, Hải Châu 1, Hải Châu, Đà Nẵng 550000, Vietnam",
      lat: 16.0491915,
      lng: 108.2166593,
      numBicycle: 3,
    ),
    StationModel(
      stationId: 14,
      address:
          "68 Bach Dang Street Da Nang DAD, 68 Bạch Đằng, Hải Châu 1, Hải Châu, Đà Nẵng 550000, Vietnam",
      lat: 16.0458067,
      lng: 108.2245943,
      numBicycle: 8,
    ),
    StationModel(
      stationId: 15,
      address:
          "68 Bach Dang Street Da Nang DAD, 68 Bạch Đằng, Hải Châu 1, Hải Châu, Đà Nẵng 550000, Vietnam",
      lat: 16.0596833,
      lng: 108.2206047,
      numBicycle: 12,
    ),
    StationModel(
      stationId: 16,
      address:
          "68 Bach Dang Street Da Nang DAD, 68 Bạch Đằng, Hải Châu 1, Hải Châu, Đà Nẵng 550000, Vietnam",
      lat: 16.0634127,
      lng: 108.220623,
      numBicycle: 11,
    ),
    StationModel(
      stationId: 17,
      address:
          "68 Bach Dang Street Da Nang DAD, 68 Bạch Đằng, Hải Châu 1, Hải Châu, Đà Nẵng 550000, Vietnam",
      lat: 16.0670269,
      lng: 108.2221158,
      numBicycle: 0,
    ),
    StationModel(
      stationId: 18,
      address:
          "68 Bach Dang Street Da Nang DAD, 68 Bạch Đằng, Hải Châu 1, Hải Châu, Đà Nẵng 550000, Vietnam",
      lat: 16.0738412,
      lng: 108.2198661,
      numBicycle: 7,
    ),
    StationModel(
      stationId: 19,
      address:
          "68 Bach Dang Street Da Nang DAD, 68 Bạch Đằng, Hải Châu 1, Hải Châu, Đà Nẵng 550000, Vietnam",
      lat: 16.0710357,
      lng: 108.2073285,
      numBicycle: 12,
    ),
    StationModel(
      stationId: 20,
      address:
          "68 Bach Dang Street Da Nang DAD, 68 Bạch Đằng, Hải Châu 1, Hải Châu, Đà Nẵng 550000, Vietnam",
      lat: 16.0703543,
      lng: 108.2065705,
      numBicycle: 8,
    ),
    StationModel(
      stationId: 21,
      address:
          "68 Bach Dang Street Da Nang DAD, 68 Bạch Đằng, Hải Châu 1, Hải Châu, Đà Nẵng 550000, Vietnam",
      lat: 16.0735029,
      lng: 108.2065705,
      numBicycle: 9,
    ),
    StationModel(
      stationId: 22,
      address:
          "68 Bach Dang Street Da Nang DAD, 68 Bạch Đằng, Hải Châu 1, Hải Châu, Đà Nẵng 550000, Vietnam",
      lat: 16.0601356,
      lng: 108.2026808,
      numBicycle: 4,
    ),
    StationModel(
      stationId: 23,
      address:
          "68 Bach Dang Street Da Nang DAD, 68 Bạch Đằng, Hải Châu 1, Hải Châu, Đà Nẵng 550000, Vietnam",
      lat: 16.0560421,
      lng: 108.2095102,
      numBicycle: 3,
    ),
    StationModel(
      stationId: 24,
      address:
          "68 Bach Dang Street Da Nang DAD, 68 Bạch Đằng, Hải Châu 1, Hải Châu, Đà Nẵng 550000, Vietnam",
      lat: 16.0450369,
      lng: 108.2102926,
      numBicycle: 8,
    ),
    StationModel(
      stationId: 25,
      address:
          "68 Bach Dang Street Da Nang DAD, 68 Bạch Đằng, Hải Châu 1, Hải Châu, Đà Nẵng 550000, Vietnam",
      lat: 16.0444259,
      lng: 108.2028589,
      numBicycle: 10,
    ),
    StationModel(
      stationId: 26,
      address:
          "68 Bach Dang Street Da Nang DAD, 68 Bạch Đằng, Hải Châu 1, Hải Châu, Đà Nẵng 550000, Vietnam",
      lat: 16.0357182,
      lng: 108.2106279,
      numBicycle: 11,
    ),
    StationModel(
      stationId: 27,
      address:
          "68 Bach Dang Street Da Nang DAD, 68 Bạch Đằng, Hải Châu 1, Hải Châu, Đà Nẵng 550000, Vietnam",
      lat: 16.0373926,
      lng: 108.2167411,
      numBicycle: 2,
    ),
    StationModel(
      stationId: 28,
      address:
          "68 Bach Dang Street Da Nang DAD, 68 Bạch Đằng, Hải Châu 1, Hải Châu, Đà Nẵng 550000, Vietnam",
      lat: 16.0315038,
      lng: 108.2201167,
      numBicycle: 5,
    ),
    StationModel(
      stationId: 29,
      address:
          "68 Bach Dang Street Da Nang DAD, 68 Bạch Đằng, Hải Châu 1, Hải Châu, Đà Nẵng 550000, Vietnam",
      lat: 16.0441403,
      lng: 108.2169488,
      numBicycle: 4,
    ),
  ];
}

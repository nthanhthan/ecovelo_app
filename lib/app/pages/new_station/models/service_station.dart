import 'package:ecoveloapp/app/core.dart';

class ServiceStationModel {
  ServiceItem? restaurant;
  ServiceItem? school;
  ServiceItem? busStation;
  ServiceItem? hotel;
  ServiceStationModel({
    this.busStation,
    this.hotel,
    this.restaurant,
    this.school,
  });
}

import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin, WidgetsBindingObserver {
  final RxInt _currentTab = 0.obs;
  set currentTab(int value) => _currentTab.value = value;
  int get currentTab => _currentTab.value;
  final PageStorageBucket bucket = PageStorageBucket();
  late LoginManager _loginManager;

  UserModel? userModel;

  List<Widget> screen = [
    const HomeScreen(),
    const MapView(),
    const NotificationView(),
    const SettingView(),
  ];

  Widget currentScreen = const HomeScreen();

  final RxnBool _isCloseBottomModel = RxnBool();
  set isCloseBottomModel(bool? value) => _isCloseBottomModel.value = value;
  bool? get isCloseBottomModel => _isCloseBottomModel.value;

  String bikeID = "";
  late DateTime startTime;
  late Timer timer;
  late Timer timerSendTrip;

  final RxInt _elapsedTimeInSeconds = 0.obs;
  set elapsedTimeInSeconds(int value) => _elapsedTimeInSeconds.value = value;
  int get elapsedTimeInSeconds => _elapsedTimeInSeconds.value;

  late final AuthHttpService _authHttpService;

  final RxBool _isLoading = false.obs;
  set isLoading(bool value) => _isLoading.value = value;
  bool get isLoading => _isLoading.value;

  Position? position;

  final RxList<StationModel> _listStation = <StationModel>[].obs;
  set listStation(List<StationModel> stationModel) =>
      _listStation.value = stationModel;
  // ignore: invalid_use_of_protected_member
  List<StationModel> get listStation => _listStation.value;

  late MapController mapController;

  late StationHttpService _stationHttpService;

  final RxBool _isLockTemporary = false.obs;
  bool get isLockTemporary => _isLockTemporary.value;
  set isLockTemporary(bool value) => _isLockTemporary.value = value;

  bool? isAdmin;

  LoginResp? _loginResp;

  @override
  void onInit() {
    isLoading = false;
    WidgetsBinding.instance.addObserver(this);
    _loginManager = Get.find<LoginManager>();
    _loginResp = _loginManager.getLogin();
    if (_loginResp != null) {
      isAdmin = _loginResp!.admin;
    } else {
      isAdmin = false;
    }
    _authHttpService = Get.find<AuthHttpService>();
    isLockTemporary = Prefs.getBool(AppKeys.lockTemporary);
    getUser().then((value) {
      if (value) {
        isLoading = true;
      }
    });
    String bicycleID = Prefs.getString(AppKeys.bicycleIDRent);
    if (bicycleID.isNotEmpty) {
      bikeID = bicycleID;
      getRent();
    }
    if (Get.arguments != null && Get.arguments is String) {
      bikeID = Get.arguments as String;
      Prefs.saveString(AppKeys.bicycleIDRent, bikeID);
      getRent();
    }
    mapController = Get.find<MapController>();
    super.onInit();
  }

  Future<bool> getUser() async {
    final result = await _authHttpService.getUser();
    if (result.isSuccess() && result.data != null) {
      _loginManager.saveUser(result.data);
    }
    userModel = _loginManager.getUser();
    Prefs.saveBool(AppKeys.isverify, userModel?.proccessing ?? false);
    return true;
  }

  void getRent() {
    String bicycleid = Prefs.getString(AppKeys.bicycleIDRent);
    MQTTClientWrapper().checkConnected(bicycleid);
    String beginTimer = Prefs.getString(AppKeys.beginRent);
    if (beginTimer.isNotEmpty) {
      startTime = DateTime.parse(beginTimer);
    } else {
      startTime = DateTime.now();
    }
    beginRent();
  }

  @override
  void onReady() {
    if (bikeID.isNotEmpty) {
      const HomeScreen().showBottomSheetRentBicycle(Get.context!);
    }
    super.onReady();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void dispose() {
    timer.cancel();
    timerSendTrip.cancel();
    super.dispose();
  }

  void beginRent() {
    Prefs.saveString(AppKeys.beginRent, startTime.toString());
    timerSendTrip = Timer.periodic(const Duration(seconds: 10), (timer) {
      int rentID = Prefs.getInt(AppKeys.rentID);
      rentID == 0 ? timerSendTrip.cancel() : _getCurrentLocation();
    });
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      elapsedTimeInSeconds = DateTime.now().difference(startTime).inSeconds;
    });
  }

  String caculateTimer() {
    bool isOverOneHour = elapsedTimeInSeconds >= 3600;
    String elapsedTimeText = isOverOneHour
        ? '${(elapsedTimeInSeconds / 3600).floor()}:${((elapsedTimeInSeconds / 60) % 60).floor().toString().padLeft(2, '0')}:${(elapsedTimeInSeconds % 60).toString().padLeft(2, '0')}'
        : '${(elapsedTimeInSeconds / 60).floor()}:${(elapsedTimeInSeconds % 60).toString().padLeft(2, '0')}';
    return elapsedTimeText;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      LogUtil.d('Home: on app ressume!');
    }
  }

  Widget getWidget() {
    return screen[currentTab];
  }

  void updateCloseBottomModel(bool value) {
    isCloseBottomModel = value;
  }

  bool checkCloseBottomModel() {
    if (isCloseBottomModel != null) {
      return isCloseBottomModel!;
    } else {
      return false;
    }
  }

  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Người dùng từ chối cho phép truy cập vị trí
        // Hiển thị thông báo yêu cầu quyền truy cập vị trí
      }
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      getMyPositionCurrent();
      // Xử lý dữ liệu vị trí
    }
  }

  Future<bool> getMyPositionCurrent() async {
    int rentID = Prefs.getInt(AppKeys.rentID);
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final result = await RentHttpService().sendTrip(
        position?.latitude.toString() ?? "0",
        position?.longitude.toString() ?? "0",
        rentID);
    if (result.isSuccess()) {}
    return true;
  }

  Future<void> getStationNear() async {
    _stationHttpService = Get.find<StationHttpService>();
    final result = await _stationHttpService.getListStation();
    listStation = [];
    if (result.isSuccess() && result.data != null) {
      listStation = result.data ?? [];
      if (listStation.isNotEmpty) {
        mapController.getMyPositionCurrent();
        Position? position = mapController.position;
        if (position != null) {
          listStation.sort(
            (a, b) {
              _listStation.refresh();
              double distanceToA = Geolocator.distanceBetween(position.latitude,
                  position.longitude, a.lat ?? 0, a.lng ?? 0);
              double distanceToB = Geolocator.distanceBetween(position.latitude,
                  position.longitude, b.lat ?? 0, b.lng ?? 0);
              a.distance = showDistance(distanceToA);
              b.distance = showDistance(distanceToB);
              return distanceToA.compareTo(distanceToB);
            },
          );
        }
      }
    }
  }

  String showDistance(double distance) {
    if (distance > 1000) {
      return "${distance.toInt() / 1000} km";
    }
    return "${distance.toInt()} m";
  }

  void stationNearMe(StationModel stationModel) {
    mapController.launchMapsUrl(stationModel.lat ?? 0, stationModel.lng ?? 0);
  }

  Future<void> openLockTemporary() async {
    String bicycleid = Prefs.getString(AppKeys.bicycleIDRent);
    MQTTClientWrapper().checkConnected(bicycleid);
    MQTTClientWrapper().showOpenLock(bicycleid);
  }
}

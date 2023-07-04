import 'dart:io';

import 'package:firebase_remote_config/firebase_remote_config.dart';

class ConfigPackacgeService {
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  final String? configIOS;
  final String? configAndroid;
  final String? adsIOS;
  final String? adsAndroid;
  ConfigPackacgeService({
    this.configIOS,
    this.configAndroid,
    this.adsIOS,
    this.adsAndroid,
  });

  Future<void> initializeConfigRemote() async {
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(seconds: 0),
      ),
    );
    await remoteConfig.fetchAndActivate();
  }

  String getRemoteConfig() {
    if (Platform.isAndroid) {
      return remoteConfig.getString(configAndroid ?? "");
    } else {
      return remoteConfig.getString(configIOS ?? "");
    }
  }

  String getAdsConfig() {
    if (Platform.isAndroid) {
      return remoteConfig.getString(adsAndroid ?? "");
    } else {
      return remoteConfig.getString(adsIOS ?? "");
    }
  }
}

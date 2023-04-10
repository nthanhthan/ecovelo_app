import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ecoveloapp/app/core.dart';



const _enviromentKey = "enviroment-key";

Future<EnvType?> _getEnvSaved() async {
  await Prefs.load();
  String envStrSaved = Prefs.getString(_enviromentKey);
  return EnumUtil.enumValueFromString<EnvType>(envStrSaved, EnvType.values);
}

///
///Load saved environment for testing with switch enviroment in runtime
///
Future<void> loadSavedEnviroment() async {
  if (BuildConfig().isEnableSwitchEnv) {
    EnvType? envSaved = await _getEnvSaved();
    if (envSaved != null) {
      BuildConfig().env = Env.fromType(envSaved);
    }
  }
}

void changeEnvironment() {
  if (BuildConfig().isEnableSwitchEnv) {
    Get.dialog<void>(
      BasePopup(
        title: const Text("App Environments"),
        body: SizedBox(
          height: Get.height * .45,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: const Text("Dev Environment"),
                    onTap: () {
                      Get.back<void>();
                      _changeEnvironment(Env.dev());
                    },
                    leading: const Icon(Icons.api_rounded),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    tileColor: BuildConfig().env is DevEnv
                        ? Theme.of(Get.context!).primaryColorLight
                        : Theme.of(Get.context!).dividerColor,
                  ),
                  const SizedBox(height: 8),
                  ListTile(
                    title: const Text("UAT Environment"),
                    onTap: () {
                      Get.back<void>();
                      _changeEnvironment(UATEnv());
                    },
                    leading: const Icon(Icons.api_rounded),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    tileColor: BuildConfig().env is UATEnv
                        ? Theme.of(Get.context!).primaryColorLight
                        : Theme.of(Get.context!).dividerColor,
                  ),
                  const SizedBox(height: 8),
                  ListTile(
                    title: const Text("Staging Environment"),
                    onTap: () {
                      Get.back<void>();
                      _changeEnvironment(StagingEnv());
                    },
                    leading: const Icon(Icons.api_rounded),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    tileColor: BuildConfig().env is StagingEnv
                        ? Theme.of(Get.context!).primaryColorLight
                        : Theme.of(Get.context!).dividerColor,
                  ),
                  const SizedBox(height: 8),
                  ListTile(
                    title: const Text("Production Environment"),
                    onTap: () {
                      Get.back<void>();
                      _changeEnvironment(ProductionEnv());
                    },
                    leading: const Icon(Icons.api_rounded),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    tileColor: BuildConfig().env is ProductionEnv
                        ? Theme.of(Get.context!).primaryColorLight
                        : Theme.of(Get.context!).dividerColor,
                  ),
                ],
              ),
            ),
          ),
        ),
        isSmallAlert: false,
        actions: [
          TextButton(
            onPressed: () async {
              Get.back<void>();
            },
            child: const Text("Done"),
          ),
        ],
      ),
    );
  }
}

void _changeEnvironment(Env env) async {
  BuildConfig().env = env;
  await Prefs.saveString(
      _enviromentKey, EnumUtil.enumValueToString(BuildConfig().env.buildType));
  if (Platform.isAndroid) {
    SystemNavigator.pop();
  } else {
    exit(0);
  }
}

void showAppVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  Connectivity connectivity = Connectivity();
  ConnectivityResult connectResult = await connectivity.checkConnectivity();
  Get.dialog<void>(
    BasePopup(
      title: const Text("App Information"),
      body: SizedBox(
        height: Get.height * .45,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLineInfo("App name: ", packageInfo.appName),
                _buildLineInfo("Version: ", packageInfo.version),
                _buildLineInfo("Build number: ", packageInfo.buildNumber),
                _buildLineInfo("Pack name: ", packageInfo.packageName),
                _buildLineInfo("Environment: ", BuildConfig().env.getInfo()),
                const Divider(),
                _buildLineInfo("Platform OS: ", (Platform.operatingSystem)),
                _buildLineInfo("Platform version: ", (Platform.version)),
                _buildLineInfo(
                    "OS verssion: ", (Platform.operatingSystemVersion)),
                const Divider(),
                _buildLineInfo("Date: ", DateUtil.getNowDateStr()),
                _buildLineInfo(
                    "Connectivity: ", connectResult.toString().split(".").last),
              ],
            ),
          ),
        ),
      ),
      isSmallAlert: false,
      actions: [
        TextButton(
          onPressed: () {
            _sendLogToDev();
            Get.back<void>();
          },
          child: const Text('Send Log'),
        ),
        TextButton(
          onPressed: () async {
            Get.back<void>();
          },
          child: const Text('Close'),
        ),
      ],
    ),
  );
}

Widget _buildLineInfo(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Text(label),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: AppColors.main),
          ),
        ),
      ],
    ),
  );
}

Future<void> _sendLogToDev() async {
  File? logFile = await LogUtil.exportAllLogs();
  if (logFile == null) return;
  String pathFinal = logFile.path;
  if (Platform.isAndroid) {
    Directory? dir = await getExternalStorageDirectory();
    String rootPath = dir?.absolute.path ?? "";
    String newFilePath = "$rootPath/${logFile.path.split('/').last}";

    File fileData = File(newFilePath);
    if (await fileData.exists()) {
      await fileData.delete();
    }
    File newF = await logFile.copy(newFilePath);
    pathFinal = newF.path;
  }
  final Email email = Email(
    body: "aichat: log file",
    subject: '"aichat: log file',
    recipients: ['luc.tran@megatron.vn'],
    attachmentPaths: [pathFinal],
    isHTML: false,
  );
  await FlutterEmailSender.send(email);
}

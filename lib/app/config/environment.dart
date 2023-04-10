import '../core.dart';

///
///Environment
///
abstract class Env {
  Env();
  abstract String baseApi;
  abstract String dbName;
  abstract String dbVersion;
  abstract EnvType buildType;

  factory Env.dev() => DevEnv();
  factory Env.uat() => UATEnv();
  factory Env.staging() => StagingEnv();
  factory Env.prod() => ProductionEnv();

  factory Env.fromType(EnvType type) {
    switch (type) {
      case EnvType.development:
        return Env.dev();
      case EnvType.uat:
        return Env.uat();

      case EnvType.staging:
        return Env.staging();
      case EnvType.production:
        return Env.prod();
    }
  }

  String getInfo() {
    String envStr = EnumUtil.enumValueToString(buildType);
    return "[$envStr] - API[$baseApi]";
  }
}

enum EnvType { development, uat, staging, production }

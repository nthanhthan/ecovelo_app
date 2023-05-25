import '../core.dart';

///Developnent environment
class DevEnv extends Env {
  DevEnv();

  @override
  //String baseApi = "http://192.168.1.4:8080/api/v1";
  String baseApi = "http://192.168.31.111:8080/api/v1";
  //String baseApi = "http://192.168.31.111:8080/api/v1";
  // String baseApi = "http://192.168.1.120:8080/api/v1";
  //String baseApi = "http://172.20.10.5:8080/api/v1";
  // String baseApi = "https://197b-171-251-22-194.ngrok-free.app/api/v1";

  @override
  EnvType buildType = EnvType.development;

  @override
  String dbName = "ecovelo-dev";

  @override
  String dbVersion = "1.2";
}

///User Acceptance Testing environment
class UATEnv extends Env {
  UATEnv();

  @override
  String baseApi = "http://localhost:8081/api/v1";

  @override
  EnvType buildType = EnvType.uat;

  @override
  String dbName = "ecovelo-uat";

  @override
  String dbVersion = "1.2";
}

///Staging environment
class StagingEnv extends Env {
  StagingEnv();

  @override
  String baseApi = "";

  @override
  EnvType buildType = EnvType.staging;

  @override
  String dbName = "ecovelo-staging";

  @override
  String dbVersion = "1.2";
}

///Production environment
class ProductionEnv extends Env {
  ProductionEnv();

  @override
  String baseApi = "http://127.0.0.1:8080/api/v1";

  @override
  EnvType buildType = EnvType.production;

  @override
  String dbName = "ecovelo-prod";

  @override
  String dbVersion = "1.2";
}

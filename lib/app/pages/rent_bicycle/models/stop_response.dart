class StopResponse {
  int? idRent;
  int? numFall;
  StopResponse({this.idRent, this.numFall});
  factory StopResponse.fromJson(Map<String, dynamic> json) {
    return StopResponse(
      idRent: json['idRent'] as int?,
      numFall: json['numFall'] as int?,
    );
  }
}

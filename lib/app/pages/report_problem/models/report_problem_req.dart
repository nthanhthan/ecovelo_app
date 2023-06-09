import 'package:json_annotation/json_annotation.dart';
part 'report_problem_req.g.dart';

@JsonSerializable()
class ReportProblemReq {
  String? description;
  String? idBicycle;
  String? urlImage;
  int? idProblem;
  String? token;
  ReportProblemReq({
    this.description,
    this.idBicycle,
    this.idProblem,
    this.token,
    this.urlImage,
  });
  factory ReportProblemReq.fromJson(Map<String, dynamic> json) =>
      _$ReportProblemReqFromJson(json);

  Map<String, dynamic> toJson() => _$ReportProblemReqToJson(this);
}

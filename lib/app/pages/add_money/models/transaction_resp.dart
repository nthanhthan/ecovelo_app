import 'package:json_annotation/json_annotation.dart';
part 'transaction_resp.g.dart';

@JsonSerializable()
class TransactionResp {
  int? id;
  double? point;
  int? dateTimeTransaction;
  TransactionResp({
    this.id,
    this.point,
    this.dateTimeTransaction,
  });
  factory TransactionResp.fromJson(Map<String, dynamic> json) =>
      _$TransactionRespFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionRespToJson(this);
}

import 'package:json_annotation/json_annotation.dart';
part 'transaction_req.g.dart';

@JsonSerializable()
class TransactionReq {
  int? money;
  String? titleTransaction;
  bool? isMainPoint;
  bool? isStatus;
  TransactionReq({
    this.money,
    this.titleTransaction,
    this.isMainPoint,
    this.isStatus,
  });

  factory TransactionReq.fromJson(Map<String, dynamic> json) =>
      _$TransactionReqFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionReqToJson(this);
}

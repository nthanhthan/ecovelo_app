class FeedbackRequest {
  int? idRent;
  String? comment;
  String? reasonFall;
  int? numStar;
  FeedbackRequest({
    this.comment,
    this.idRent,
    this.numStar,
    this.reasonFall,
  });
  Map<String, dynamic> toJson() {
    return {
      "idRent": idRent,
      "comment": comment,
      "reasonFall": reasonFall,
      "numStar": numStar,
    };
  }
}

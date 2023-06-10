class VerifyReq {
  String? urlFront;
  String? urlBack;
  int? idLegal;
  String? token;
  VerifyReq({
    this.urlFront,
    this.urlBack,
    this.idLegal,
    this.token,
  });
  Map<String, dynamic> toJson() {
    return {
      "urlFront": urlFront,
      "urlBack": urlBack,
      "idLegal": idLegal,
      "token": token
    };
  }
}

class postAnswerReq {
  int? userId;
  int? questionsId;
  int? clickUserId;
  String? comment;

  postAnswerReq(
      {this.userId, this.questionsId, this.clickUserId, this.comment});

  postAnswerReq.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    questionsId = json['questions_id'];
    clickUserId = json['click_user_id'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['questions_id'] = this.questionsId;
    data['click_user_id'] = this.clickUserId;
    data['comment'] = this.comment;
    return data;
  }
}

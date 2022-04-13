class PostQuesLikeReq {
  int? userId;
  int? questionsId;
  int? clickUserId;

  PostQuesLikeReq({this.userId, this.questionsId, this.clickUserId});

  PostQuesLikeReq.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    questionsId = json['questions_id'];
    clickUserId = json['click_user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['questions_id'] = this.questionsId;
    data['click_user_id'] = this.clickUserId;
    return data;
  }
}

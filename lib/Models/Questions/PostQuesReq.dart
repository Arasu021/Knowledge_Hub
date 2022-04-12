class PostQuesReq {
  String? questionSummary;
  String? questionImage;
  String? interests;
  int? userId;

  PostQuesReq(
      {this.questionSummary, this.questionImage, this.interests, this.userId});

  PostQuesReq.fromJson(Map<String, dynamic> json) {
    questionSummary = json['question_summary'];
    questionImage = json['question_image'];
    interests = json['interests'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question_summary'] = this.questionSummary;
    data['question_image'] = this.questionImage;
    data['interests'] = this.interests;
    data['user_id'] = this.userId;
    return data;
  }
}

class PostQuesReq2 {
  String? questionSummary;
  String? interests;
  int? userId;

  PostQuesReq2({this.questionSummary, this.interests, this.userId});

  PostQuesReq2.fromJson(Map<String, dynamic> json) {
    questionSummary = json['question_summary'];
    interests = json['interests'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question_summary'] = this.questionSummary;
    data['interests'] = this.interests;
    data['user_id'] = this.userId;
    return data;
  }
}

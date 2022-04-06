class GetQuesRes {
  bool? status;
  String? message;
  List<GetQuesData>? data;

  GetQuesRes({this.status, this.message, this.data});

  GetQuesRes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetQuesData>[];
      json['data'].forEach((v) {
        data!.add(new GetQuesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetQuesData {
  int? questionId;
  String? questionSummary;
  Null? questionImage;
  String? interests;
  int? userId;
  int? questionViews;
  String? createdAt;
  String? updatedAt;
  int? questionLikes;
  int? questionComments;

  GetQuesData(
      {this.questionId,
      this.questionSummary,
      this.questionImage,
      this.interests,
      this.userId,
      this.questionViews,
      this.createdAt,
      this.updatedAt,
      this.questionLikes,
      this.questionComments});

  GetQuesData.fromJson(Map<String, dynamic> json) {
    questionId = json['question_id'];
    questionSummary = json['question_summary'];
    questionImage = json['question_image'];
    interests = json['interests'];
    userId = json['user_id'];
    questionViews = json['question_views'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    questionLikes = json['question_likes'];
    questionComments = json['question_comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question_id'] = this.questionId;
    data['question_summary'] = this.questionSummary;
    data['question_image'] = this.questionImage;
    data['interests'] = this.interests;
    data['user_id'] = this.userId;
    data['question_views'] = this.questionViews;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['question_likes'] = this.questionLikes;
    data['question_comments'] = this.questionComments;
    return data;
  }
}

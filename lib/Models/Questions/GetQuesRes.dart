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
  String? questionImage;
  String? interests;
  int? userId;
  int? questionViews;
  String? createdAt;
  String? updatedAt;
  String? fullName;
  String? designation;
  String? workExperience;
  String? email;
  String? mobileNo;
  String? profilePicture;
  String? fcmToken;
  int? questionLikes;
  int? questionComments;
  int? likedUser;

  GetQuesData(
      {this.questionId,
      this.questionSummary,
      this.questionImage,
      this.interests,
      this.userId,
      this.questionViews,
      this.createdAt,
      this.updatedAt,
      this.fullName,
      this.designation,
      this.workExperience,
      this.email,
      this.mobileNo,
      this.profilePicture,
      this.fcmToken,
      this.questionLikes,
      this.questionComments,
      this.likedUser});

  GetQuesData.fromJson(Map<String, dynamic> json) {
    questionId = json['question_id'];
    questionSummary = json['question_summary'];
    questionImage = json['question_image'];
    interests = json['interests'];
    userId = json['user_id'];
    questionViews = json['question_views'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fullName = json['full_name'];
    designation = json['designation'];
    workExperience = json['work_experience'];
    email = json['email'];
    mobileNo = json['mobile_no'];
    profilePicture = json['profile_picture'];
    fcmToken = json['fcm_token'];
    questionLikes = json['question_likes'];
    questionComments = json['question_comments'];
    likedUser = json['liked_user'];
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
    data['full_name'] = this.fullName;
    data['designation'] = this.designation;
    data['work_experience'] = this.workExperience;
    data['email'] = this.email;
    data['mobile_no'] = this.mobileNo;
    data['profile_picture'] = this.profilePicture;
    data['fcm_token'] = this.fcmToken;
    data['question_likes'] = this.questionLikes;
    data['question_comments'] = this.questionComments;
    data['liked_user'] = this.likedUser;
    return data;
  }
}

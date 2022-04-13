class GetQuesLikedRes {
  bool? status;
  String? message;
  List<GetQuesLikeData>? data;

  GetQuesLikedRes({this.status, this.message, this.data});

  GetQuesLikedRes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetQuesLikeData>[];
      json['data'].forEach((v) {
        data!.add(new GetQuesLikeData.fromJson(v));
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

class GetQuesLikeData {
  int? questionsLikeId;
  int? userId;
  int? questionsId;
  int? clickUserId;
  String? createdAt;
  String? updatedAt;
  String? fullName;
  String? designation;
  String? workExperience;
  String? interests;
  String? email;
  String? mobileNo;
  String? profilePicture;
  String? fcmToken;

  GetQuesLikeData(
      {this.questionsLikeId,
      this.userId,
      this.questionsId,
      this.clickUserId,
      this.createdAt,
      this.updatedAt,
      this.fullName,
      this.designation,
      this.workExperience,
      this.interests,
      this.email,
      this.mobileNo,
      this.profilePicture,
      this.fcmToken});

  GetQuesLikeData.fromJson(Map<String, dynamic> json) {
    questionsLikeId = json['questions_like_id'];
    userId = json['user_id'];
    questionsId = json['questions_id'];
    clickUserId = json['click_user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fullName = json['full_name'];
    designation = json['designation'];
    workExperience = json['work_experience'];
    interests = json['interests'];
    email = json['email'];
    mobileNo = json['mobile_no'];
    profilePicture = json['profile_picture'];
    fcmToken = json['fcm_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questions_like_id'] = this.questionsLikeId;
    data['user_id'] = this.userId;
    data['questions_id'] = this.questionsId;
    data['click_user_id'] = this.clickUserId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['full_name'] = this.fullName;
    data['designation'] = this.designation;
    data['work_experience'] = this.workExperience;
    data['interests'] = this.interests;
    data['email'] = this.email;
    data['mobile_no'] = this.mobileNo;
    data['profile_picture'] = this.profilePicture;
    data['fcm_token'] = this.fcmToken;
    return data;
  }
}

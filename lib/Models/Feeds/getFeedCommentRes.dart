class getFeedCommentRes {
  bool? status;
  String? message;
  List<GetFeedComData>? data;

  getFeedCommentRes({this.status, this.message, this.data});

  getFeedCommentRes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetFeedComData>[];
      json['data'].forEach((v) {
        data!.add(new GetFeedComData.fromJson(v));
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

class GetFeedComData {
  int? feedCommentId;
  int? userId;
  int? feedId;
  int? clickUserId;
  String? comment;
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

  GetFeedComData(
      {this.feedCommentId,
      this.userId,
      this.feedId,
      this.clickUserId,
      this.comment,
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

  GetFeedComData.fromJson(Map<String, dynamic> json) {
    feedCommentId = json['feed_comment_id'];
    userId = json['user_id'];
    feedId = json['feed_id'];
    clickUserId = json['click_user_id'];
    comment = json['comment'];
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
    data['feed_comment_id'] = this.feedCommentId;
    data['user_id'] = this.userId;
    data['feed_id'] = this.feedId;
    data['click_user_id'] = this.clickUserId;
    data['comment'] = this.comment;
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

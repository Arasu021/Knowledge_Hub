class GetLikedUsersRes {
  bool? status;
  String? message;
  List<GetFeedLikeData>? data;

  GetLikedUsersRes({this.status, this.message, this.data});

  GetLikedUsersRes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetFeedLikeData>[];
      json['data'].forEach((v) {
        data!.add(new GetFeedLikeData.fromJson(v));
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

class GetFeedLikeData {
  int? feedLikeId;
  int? userId;
  int? feedId;
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

  GetFeedLikeData(
      {this.feedLikeId,
      this.userId,
      this.feedId,
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

  GetFeedLikeData.fromJson(Map<String, dynamic> json) {
    feedLikeId = json['feed_like_id'];
    userId = json['user_id'];
    feedId = json['feed_id'];
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
    data['feed_like_id'] = this.feedLikeId;
    data['user_id'] = this.userId;
    data['feed_id'] = this.feedId;
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

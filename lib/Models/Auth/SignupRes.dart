class SignupRes {
  bool? status;
  String? message;
  Data? data;
  String? token;

  SignupRes({this.status, this.message, this.data, this.token});

  SignupRes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class Data {
  int? userId;
  String? fullName;
  String? designation;
  String? workExperience;
  String? email;
  String? mobileNo;
  String? fcmToken;

  Data(
      {this.userId,
      this.fullName,
      this.designation,
      this.workExperience,
      this.email,
      this.mobileNo,
      this.fcmToken});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    fullName = json['full_name'];
    designation = json['designation'];
    workExperience = json['work_experience'];
    email = json['email'];
    mobileNo = json['mobile_no'];
    fcmToken = json['fcm_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['full_name'] = this.fullName;
    data['designation'] = this.designation;
    data['work_experience'] = this.workExperience;
    data['email'] = this.email;
    data['mobile_no'] = this.mobileNo;
    data['fcm_token'] = this.fcmToken;
    return data;
  }
}

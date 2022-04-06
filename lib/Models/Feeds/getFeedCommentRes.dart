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

  GetFeedComData(
      {this.feedCommentId,
      this.userId,
      this.feedId,
      this.clickUserId,
      this.comment,
      this.createdAt,
      this.updatedAt});

  GetFeedComData.fromJson(Map<String, dynamic> json) {
    feedCommentId = json['feed_comment_id'];
    userId = json['user_id'];
    feedId = json['feed_id'];
    clickUserId = json['click_user_id'];
    comment = json['comment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    return data;
  }
}

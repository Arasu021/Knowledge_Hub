class PostFeedCommentReq {
  int? userId;
  int? feedId;
  int? clickUserId;
  String? comment;

  PostFeedCommentReq(
      {this.userId, this.feedId, this.clickUserId, this.comment});

  PostFeedCommentReq.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    feedId = json['feed_id'];
    clickUserId = json['click_user_id'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['feed_id'] = this.feedId;
    data['click_user_id'] = this.clickUserId;
    data['comment'] = this.comment;
    return data;
  }
}

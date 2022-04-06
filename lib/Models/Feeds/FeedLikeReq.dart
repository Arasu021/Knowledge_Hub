class FeedLikeReq {
  int? userId;
  int? feedId;
  int? clickUserId;

  FeedLikeReq({this.userId, this.feedId, this.clickUserId});

  FeedLikeReq.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    feedId = json['feed_id'];
    clickUserId = json['click_user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['feed_id'] = this.feedId;
    data['click_user_id'] = this.clickUserId;
    return data;
  }
}

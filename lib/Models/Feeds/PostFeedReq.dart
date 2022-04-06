class PostFeedReq {
  int? userId;
  String? feedSummary;
  String? feedImage;
  String? interests;

  PostFeedReq({this.userId, this.feedSummary, this.feedImage, this.interests});

  PostFeedReq.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    feedSummary = json['feed_summary'];
    feedImage = json['feed_image'];
    interests = json['interests'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['feed_summary'] = this.feedSummary;
    data['feed_image'] = this.feedImage;
    data['interests'] = this.interests;
    return data;
  }
}

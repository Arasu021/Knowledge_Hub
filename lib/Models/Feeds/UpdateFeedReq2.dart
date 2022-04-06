class UpdateFeedReq2 {
  String? userId;
  String? feedSummary;
  String? interests;

  UpdateFeedReq2({this.userId, this.feedSummary, this.interests});

  UpdateFeedReq2.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    feedSummary = json['feed_summary'];
    interests = json['interests'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['feed_summary'] = this.feedSummary;
    data['interests'] = this.interests;
    return data;
  }
}

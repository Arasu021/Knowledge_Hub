class GetFeedRes {
  bool? status;
  String? message;
  List<FeedsDatum>? data;

  GetFeedRes({this.status, this.message, this.data});

  GetFeedRes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <FeedsDatum>[];
      json['data'].forEach((v) {
        data!.add(new FeedsDatum.fromJson(v));
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

class FeedsDatum {
  int? feedId;
  String? feedSummary;
  String? feedImage;
  String? interests;
  int? userId;
  String? createdAt;
  String? updatedAt;
  int? feedLikes;
  int? feedComments;

  FeedsDatum(
      {this.feedId,
      this.feedSummary,
      this.feedImage,
      this.interests,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.feedLikes,
      this.feedComments});

  FeedsDatum.fromJson(Map<String, dynamic> json) {
    feedId = json['feed_id'];
    feedSummary = json['feed_summary'];
    feedImage = json['feed_image'];
    interests = json['interests'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    feedLikes = json['feed_likes'];
    feedComments = json['feed_comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['feed_id'] = this.feedId;
    data['feed_summary'] = this.feedSummary;
    data['feed_image'] = this.feedImage;
    data['interests'] = this.interests;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['feed_likes'] = this.feedLikes;
    data['feed_comments'] = this.feedComments;
    return data;
  }
}

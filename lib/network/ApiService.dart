import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:retrofit/retrofit.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:skein_community/Models/Auth/GetUserRes.dart';
import 'package:skein_community/Models/Auth/LoginReq.dart';
import 'package:skein_community/Models/Auth/LoginRes.dart';
import 'package:skein_community/Models/Auth/SignupReq.dart';
import 'package:skein_community/Models/Auth/SignupRes.dart';
import 'package:skein_community/Models/Auth/UpdateUserReq1.dart';
import 'package:skein_community/Models/Auth/UpdateUserReq2.dart';
import 'package:skein_community/Models/Auth/UpdateUserRes.dart';
import 'package:skein_community/Models/Feeds/FeedLikeReq.dart';
import 'package:skein_community/Models/Feeds/GetAllFeedRes.dart';
import 'package:skein_community/Models/Feeds/GetFeedRes.dart';
import 'package:skein_community/Models/Feeds/GetLikeUsersRes.dart';
import 'package:skein_community/Models/Feeds/PostFeedReq.dart';
import 'package:skein_community/Models/Feeds/PostFeedReq2.dart';
import 'package:skein_community/Models/Feeds/PostFeedRes.dart';
import 'package:skein_community/Models/Feeds/UpdateFeedReq.dart';
import 'package:skein_community/Models/Feeds/UpdateFeedReq2.dart';
import 'package:skein_community/Models/Feeds/UpdateFeedRes.dart';
import 'package:skein_community/Models/Feeds/getFeedCommentRes.dart';
import 'package:skein_community/Models/Feeds/postAnswerReq.dart';
import 'package:skein_community/Models/Feeds/postFeedCommentReq.dart';
import 'package:skein_community/Models/Feeds/postFeedCommentRes.dart';
import 'package:skein_community/Models/Questions/GetQuesAnswerRes.dart';
import 'package:skein_community/Models/Questions/GetQuesRes.dart';
import 'package:skein_community/Models/Questions/PostQuesReq.dart';
import 'package:skein_community/Models/Questions/PostQuesReq2.dart';
import 'package:skein_community/Utilities/strings.dart';

part 'ApiService.g.dart';

// Run this code in termial to generate ApiService.g.dart file
//flutter packages pub run build_runner watch --delete-conflicting-outputs
// certificatecheck() {
//   (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
//       (HttpClient client) {
//     client.badCertificateCallback =
//         (X509Certificate cert, String host, int port) => true;
//     return client;
//   };
// }

//   certificatecheck();

@RestApi(baseUrl: 'https://demo.emeetify.com:81/knowledgehub/')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

//////////////////////////////////////////////////////////////////////////////////////////
  /// Login and Signup Module
//////////////////////////////////////////////////////////////////////////////////////////

  @POST("users/login")
  Future<LoginRes> login(@Body() LoginReq body);

  @POST("users/register")
  @MultiPart()
  Future<SignupRes> userRegister(@Body() SignupReq body);

  @PUT("users/updateUser?user_id={user_id}")
  Future<UpdateUserRees> updateUser(
      @Path("user_id") int id, @Body() UpdateUserReq body);

  @PUT("users/updateUser?user_id={user_id}")
  Future<UpdateUserRees> updateUser2(
      @Path("user_id") int id, @Body() UpdateUserReq2 body);

  @GET("users/getuser?user_id={user_id}")
  Future<GetUserRes> getUser(@Path("user_id") int id);

  @GET("feeds/getfeed?interests={interests}&&page_no={page_no}")
  Future<GetFeedRes> getFeed(
      @Path("interests") String interests, @Path("page_no") int page);

  // @GET("feeds/getfeed?feed_id={feed_id}")
  // Future<GetFeedRes> getFeedById(@Path("feed_id") int feed_id);

  @GET("feeds/getallfeed")
  Future<GetAllFeedRes> getAllFeed();

  @POST("feeds/addfeed")
  @MultiPart()
  Future<PostFeedRes> postFeed(@Body() PostFeedReq body);

  @POST("feeds/addfeed")
  @MultiPart()
  Future<PostFeedRes> postFeed2(@Body() PostFeedReq2 body);

  @PUT("feeds/updatefeed?feed_id={feed_id}")
  Future<UpdateFeedRes> UpdateFeed(@Body() UpdateFeedReq body);

  @PUT("feeds/updatefeed?feed_id={feed_id}")
  Future<UpdateFeedRes> UpdateFeed2(@Body() UpdateFeedReq2 body);

  @POST("feeds/addfeedlike")
  Future<PostFeedRes> AddFeedLike(@Body() FeedLikeReq body);

  @GET("feeds/getFeedLike?feed_id={feed_id}")
  Future<GetLikedUsersRes> getFeedLike(@Path("feed_id") int feed_id);

  @DELETE("feeds/deletefeedlike?feed_id={feed_id}&&user_id={user_id}")
  Future<PostFeedRes> RemoveFeedLike(
      @Path("feed_id") int feed_id, @Path("user_id") int user_id);

  @GET("comments/getcomment?feed_id={feed_id}")
  Future<getFeedCommentRes> getFeedComment(@Path("feed_id") int feed_id);

  @POST("comments/addcomments")
  Future<PostFeedCommentRes> postFeedComment(@Body() PostFeedCommentReq body);

  @DELETE("comments/deletecomments?feed_comment_id={feed_comment_id}")
  Future<PostFeedRes> RemoveFeedComment(
      @Path("feed_comment_id") String feed_comment_id);

  @GET("questions/getquestion?interests={interests}")
  Future<GetQuesRes> getQuest(@Path("interests") String interests);

  @GET("questions/getquestion?question_id={question_id}")
  Future<GetQuesRes> getQuestId(@Path("question_id") int question_id);

  @POST("questions/addquestion")
  @MultiPart()
  Future<PostFeedRes> postQuest(@Body() PostQuesReq body);

  @POST("questions/addquestion")
  @MultiPart()
  Future<PostFeedRes> postQuest2(@Body() PostQuesReq2 body);

  @PUT("feeds/updatefeed?feed_id={feed_id}")
  Future<UpdateFeedRes> UpdateQuest(@Body() UpdateFeedReq body);

  @PUT("feeds/updatefeed?feed_id={feed_id}")
  Future<UpdateFeedRes> UpdateQuest2(@Body() UpdateFeedReq2 body);

  @POST("feeds/addfeedlike")
  Future<PostFeedRes> AddQuestLike(@Body() FeedLikeReq body);

  @DELETE("feeds/deletefeedlike?feed_like_id=3")
  Future<PostFeedRes> RemoveQuestLike();

  @GET("/comments/getcomment?feed_id={feed_id}")
  Future<getFeedCommentRes> getReplyQuesComment(
      @Path("feed_id") String feed_id);

  @POST("comments/addcomments")
  Future<PostFeedCommentRes> postReplyQuesComment(
      @Body() PostFeedCommentReq body);

  @GET("comments/getanswer?questions_id={questions_id}")
  Future<GetAnswerRes> getQuesAnswer(@Path("questions_id") int questions_id);

  @POST("comments/addanswer")
  Future<PostFeedCommentRes> postQuesAnswer(@Body() postAnswerReq body);
  //////////////////////////////////////////////////////////////////////////////////////////
  /// Request and Response Body
//////////////////////////////////////////////////////////////////////////////////////////

  static ApiService create() {
    final dio = Dio();
    try {
      dio.interceptors.add(PrettyDioLogger());
      dio.interceptors.add(InterceptorsWrapper(
          onRequest: (RequestOptions options, handler) async {
        options.headers["Content-Type"] = "application/json";
        options.headers["x-access-token"] = Strings.authToken;
        options.followRedirects = false;
        options.validateStatus = (status) {
          return status! < 500;
        };
        //return options;
        return handler.next(options);
      }));
      return ApiService(dio);
    } on DioError catch (error) {
      print("DioError");
      print(error);
      print(error.error);
      return ApiService(dio);
    }
  }
}

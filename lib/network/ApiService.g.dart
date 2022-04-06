// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ApiService.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _ApiService implements ApiService {
  _ApiService(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://demo.emeetify.com:81/knowledgehub/';
  }

  final Dio _dio;
  certificatecheck() {
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  String? baseUrl;

  @override
  Future<LoginRes> login(body) async {
    certificatecheck();
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<LoginRes>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'users/login',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LoginRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SignupRes> userRegister(body) async {
    certificatecheck();
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SignupRes>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'multipart/form-data')
            .compose(_dio.options, 'users/register',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SignupRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SignupRes> updateUser(id, body) async {
    certificatecheck();
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SignupRes>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'users/updateUser?user_id=${id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SignupRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SignupRes> updateUser2(id, body) async {
    certificatecheck();
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SignupRes>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'users/updateUser?user_id=${id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SignupRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetUserRes> getUser(id) async {
    certificatecheck();
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetUserRes>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'users/getuser?user_id=${id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetUserRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetFeedRes> getFeed(interests) async {
    certificatecheck();
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetFeedRes>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'feeds/getfeed?interests=${interests}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetFeedRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetAllFeedRes> getAllFeed() async {
    certificatecheck();
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetAllFeedRes>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'feeds/getallfeed',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetAllFeedRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PostFeedRes> postFeed(body) async {
    certificatecheck();
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PostFeedRes>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'multipart/form-data')
            .compose(_dio.options, 'feeds/addfeed',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PostFeedRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PostFeedRes> postFeed2(body) async {
    certificatecheck();
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PostFeedRes>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'multipart/form-data')
            .compose(_dio.options, 'feeds/addfeed',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PostFeedRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UpdateFeedRes> UpdateFeed(body) async {
    certificatecheck();
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UpdateFeedRes>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, 'feeds/updatefeed?feed_id={feed_id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UpdateFeedRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UpdateFeedRes> UpdateFeed2(body) async {
    certificatecheck();
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UpdateFeedRes>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, 'feeds/updatefeed?feed_id={feed_id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UpdateFeedRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PostFeedRes> AddFeedLike(body) async {
    certificatecheck();
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PostFeedRes>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'feeds/addfeedlike',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PostFeedRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetLikedUsersRes> getFeedLike(feed_id) async {
    certificatecheck();
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetLikedUsersRes>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'feeds/getFeedLike?feed_id=${feed_id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetLikedUsersRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PostFeedRes> RemoveFeedLike() async {
    certificatecheck();
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PostFeedRes>(
            Options(method: 'DELETE', headers: _headers, extra: _extra)
                .compose(_dio.options, 'feeds/deletefeedlike?feed_like_id=3',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PostFeedRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<getFeedCommentRes> getFeedComment(feed_id) async {
    certificatecheck();
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<getFeedCommentRes>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'comments/getcomment?feed_id=${feed_id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = getFeedCommentRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PostFeedCommentRes> postFeedComment(body) async {
    certificatecheck();
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PostFeedCommentRes>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'comments/addcomments',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PostFeedCommentRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PostFeedRes> RemoveFeedComment(feed_comment_id) async {
    certificatecheck();
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PostFeedRes>(Options(
                method: 'DELETE', headers: _headers, extra: _extra)
            .compose(_dio.options,
                'comments/deletecomments?feed_comment_id=${feed_comment_id}',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PostFeedRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetQuesRes> getQuest(interests) async {
    certificatecheck();
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetQuesRes>(Options(
                method: 'GET', headers: _headers, extra: _extra)
            .compose(
                _dio.options, 'questions/getquestion?interests=${interests}',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetQuesRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetQuesRes> getAllQuest() async {
    certificatecheck();
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetQuesRes>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'feeds/getallfeed',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetQuesRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PostFeedRes> postQuest(body) async {
    certificatecheck();
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PostFeedRes>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'multipart/form-data')
            .compose(_dio.options, 'feeds/addfeed',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PostFeedRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PostFeedRes> postQuest2(body) async {
    certificatecheck();
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PostFeedRes>(Options(
                method: 'POST',
                headers: _headers,
                extra: _extra,
                contentType: 'multipart/form-data')
            .compose(_dio.options, 'feeds/addfeed',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PostFeedRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UpdateFeedRes> UpdateQuest(body) async {
    certificatecheck();
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UpdateFeedRes>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, 'feeds/updatefeed?feed_id={feed_id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UpdateFeedRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UpdateFeedRes> UpdateQuest2(body) async {
    certificatecheck();
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UpdateFeedRes>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, 'feeds/updatefeed?feed_id={feed_id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UpdateFeedRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PostFeedRes> AddQuestLike(body) async {
    certificatecheck();
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PostFeedRes>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'feeds/addfeedlike',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PostFeedRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PostFeedRes> RemoveQuestLike() async {
    certificatecheck();
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PostFeedRes>(
            Options(method: 'DELETE', headers: _headers, extra: _extra)
                .compose(_dio.options, 'feeds/deletefeedlike?feed_like_id=3',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PostFeedRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<getFeedCommentRes> getReplyQuesComment(feed_id) async {
    certificatecheck();
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<getFeedCommentRes>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(
                    _dio.options, '/comments/getcomment?feed_id=${feed_id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = getFeedCommentRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PostFeedCommentRes> postReplyQuesComment(body) async {
    certificatecheck();
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PostFeedCommentRes>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'comments/addcomments',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PostFeedCommentRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<getFeedCommentRes> getQuesAnswer(feed_id) async {
    certificatecheck();
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<getFeedCommentRes>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(
                    _dio.options, 'comments/getanswer?questions_id=${feed_id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = getFeedCommentRes.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PostFeedCommentRes> postQuesAnswer(body) async {
    certificatecheck();
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PostFeedCommentRes>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'comments/addanswer',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PostFeedCommentRes.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}

import 'dart:convert';

import 'package:TLBK/models/api_response.dart';
import 'package:TLBK/models/post.dart';
import 'package:http/http.dart' as http;

import '../constant.dart';

// get all posts
Future<ApiResponse> getPosts(String nextPageToken) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String url = postsURL;
    if(nextPageToken != null && nextPageToken != ''){
      url = url + '&pageToken=$nextPageToken';
    }

    final response = await http.get(Uri.parse(url));

    switch(response.statusCode){
      case 200:
        apiResponse.data = jsonDecode(response.body)['items'].map((p) => Post.fromJson(p)).toList();
        apiResponse.data as List<dynamic>;
        apiResponse.nextPageToken = jsonDecode(response.body)['nextPageToken'];
        break;

      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e){
    apiResponse.error = serverError;
  }

  return apiResponse;
}


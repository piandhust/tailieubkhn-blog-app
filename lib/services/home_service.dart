import 'dart:convert';

import 'package:TLBK/models/api_response.dart';
import 'package:TLBK/models/blog_info.dart';
import 'package:http/http.dart' as http;

import '../constant.dart';

// get all posts
Future<ApiResponse> getBlogInfo() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.get(Uri.parse(blogInfoURL));

    switch(response.statusCode){
      case 200:
        apiResponse.data = BlogInfo.fromJson(jsonDecode(response.body));
        apiResponse.data as BlogInfo;
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
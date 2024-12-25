import 'package:TLBK/models/api_response.dart';
import 'package:TLBK/models/blog_info.dart';
import 'package:TLBK/screens/post_screen.dart';
import 'package:TLBK/services/home_service.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  BlogInfo blogInfo = new BlogInfo();

  // get all info
  Future<void> retrieveInfo() async {
    ApiResponse response = await getBlogInfo();

    if(response.error == null){
      setState(() {
        blogInfo = response.data as BlogInfo;
      });
    }
  }

  @override
  void initState() {
    blogInfo.name = '';
    retrieveInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${blogInfo.name}'),
      ),
      body: PostScreen()
    );
  }
}
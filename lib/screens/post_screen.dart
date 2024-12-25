import 'package:TLBK/models/api_response.dart';
import 'package:TLBK/models/post.dart';
import 'package:TLBK/services/post_service.dart';
import 'package:flutter/material.dart';
import 'post_detail.dart';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late ScrollController _scrollController;
  List<dynamic> _postList = [];
  int userId = 0;
  bool isLoadingMore = false;
  bool _loading = true;
  String nextPageToken = '';

  // get all posts
  Future<void> retrievePosts() async {
    ApiResponse response = await getPosts(nextPageToken);

    if(response.error == null){
      setState(() {
        _postList = response.data as List<dynamic>;
        nextPageToken = response.nextPageToken!;
        _loading = _loading ? !_loading : _loading;
      });
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}'),
      ));
    }
  }

  // Function to simulate loading more items
  Future<void> loadMoreItems() async {
    setState(() {
      isLoadingMore = true;
    });

    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));

    // Load more items
    ApiResponse response = await getPosts(nextPageToken);

    List<dynamic> _moreList = List.empty();
    if(response.error == null){
      setState(() {
        _moreList = response.data as List<dynamic>;
        nextPageToken = response.nextPageToken!;
      });
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}'),
      ));
    }

    setState(() {
      _postList.addAll(_moreList);
      isLoadingMore = false;
    });
  }

  @override
  void initState() {
    retrievePosts();
    _scrollController = ScrollController(); // Initialize the ScrollController
    _scrollController.addListener(() {
      // Check if the user has scrolled to the bottom of the list
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent &&
          !isLoadingMore) {
        loadMoreItems();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _loading ? Center(child:CircularProgressIndicator()) :
    RefreshIndicator(
      onRefresh: () {
        nextPageToken = '';
        return retrievePosts();
      },
      child: Column(children: [
        Expanded(child: ListView.builder(
            controller: _scrollController,
            itemCount: _postList.length,
            itemBuilder: (BuildContext context, int index){
              Post post = _postList[index];

              return Container(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(child: Text(
                        '${post.title}',
                        softWrap: true,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 17
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PostDetailScreen(post: post,),
                          ),
                        );
                    }),
                    SizedBox(height: 12,),
                    Row(children: [
                      Icon(
                        Icons.calendar_today,  // User icon
                        size: 16,  // Set the size of the icon
                        color: Colors.black,  // Set the color of the icon
                      ),
                      SizedBox(height: 8, width: 5,),
                      Text(
                        '${post.publishedDate}',  // This can be dynamically set
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],  // A lighter color for the date
                        ),
                      ),
                    ],),
                    SizedBox(height: 12,),
                    Text('${post.shortContent}'),
                    SizedBox(height: 12,),
                    Wrap(children: [
                      ...post.labels!.map((label) =>
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),

                            margin: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              label,
                              style: TextStyle(fontSize: 12),
                            ),
                          )
                      ).toList(),
                    ],),
                    SizedBox(height: 12,),
                    Container(
                      width: 10000,
                      height: 1,
                      color: Colors.black26,
                    ),
                  ],
                ),
              );
            }
        ),),

      ],)
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
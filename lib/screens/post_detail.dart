import 'package:TLBK/models/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class PostDetailScreen extends StatelessWidget {
  final Post? post;

  PostDetailScreen({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post!.title!)
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post!.title!,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(children: [
              Icon(
                Icons.calendar_today,  // User icon
                size: 16,  // Set the size of the icon
                color: Colors.black,  // Set the color of the icon
              ),
              SizedBox(height: 8, width: 5,),
              Text(
                '${post!.publishedDate}',  // This can be dynamically set
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],  // A lighter color for the date
                ),
              ),
              SizedBox(height: 8, width: 10,),
              Icon(
                Icons.person,  // User icon
                size: 16,  // Set the size of the icon
                color: Colors.black,  // Set the color of the icon
              ),
              SizedBox(height: 8, width: 5,),
              Text(
                '${post!.user!.name}',  // Replace with author's name
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],),
            SizedBox(height: 16),
            Wrap(children: [
              ...post!.labels!.map((label) =>
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
            SizedBox(height: 16),
            HtmlWidget(
                post?.body ?? ''
            ),
            // Text(post!.body!),
          ],
        ),
      ),
    );
  }
}

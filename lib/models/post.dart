import 'package:TLBK/util.dart';

import 'user.dart';

class Post {
  String? id;
  String? body;
  String? image;
  int? likesCount;
  int? commentsCount;
  User? user;
  bool? selfLiked;
  String? title;
  String? publishedDate;
  List<String>? labels;
  String? shortContent;
  String? url;

  Post({
    this.id,
    this.title,
    this.body,
    this.image,
    this.likesCount,
    this.commentsCount,
    this.user,
    this.selfLiked,
    this.publishedDate,
    this.labels,
    this.shortContent,
    this.url
  });

// map json to post model

factory Post.fromJson(Map<String, dynamic> json) {
  String userImage = '';
  if(json['author']['image']['url'] != null){
    userImage = json['author']['image']['url'];
    userImage = userImage.replaceAll('//','https://');
  }

  return Post(
    id: json['id'],
    title: json['title'],
    body: json['content'],
    image: null,
    likesCount: 0,
    commentsCount: 0,
    selfLiked: true,
    user: User(
      id: json['author']['id'],
      name: json['author']['displayName'],
      image: userImage
    ),
    publishedDate: formatDate(json['published']),
    labels: json['labels'] != null?
        json['labels'].where((label) => label != null).cast<String>().toList()
        : List.empty(),
    shortContent: getShortContent(removeHtmlTags(json['content'])),
    url: json['url']
  );
}

}
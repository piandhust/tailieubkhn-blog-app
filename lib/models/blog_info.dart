import 'package:TLBK/util.dart';

class BlogInfo {
  String? id;
  String? name;
  String? description;
  String? publishedDate;
  String? url;

  BlogInfo({
    this.id,
    this.name,
    this.description,
    this.publishedDate,
    this.url
  });


  // function to convert json data to user model
  factory BlogInfo.fromJson(Map<String, dynamic> json){
    return BlogInfo(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        publishedDate: formatDate(json['published']),
        url: json['url']
    );
  }
}
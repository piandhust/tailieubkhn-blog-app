import 'dart:math';

String formatDate(String dateString) {
  if(dateString == null){
    return "";
  }

  DateTime dateTime = DateTime.parse(dateString);
  String formattedDate = "${dateTime.day.toString().padLeft(2, '0')}/"
      "${dateTime.month.toString().padLeft(2, '0')}/"
      "${dateTime.year}";

  return formattedDate;
}

String removeHtmlTags(String htmlString) {
  // Regular expression to match HTML tags
  final RegExp exp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: false);
  // Replace all matches with an empty string
  return htmlString.replaceAll(exp, '');
}

String getShortContent(String stringHtmlContent){
  return stringHtmlContent.substring(0, min(150, stringHtmlContent.length)) + '...';
}
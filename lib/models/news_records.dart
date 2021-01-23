import 'package:rxdart/transformers.dart';

class NewsRecords {
  final List<NewsModel> newsModel;

  NewsRecords({this.newsModel});

  factory NewsRecords.fromJson(Map<String, dynamic> json) {
    var newsModelList = json['data'] as List;
    List<NewsModel> newsList = newsModelList.map((i) => NewsModel.fromJson(i)).toList();
    return NewsRecords(newsModel: newsList);
  }
}

class NewsModel {
  final String title;
  final String id;
  final String image_feat_single;
  final String summary;
  final String date_pub2;
  final String newsUrl;

  NewsModel({this.title, this.id, this.image_feat_single,
    this.summary, this.date_pub2, this.newsUrl});

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
        title: json['title'], image_feat_single: json['image_feat_single'],
        summary: json['summary'], id: json['id'], date_pub2: json['date_pub2'],
        newsUrl : json['newsUrl'],
    );
  }
}
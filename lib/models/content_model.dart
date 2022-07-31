import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

Content moviesFromJson(String str) {
  final jsonData = json.decode(str);
  return Content.fromMap(jsonData);
}

String moviesToJson(Content data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Content {
  final String name;
  final String imageUrl;
  final String titleImageUrl;
  final String videoUrl;
  final String description;
  final String price;
  final String videoId;
  final String noDownload;
  final String category;
  final Color color;
  final String videoPreviewUrl;
  final String year;
  final String pgRating;
  final String dateUploaded;
  final String quality;
  final Map rating;
  final String noOfPayment;
  final String subName;
  final bool isTopMovie;
  final bool isTrending;

  const Content({
    @required this.name,
    this.imageUrl,
    this.price,
    this.titleImageUrl,
    this.videoUrl,
    this.description,
    this.color,
    this.videoId,
    this.category,
    this.noDownload,
    this.videoPreviewUrl,
    this.year,
    this.pgRating,
    this.dateUploaded,
    this.quality,
    this.rating,
    this.subName,
    this.noOfPayment,
    this.isTopMovie,
    this.isTrending,
  });

  factory Content.fromMap(Map<String, dynamic> json) => new Content(
      videoId: json["videoId"],
      name: json["name"],
      imageUrl: json["imageUrl"],
      titleImageUrl: json["titleImageUrl"],
      videoUrl: json["videoUrl"],
      description: json["description"],
      price: json["price"],
      noDownload: json["noDownload"],
      category: json["category"],
      color: json["color"]);
  Map<String, dynamic> toMap() => {
        "videoId": videoId,
        "name": name,
        "imageUrl": imageUrl,
        "titleImageUrl": titleImageUrl,
        "videoUrl": videoUrl,
        "description": description,
        "price": price,
        "noDownload": noDownload,
        "category": category,
        "color": color
      };
}

import 'package:flutter/material.dart';

class UserGuide {
  String id;
  String title;
  String description;
  String imageUrl;

  UserGuide(
      {required this.title,
        required this.description,
        required this.imageUrl,
        required this.id
        });

  UserGuide.fromMap(Map <String, dynamic> snapshot,String id) :
        id = id,
        description = snapshot['description'] ?? '',
        title = snapshot['title'] ?? '',
        imageUrl = snapshot['imageUrl'] ?? '';

}








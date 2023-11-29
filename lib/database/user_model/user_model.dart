// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  final User user;

  ProfileModel({
    required this.user,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    user: User.fromJson(json['user']),
  );

  Map<String, dynamic> toJson() => {
    'user': user.toJson(),
  };
}

class User {
  final int id;
  final String name;
  final int lastUploadedVideo;
  final bool notifyMoments;
  final String email;
  final String profilePicturePath;
  final DateTime notifyTime;

  User({
    required this.id,
    required this.name,
    required this.lastUploadedVideo,
    required this.notifyMoments,
    required this.email,
    required this.profilePicturePath,
    required this.notifyTime,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'] ?? 0,
    name: json['name'] ?? '',
    lastUploadedVideo: json['last_uploaded_video'],
    notifyMoments: json['notify_moments'],
    email: json['email'] ?? '',
    profilePicturePath: json['profile_picture_path'] ?? '',
    notifyTime: DateTime.parse(json['notify_time']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'last_uploaded_video': lastUploadedVideo,
    'notify_moments': notifyMoments,
    'email': email,
    'profile_picture_path': profilePicturePath,
    'notify_time': notifyTime.toIso8601String(),
  };
}

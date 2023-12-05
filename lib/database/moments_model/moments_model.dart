import 'dart:convert';

import 'package:cached_video_player/cached_video_player.dart';
import 'package:simple_moments/api_service/app_config/app_config.dart';
import 'package:simple_moments/dependency/get_it.dart';

MomentsModel momentsModelFromJson(String str) =>
    MomentsModel.fromJson(json.decode(str));

class MomentsModel {
  final List<Moment> moments;

  MomentsModel({required this.moments});

  factory MomentsModel.fromJson(Map<String, dynamic> json) => MomentsModel(
        moments:
            List<Moment>.from(json['moments'].map((x) => Moment.fromJson(x))),
      );
}

class Moment {
  final DateTime startDate;
  final DateTime endDate;
  final bool isComplete;
  final List<Video> videos;

  Moment({
    required this.startDate,
    required this.endDate,
    required this.isComplete,
    required this.videos,
  });

  factory Moment.fromJson(Map<String, dynamic> json) => Moment(
        startDate: DateTime.parse(json['begin_date']),
        endDate: DateTime.parse(json['end_date']),
        isComplete: json['is_complete'],
        videos: List<Video>.from(json['videos'].map((x) => Video.fromJson(x))),
      );
}

class Video {
  final String video;
  final String tempImg;

  CachedVideoPlayerController? controller;

  Video({
    required this.video,
    required this.tempImg,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        video: json['video'] ?? '',
        tempImg: json['temp_img'] ?? '',
      );

  Future<void> loadController() async {
    controller = CachedVideoPlayerController.network(
        '${getItInstance<AppConfig>().baseUrl}video/$video');
    await controller?.initialize();
    controller?.setLooping(true);
  }
}

import 'dart:convert';

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
        startDate: DateTime.parse(json['start_date']),
        endDate: DateTime.parse(json['end_date']),
        isComplete: json['is_complete'],
        videos: List<Video>.from(json['videos'].map((x) => Video.fromJson(x))),
      );
}

class Video {
  final String thumbnail;
  final String video;

  Video({
    required this.thumbnail,
    required this.video,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        thumbnail: json['temp_img'],
        video: json['video'],
      );
}

List<Moment> demoMoments = [
  Moment(
      startDate: DateTime.parse('2023-09-04T18:55:07.873Z'),
      endDate: DateTime.now(),
      isComplete: false,
      videos: [
        Video(
            thumbnail: 'https://images.unsplash.com/photo-1696446701725-82e084aa8167?auto=for'
                'mat&fit=crop&q=80&w=2940&ixlib=rb-4.0.3&ixid=M3wxMjA'
                '3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            video:
                'https://firebasestorage.googleapis.com/v0/b/videostreaming-test'
                '.appspot.com/o/vid%2FSnaptik_6745671851688692998_tiktok.'
                'mp4?alt=media&token=e6c76be2-9d8e-4be6-aedc-89ddd4985871'),
        Video(
            thumbnail:
                'https://images.unsplash.com/photo-1510414842594-a61c69b5ae57?auto='
                    'format&fit=crop&q=80&w=2940&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MH'
                    'xwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
                    '8MHxzZWFyY2h8NHx8YmVhY2h8ZW58MHx8MHx8fDA%3D',
            video: 'https://firebasestorage.googleapis.com/v0/b/videost'
                'reaming-test.appspot.com/o/vid%2FSnaptik_6842407707551599878'
                '_carlos-barrios%20(1).mp4?alt=media&token=965f5080-2'
                '771-4477-bd9d-defc7b581c5d'),
        Video(
            thumbnail:
                'https://images.unsplash.com/photo-1682685797168-613fd0cae41d?aut'
                    'o=format&fit=crop&q=80&w=2787&ixlib=rb-4.0.3&ixid=M3'
                    'wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            video: 'https://firebasestorage.googleapis.c'
                'om/v0/b/videostreaming-test.appspot.com/o/vid%2FSnaptik'
                '_6856769842385620229_alex.mp4?alt=media&token=b70d853'
                'b-760a-45ee-b5d3-44cef7e4db7f'),
      ]),
  Moment(
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      isComplete: false,
      videos: [
        Video(
            thumbnail:
                'https://images.unsplash.com/photo-1506953823976-52e1fdc0149a?au'
                    'to=format&fit=crop&q=80&w=2835&ixlib=rb-4.0.3&ixid=M3wxM'
                    'jA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            video: 'https://firebasestorage.googleapis.c'
                'om/v0/b/videostreaming-test.appspot.com/o/vid%2FSnaptik'
                '_6856769842385620229_alex.mp4?alt=media&token=b70d853'
                'b-760a-45ee-b5d3-44cef7e4db7f'),
        Video(
            thumbnail: 'https://plus.unsplash.com/premium_photo-1663119029722-0da758fa1181'
                '?auto=format&fit=crop&q=80&w=2986&ixlib=rb-4.0.3&'
                'ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            video:
                'https://firebasestorage.googleapis.com/v0/b/videostreaming-test'
                '.appspot.com/o/vid%2FSnaptik_6745671851688692998_tiktok.'
                'mp4?alt=media&token=e6c76be2-9d8e-4be6-aedc-89ddd4985871'),
        Video(
            thumbnail:
                'https://images.unsplash.com/photo-1473496169904-658ba7c44d8a'
                    '?auto=format&fit=crop&q=80&w=2940&ixlib=rb-4.0.3&ixi'
                    'd=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3DI',
            video: 'https://firebasestorage.googleapis.com/v0/b/videost'
                'reaming-test.appspot.com/o/vid%2FSnaptik_6842407707551599878'
                '_carlos-barrios%20(1).mp4?alt=media&token=965f5080-2'
                '771-4477-bd9d-defc7b581c5d'),
      ])
];

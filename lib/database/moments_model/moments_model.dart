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
  final String tempImg;
  final String video;

  Video({
    required this.tempImg,
    required this.video,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        tempImg: json['temp_img'],
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
            tempImg: 'https://www.rd.com/wp-content/uploads/2017/09/'
                '01-shutterstock_476340928-Irina-Bg-1024x683.jpg',
            video:
                'https://firebasestorage.googleapis.com/v0/b/videostreaming-test'
                '.appspot.com/o/vid%2FSnaptik_6745671851688692998_tiktok.'
                'mp4?alt=media&token=e6c76be2-9d8e-4be6-aedc-89ddd4985871'),
        Video(
            tempImg:
                'https://i.pinimg.com/originals/5e/eb/8d/5eeb8d615bea040425f9937699392751.jpg',
            video: 'https://firebasestorage.googleapis.com/v0/b/videost'
                'reaming-test.appspot.com/o/vid%2FSnaptik_6842407707551599878'
                '_carlos-barrios%20(1).mp4?alt=media&token=965f5080-2'
                '771-4477-bd9d-defc7b581c5d'),
        Video(
            tempImg:
                'https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg',
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
            tempImg:
                'https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg',
            video: 'https://firebasestorage.googleapis.c'
                'om/v0/b/videostreaming-test.appspot.com/o/vid%2FSnaptik'
                '_6856769842385620229_alex.mp4?alt=media&token=b70d853'
                'b-760a-45ee-b5d3-44cef7e4db7f'),
        Video(
            tempImg: 'https://www.rd.com/wp-content/uploads/2017/09/'
                '01-shutterstock_476340928-Irina-Bg-1024x683.jpg',
            video:
                'https://firebasestorage.googleapis.com/v0/b/videostreaming-test'
                '.appspot.com/o/vid%2FSnaptik_6745671851688692998_tiktok.'
                'mp4?alt=media&token=e6c76be2-9d8e-4be6-aedc-89ddd4985871'),
        Video(
            tempImg:
                'https://i.pinimg.com/originals/5e/eb/8d/5eeb8d615bea040425f9937699392751.jpg',
            video: 'https://firebasestorage.googleapis.com/v0/b/videost'
                'reaming-test.appspot.com/o/vid%2FSnaptik_6842407707551599878'
                '_carlos-barrios%20(1).mp4?alt=media&token=965f5080-2'
                '771-4477-bd9d-defc7b581c5d'),
      ])
];

import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:com.ikitech.store/app_user/model/lesson.dart';
import 'package:com.ikitech.store/app_user/screen2/education/chapter_lesson/lesson/list_lesson_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LessonScreen extends StatelessWidget {
  int? idLesson;
  Lesson lessonInput;

  LessonScreen({required this.idLesson, required this.lessonInput}) {
    checkVideo();
  }

  YoutubePlayerController? controller;

  void checkVideo() {
    var a = YoutubePlayer.convertUrlToId(lessonInput.linkVideoYoutube ?? "");
    if (a != null) {
      controller = YoutubePlayerController(
        initialVideoId:
            YoutubePlayer.convertUrlToId(lessonInput.linkVideoYoutube ?? "") ??
                "",
        flags: YoutubePlayerFlags(autoPlay: true, mute: false),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
      if (orientation == Orientation.landscape) {
        return Scaffold(
          body: lessonInput.linkVideoYoutube == null
              ? Center(child: SahaLoadingFullScreen())
              : youtubeLesson(context),
        );
      } else {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Bài học",
            ),
          ),
          body: Column(
            children: [
              lessonInput.linkVideoYoutube == null
                  ? Center(child: SahaLoadingFullScreen())
                  : youtubeLesson(context),
            ],
          ),
        );
      }
    });
  }

  youtubeLesson(context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            if (controller != null)
              YoutubePlayerBuilder(
                player: YoutubePlayer(
                  controller: controller!,
                  showVideoProgressIndicator: true,
                  bottomActions: [
                    CurrentPosition(),
                    ProgressBar(isExpanded: true),
                    PlaybackSpeedButton(),
                    FullScreenButton(),
                  ],
                ),
                builder: (context, player) {
                  return Column(
                    children: [
                      // some widgets
                      player,
                      //some other widgets
                    ],
                  );
                },
              ),
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bài học: ',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          lessonInput.title ?? "",
                          style: TextStyle(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.9),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                  HtmlWidget(
                    "${lessonInput.description ?? ""}",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

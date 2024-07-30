import 'package:com.ikitech.store/app_user/data/remote/response-request/education/ada_lesson_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/education/add_chapter_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/education/chapter_lesson_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/education/course_list_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/education/course_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/success/success_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/saha_service_manager.dart';
import 'package:com.ikitech.store/app_user/data/repository/handle_error.dart';
import 'package:com.ikitech.store/app_user/model/chapter.dart';
import 'package:com.ikitech.store/app_user/model/course_list.dart';
import 'package:com.ikitech.store/app_user/model/lesson.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';
import 'package:sahashop_customer/app_customer/repository/handle_error.dart';

import '../../../model/question.dart';
import '../../../model/quiz.dart';
import '../../remote/response-request/education/all_quiz_res.dart';
import '../../remote/response-request/education/question_res.dart';
import '../../remote/response-request/education/quiz_res.dart';

class EducationReposition {
  Future<SuccessResponse?> deleteLesson({required int lessonId}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .deleteLesson(UserInfo().getCurrentStoreCode(), lessonId);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
  }

  Future<AddLessonRes?> updateLesson(
      {required int lessonId, required Lesson lesson}) async {
    try {
      var res = await SahaServiceManager().service!.updateLesson(
          UserInfo().getCurrentStoreCode(), lessonId, lesson.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<CourseListRes?> getCourseList({required int currentPage}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getCourseList(UserInfo().getCurrentStoreCode(), currentPage);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> deleteTrainCourses({required int courseId}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .deleteTrainCourses(UserInfo().getCurrentStoreCode(), courseId);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<CourseListRes?> addCourses(
      {required String title,
      required String shortDescription,
      required String imageUrl,
      required String description}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .addCourses(UserInfo().getCurrentStoreCode(), {
        "image_url": imageUrl,
        "title": title,
        "short_description": shortDescription,
        "description": description,
      });
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<CourseRes?> updateCourse(int? idCourse, CourseList courseList) async {
    try {
      var res = await SahaServiceManager().service!.updateCourse(
            UserInfo().getCurrentStoreCode(),
            idCourse,
            courseList.toJson(),
          );
      return res;
    } catch (err) {
      throw (err.toString());
    }
  }

  Future<ChapterLessonRes?> getChapterLesson({required int idCourse}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getChapterLesson(UserInfo().getCurrentStoreCode(), idCourse);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AddChapterRes?> addChapter({
    required int trainCourseId,
    required String title,
    required String shortDescription,
  }) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .addChapter(UserInfo().getCurrentStoreCode(), {
        "train_course_id": trainCourseId,
        "title": title,
        "short_description": shortDescription,
      });
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> deleteChapter({required int chapterId}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .deleteChapter(UserInfo().getCurrentStoreCode(), chapterId);
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
  }

  Future<AddChapterRes?> updateChapter(
      {required int idCourse,
      required int idChapter,
      required Chapter chapter}) async {
    try {
      var res = await SahaServiceManager().service!.updateChapter(
          UserInfo().getCurrentStoreCode(), idChapter, chapter.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AddLessonRes?> addLesson({
    required int trainChapterId,
    required String title,
    required String shortDescription,
    required String description,
    required String linkVideoYoutube,
  }) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .addLesson(UserInfo().getCurrentStoreCode(), {
        "train_chapter_id": trainChapterId,
        "title": title,
        "short_description": shortDescription,
        "description": description,
        "link_video_youtube": linkVideoYoutube,
      });
      return res;
    } catch (err) {
      handleErrorCustomer(err);
    }
  }

  Future<AllQuizRes?> getAllQuiz({required int courseId}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllQuiz(UserInfo().getCurrentStoreCode(), courseId);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<QuizRes?> createQuiz(
      {required int courseId, required Quiz quiz}) async {
    try {
      var res = await SahaServiceManager().service!.createQuiz(
          UserInfo().getCurrentStoreCode(), courseId, quiz.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<QuizRes?> updateQuiz(
      {required int courseId, required int quizId, required Quiz quiz}) async {
    try {
      var res = await SahaServiceManager().service!.updateQuiz(
          UserInfo().getCurrentStoreCode(), courseId, quizId, quiz.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> deleteQuiz(
      {required int courseId, required int quizId}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .deleteQuiz(UserInfo().getCurrentStoreCode(), courseId, quizId);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<QuizRes?> getQuiz({required int courseId, required int quizId}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getQuiz(UserInfo().getCurrentStoreCode(), courseId, quizId);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<QuestionRes?> createQuestion(
      {required int courseId,
      required int quizId,
      required Question question}) async {
    try {
      var res = await SahaServiceManager().service!.createQuestion(
          UserInfo().getCurrentStoreCode(),
          courseId,
          quizId,
          question.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<QuestionRes?> updateQuestion(
      {required int courseId,
      required int quizId,
      required int questionId,
      required Question question}) async {
    try {
      var res = await SahaServiceManager().service!.updateQuestion(
          UserInfo().getCurrentStoreCode(),
          courseId,
          quizId,
          questionId,
          question.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> deleteQuestion(
      {required int courseId,
      required int quizId,
      required int questionId}) async {
    try {
      var res = await SahaServiceManager().service!.deleteQuestion(
          UserInfo().getCurrentStoreCode(), courseId, quizId, questionId);
      return res;
    } catch (err) {
      handleError(err);
    }
  }
}

import 'package:korkort/model/categories_exams_response.dart';

class ProfileResponse {
  String? firstName;
  String? lastName;
  String? email;
  num? avatarId;
  String? userCode;
  num? bonusMoney;
  num? ball;
  num? completedLessons;
  num? allLessonsCount;
  num? allQuestionsCount;
  num? correctAnswers;
  num? lastExamsResult;
  String? level;
  num? levelImageId;
  String? tariffExpireDate;
  int? levelId;
  int? levelPercent;
  List<Detail>? lastExams;

  ProfileResponse(
      {this.firstName,
        this.lastName,
        this.email,
        this.avatarId,
        this.userCode,
        this.bonusMoney,
        this.ball,
        this.completedLessons,
        this.allLessonsCount,
        this.allQuestionsCount,
        this.correctAnswers,
        this.lastExamsResult,
        this.level,
        this.levelImageId,
        this.tariffExpireDate,
        this.lastExams,
      this.levelId,
        this.levelPercent,
      });

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    levelId = json['level_id'];
    levelPercent = json['level_percent'];
    email = json['email'];
    avatarId = json['avatar_id'];
    userCode = json['user_code'];
    bonusMoney = json['bonus_money'];
    ball = json['ball'];
    completedLessons = json['completed_lessons'];
    allLessonsCount = json['all_lessons_count'];
    allQuestionsCount = json['all_questions_count'];
    correctAnswers = json['correct_answers'];
    lastExamsResult = json['last_exams_result'];
    level = json['level'];
    levelImageId = json['level_image_id'];
    tariffExpireDate = json['tariff_expire_date'];
    if (json['last_exams'] != null) {
      lastExams = <Detail>[];
      json['last_exams'].forEach((v) {
        lastExams!.add(new Detail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['avatar_id'] = this.avatarId;
    data['user_code'] = this.userCode;
    data['bonus_money'] = this.bonusMoney;
    data['ball'] = this.ball;
    data['completed_lessons'] = this.completedLessons;
    data['all_lessons_count'] = this.allLessonsCount;
    data['all_questions_count'] = this.allQuestionsCount;
    data['correct_answers'] = this.correctAnswers;
    data['last_exams_result'] = this.lastExamsResult;
    data['level'] = this.level;
    data['level_image_id'] = this.levelImageId;
    data['tariff_expire_date'] = this.tariffExpireDate;
    if (this.lastExams != null) {
      data['last_exams'] = this.lastExams!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LastExams {
  int? questions;
  int? percent;

  LastExams({this.questions, this.percent});

  LastExams.fromJson(Map<String, dynamic> json) {
    questions = json['questions'];
    percent = json['percent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questions'] = this.questions;
    data['percent'] = this.percent;
    return data;
  }
}

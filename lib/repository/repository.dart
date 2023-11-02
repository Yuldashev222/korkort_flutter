import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:korkort/main.dart';
import 'package:korkort/route/route_constants.dart';

class Repository {
  final Dio _dio = Dio()..interceptors.add(LogInterceptor(responseBody: true, requestBody: true, requestHeader: true));
  final String _url = 'https://api.lattmedkorkort.se/api/v1';
  GetStorage getStorage = GetStorage();

  void goToLogin() {
    BuildContext? context = NavigationService.navigatorKey.currentContext;
    if (context != null) {
      getStorage.erase();
      Navigator.pushNamedAndRemoveUntil(context, RouteList.authScreen, (route) => false, arguments: 1);
    }
  }

  Future<Response?> postRegister({String? firstName, String? lastName, String? email, String? password, String? language}) async {
    try {
      Response response = await _dio.post("$_url/auth/register/", data: {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "password": password,
      }, queryParameters: {
        "language": language
      });

      return response;
    } on DioException catch (e) {
      // if (e.response?.statusCode == 401) {
      //   goToLogin();
      // }
      return e.response;
    }
  }

  Future<Response?> postSignIn({String? email, String? password, String? language}) async {
    try {
      Response response = await _dio.post("$_url/auth/backend-signin/", data: {
        "email": email,
        "password": password,
      }, queryParameters: {
        "language": language
      });

      return response;
    } on DioException catch (e) {
      // if (e.response?.statusCode == 401) {
      //   goToLogin();
      // }
      return e.response;
    }
  }

  Future<Response?> sendEmailReset({String? email, String? linkType, String? language}) async {
    try {
      Response response = await _dio.post("$_url/auth/password-reset/", data: {
        "email": email,
        "link_type": linkType,
      }, queryParameters: {
        "language": language
      });

      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        goToLogin();
      }
      return e.response;
    }
  }

  Future<Response?> sendEmailResetConfirm({String? uid, String? token, String? newPassword, String? language}) async {
    try {
      Response response = await _dio.post("$_url/auth/password-reset/confirm/", data: {
        "uid": uid,
        "token": token,
        "new_password": newPassword,
      }, queryParameters: {
        "language": language
      });
      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        goToLogin();
      }
      return e.response;
    }
  }

  Future<Response?> getTariff({String? token, String? language}) async {
    try {
      Response response = await _dio.get("$_url/tariffs/", options: Options(headers: {"Authorization": "token $token"}), queryParameters: {"language": language});

      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        goToLogin();
      }
      return e.response;
    }
  }

  Future<Response?> postCoupon({String? token, String? coupon, String? language}) async {
    try {
      Response response =
          await _dio.post("$_url/payments/check-coupon/", options: Options(headers: {"Authorization": "token $token"}), data: {"user_code": coupon}, queryParameters: {"language": language});

      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        goToLogin();
      }
      return e.response;
    }
  }

  Future<Response?> postCreateStripe({String? token, int? tariffId, bool? useBonusMoney, String? userCode, String? language}) async {
    try {
      Response response = await _dio.post("$_url/payments/stripe/create-checkout-session/", options: Options(headers: {"Authorization": "token $token"}), data: {
        "tariff_id": tariffId,
        "link_type": "mobile",
        "use_bonus_money": useBonusMoney,
        "user_code": userCode,
      }, queryParameters: {
        "language": language
      });

      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        goToLogin();
      }
      return e.response;
    }
  }

  Future<Response?> checkPayment({String? token, int? id, String? language}) async {
    try {
      Response response = await _dio.get("$_url/payments/orders/$id", options: Options(headers: {"Authorization": "token $token"}), queryParameters: {"language": language});

      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        goToLogin();
      }
      return e.response;
    }
  }

  Future<Response?> googleSignIn({String? idToken, String? language}) async {
    try {
      Response response = await _dio.post("$_url/auth/google-signin/", data: {"id_token": idToken}, queryParameters: {"language": language});
      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        goToLogin();
      }
      return e.response;
    }
  }

  Future<Response?> passwordResetCode({String? email, String? language}) async {
    try {
      Response response = await _dio.post("$_url/auth/password-reset/code/", data: {"email": email}, queryParameters: {"language": language});

      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        goToLogin();
      }
      return e.response;
    }
  }

  Future<Response?> passwordResetCheckCode({String? email, String? newPassword, String? code, String? language}) async {
    try {
      Response response = await _dio.post("$_url/auth/password-reset/confirm/code/", data: {
        "email": email,
        "new_password": newPassword,
        "code": code,
      }, queryParameters: {
        "language": language
      });

      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        goToLogin();
      }
      return e.response;
    }
  }

  Future<Response?> profileUpdate({String? firstName, String? lastName, num? avatar, String? token, String? language, String? password}) async {
    try {
      Response response = await _dio.patch(
        "$_url/accounts/profile/",
        data: {
          "first_name": firstName,
          "last_name": lastName,
          "avatar_id": avatar,
          "password": password,
        },
        queryParameters: {"language": language},
        options: Options(headers: {"Authorization": "token $token"}),
      );

      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        goToLogin();
      }
      return e.response;
    }
  }

  Future<Response?> profileUpdateNoPassword({String? firstName, String? lastName, num? avatar, String? token, String? language}) async {
    try {
      Response response = await _dio.patch(
        "$_url/accounts/profile/",
        data: {
          "first_name": firstName,
          "last_name": lastName,
          "avatar_id": avatar,
        },
        queryParameters: {"language": language},
        options: Options(headers: {"Authorization": "token $token"}),
      );

      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        goToLogin();
      }
      return e.response;
    }
  }

  Future<Response?> lessonsChapterId({String? token, int? chapterId, String? language}) async {
    try {
      Response response = await _dio.get("$_url/lessons/",
          options: Options(
            headers: {"Authorization": "token $token"},
          ),
          queryParameters: {"lesson__chapter": chapterId, "language": language});

      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        goToLogin();
      }
      return e.response;
    }
  }

  Future<Response?> lessonsChapter({String? token, String? language}) async {
    try {
      Response response = await _dio.get("$_url/chapters/",
          options: Options(
            headers: {"Authorization": "token $token"},
          ),
          queryParameters: {"language": language});
      print('Repository.lessonsChapter $language');
      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        goToLogin();
      }
      return e.response;
    }
  }

  Future<Response?> lessons({String? token, int? id, String? language}) async {
    try {
      Response response = await _dio.get(
        "$_url/lessons/$id/",
        options: Options(
          headers: {"Authorization": "token $token"},
        ),
        queryParameters: {"language": language},
      );

      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        goToLogin();
      }
      return e.response;
    }
  }
  Future<Response?> lessonsForChapter({String? token, int? id, String? language}) async {
    try {
      Response response = await _dio.get("$_url/chapters/$id/",
          options: Options(
            headers: {"Authorization": "token $token"},
          ),
          queryParameters: {"language": language});

      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        goToLogin();
      }
      return e.response;
    }
  }

  Future<Response?> lessonTestAnswer({String? token, int? lessonId, List? answersTrue, String? language}) async {
    try {
      Response response = await _dio.post("$_url/lessons/questions/answers/",
          options: Options(
            headers: {"Authorization": "token $token"},
          ),
          queryParameters: {"language": language},
          data: {"lesson_id": lessonId, "questions":answersTrue
          });

      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        goToLogin();
      }
      return e.response;
    }
  }

  Future<Response?> profileGet({String? token, String? language}) async {
    try {
      Response response = await _dio.get(
        "$_url/accounts/profile/",
        options: Options(
          headers: {"Authorization": "token $token"},
        ),
        queryParameters: {"language": language},
      );
      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        goToLogin();
      }
      return e.response;
    }
  }

  Future<Response?> statisticsGet({String? token, String? language}) async {
    try {
      Response response = await _dio.get(
        "$_url/lessons/statistics/",
        options: Options(
          headers: {"Authorization": "token $token"},
        ),
        queryParameters: {"language": language},
      );

      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        goToLogin();
      }
      return e.response;
    }
  }

  Future<Response?> categoriesExamsGet({String? token, String? language}) async {
    try {
      Response response = await _dio.get(
        "$_url/exams/",
        options: Options(
          headers: {"Authorization": "token $token"},
        ),
        queryParameters: {"language": language},
      );

      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        goToLogin();
      }
      return e.response;
    }
  }

  Future<Response?> categoriesFilterGet({String? token, String? language, int? categoryId, int? questions, int? difficultyLevel}) async {
    try {
      Response response = await _dio.post("$_url/exams/categories/",
          options: Options(
            headers: {"Authorization": "token $token"},
          ),
          queryParameters: {
            "language": language
          },
          data: {
            "category_id": categoryId,
            "questions": questions,
            "difficulty_level": difficultyLevel,
          });

      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        goToLogin();
      }
      return e.response;
    }
  }

  Future<Response?> categoriesAnswersPost({String? token, String? language, int? examId, List? wrongQuestions, List? correctQuestions}) async {
    try {
      Response response = await _dio.post("$_url/exams/categories/answers/",
          options: Options(
            headers: {"Authorization": "token $token"},
          ),
          queryParameters: {
            "language": language
          },
          data: {
            "exam_id": examId,
            "wrong_questions": wrongQuestions,
            "correct_questions": correctQuestions,
          });

      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        goToLogin();
      }
      return e.response;
    }
  }
  Future<Response?> savedAnswersPost({String? token, String? language, List? wrongQuestions, List? correctQuestions}) async {
    try {
      Response response = await _dio.post("$_url/exams/saved/answers/",
          options: Options(
            headers: {"Authorization": "token $token"},
          ),
          queryParameters: {
            "language": language
          },
          data: {
            "wrong_questions": wrongQuestions,
            "correct_questions": correctQuestions,
          });

      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        goToLogin();
      }
      return e.response;
    }
  }
  Future<Response?> mixAnswersPost({String? token, String? language, List? wrongQuestions, List? correctQuestions}) async {
    try {
      Response response = await _dio.post("$_url/exams/categories/mix/answers/",
          options: Options(
            headers: {"Authorization": "token $token"},
          ),
          queryParameters: {
            "language": language
          },
          data: {
            "wrong_questions": wrongQuestions,
            "correct_questions": correctQuestions,
          });

      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        goToLogin();
      }
      return e.response;
    }
  }
  Future<Response?> wrongAnswersPost({String? token, String? language, List? wrongQuestions, List? correctQuestions}) async {
    try {
      Response response = await _dio.post("$_url/exams/wrongs/answers/",
          options: Options(
            headers: {"Authorization": "token $token"},
          ),
          queryParameters: {
            "language": language
          },
          data: {
            "question_counts": wrongQuestions!.length+correctQuestions!.length,
            "correct_questions": correctQuestions,
          });

      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        goToLogin();
      }
      return e.response;
    }
  }

  Future<Response?> categoriesMixFilterGet({String? token, String? language, int? questions, int? difficultyLevel, List? categoryIds}) async {
    try {
      Response response = await _dio.post("$_url/exams/categories/mix/",
          options: Options(
            headers: {"Authorization": "token $token"},
          ),
          queryParameters: {"language": language},
          data: {"questions": questions, "difficulty_level": difficultyLevel, "category_ids": categoryIds});

      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        goToLogin();
      }
      return e.response;
    }
  }

  Future<Response?> categoriesWrongFilterGet({String? token, String? language, int? questions, int? difficultyLevel, bool? myQuestions}) async {
    try {
      Response response = await _dio.get("$_url/exams/wrongs/",
          options: Options(
            headers: {"Authorization": "token $token"},
          ),
          queryParameters: {"language": language, "counts": questions, "difficulty_level": difficultyLevel, "my_questions": myQuestions});

      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        goToLogin();
      }
      return e.response;
    }
  }
  Future<Response?> categoriesSavedFilterGet({String? token, String? language, int? questions, int? difficultyLevel, bool? myQuestions}) async {
    try {
      Response response = await _dio.get("$_url/exams/saved/",
          options: Options(
            headers: {"Authorization": "token $token"},
          ),
          queryParameters: {"language": language, "counts": questions, "difficulty_level": difficultyLevel, "my_questions": myQuestions});

      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        goToLogin();
      }
      return e.response;
    }
  }
  Future<Response?> categoriesFinalFilterGet({String? token, String? language}) async {
    try {
      Response response = await _dio.get("$_url/exams/final/",
          options: Options(
            headers: {"Authorization": "token $token"},
          ),
          queryParameters: {"language": language}
      );

      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        goToLogin();
      }
      return e.response;
    }
  }

  Future<Response?> ordersGet({String? token, String? language,required int page}) async {
    try {
      Response response = await _dio.get(
        "$_url/payments/orders/",
        options: Options(
          headers: {"Authorization": "token $token"},
        ),
        queryParameters: {"language": language ,"page":page },
      );

      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        goToLogin();
      }
      return e.response;
    }
  }

  Future<Response?> ordersGetId({String? token, String? language, num? id}) async {
    try {
      Response response = await _dio.get(
        "$_url/payments/orders/$id/",
        options: Options(
          headers: {"Authorization": "token $token"},
        ),
        queryParameters: {"language": language},
      );

      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        goToLogin();
      }
      return e.response;
    }
  }

  Future<Response?> testSaved({String? token, String? language, num? id}) async {
    try {
      Response response = await _dio.post("$_url/questions/saved/",
          options: Options(
            headers: {"Authorization": "token $token"},
          ),
          queryParameters: {"language": language},
          data: {"pk": id});
      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        goToLogin();
      }
      return e.response;
    }
  }

  Future<Response?> lessonsQuestion({String? token, String? language, num? id}) async {
    try {
      Response response = await _dio.get(
        "$_url/lessons/$id/questions/",
        options: Options(
          headers: {"Authorization": "token $token"},
        ),
        queryParameters: {"language": language},
      );
      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        goToLogin();
      }
      return e.response;
    }
  }

  Future<Response?> lessonsWrong({String? token, String? language, List? correctQuestions, int? questionCounts}) async {
    try {
      Response response = await _dio.post("$_url/exams/wrongs/answers/",
          options: Options(
            headers: {"Authorization": "token $token"},
          ),
          queryParameters: {"language": language},
          data: {"correct_questions": correctQuestions, "question_counts": questionCounts});
      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        goToLogin();
      }
      return e.response;
    }
  }
  Future<Response?> swish({String? token, String? language,  int? number}) async {
    try {
      Response response = await _dio.post("$_url/swish/",
          options: Options(
            headers: {"Authorization": "token $token"},
          ),
          queryParameters: {"language": language},
          data: {"number": number});
      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        goToLogin();
      }
      return e.response;
    }
  }

  Future<Response?> language() async {
    try {
      Response response = await _dio.get(
        "$_url/languages/",
      );
      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        goToLogin();
      }
      return e.response;
    }
  }

  Future<Response?> levelGet({String? token, String? language}) async {
    try {
      Response response = await _dio.get(
        "$_url/levels/",
        options: Options(
          headers: {"Authorization": "token $token"},
        ),
        queryParameters: {"language": language},
      );
      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        goToLogin();
      }
      return e.response;
    }
  }
  Future<Response?> bookGet({String? token, String? language,required int page}) async {
    try {
      Response response = await _dio.get(
        "$_url/books/",
        options: Options(
          headers: {"Authorization": "token $token"},
        ),
        queryParameters: {"language": language,"page":page},
      );
      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        goToLogin();
      }
      return e.response;
    }
  }
  Future<Response?> bookUpdateCheck({String? token, String? language, int? chapter,bool?isCompleted}) async {
    try {
      Response response = await _dio.post(
        "$_url/books/chapters/completed/",
        options: Options(
          headers: {"Authorization": "token $token"},
        ),
        queryParameters: {"language": language},
        data: {
          "chapter":chapter,
          "is_completed":isCompleted,
        }
      );
      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        goToLogin();
      }
      return e.response;
    }
  }
  Future<Response?> bookGetId({String? token, String? language, int?id}) async {
    try {
      Response response = await _dio.get(
        "$_url/books/$id/",
        options: Options(
          headers: {"Authorization": "token $token"},
        ),
        queryParameters: {"language": language},

      );
      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        goToLogin();
      }
      return e.response;
    }
  }
  Future<Response?> todoGet({String? token, String? language, int?page}) async {
    try {
      Response response = await _dio.get(
        "$_url/todos/",
        options: Options(
          headers: {"Authorization": "token $token"},
        ),
        queryParameters: {"language": language,"page":page},

      );
      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        goToLogin();
      }
      return e.response;
    }
  }
  Future<Response?> todoUpdate({String? token, String? language, int?todo,bool?isCompleted}) async {
    try {
      Response response = await _dio.post(
        "$_url/todos/completed/",
        options: Options(
          headers: {"Authorization": "token $token"},
        ),
        data: {
          "todo":todo,
          "is_completed":isCompleted
        },
        queryParameters: {"language": language},

      );
      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        goToLogin();
      }
      return e.response;
    }
  }
}

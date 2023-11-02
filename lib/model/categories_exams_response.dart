class CategoriesExamsResponse {
  List<CategoryExams>? categoryExams;
  int? allWrongAnswersCount;
  int? wrongAnswersCount;
  int? savedAnswersCount;
  int? allSavedAnswersCount;
  CategoriesExamsResponse({this.allWrongAnswersCount,
    this.wrongAnswersCount,
    this.savedAnswersCount,
    this.allSavedAnswersCount,this.categoryExams});

  CategoriesExamsResponse.fromJson(Map<String, dynamic> json) {
    allWrongAnswersCount = json['all_wrong_answers_count'];
    wrongAnswersCount = json['wrong_answers_count'];
    savedAnswersCount = json['saved_answers_count'];
    allSavedAnswersCount = json['all_saved_answers_count'];
    if (json['category_exams'] != null) {
      categoryExams = <CategoryExams>[];
      json['category_exams'].forEach((v) {
        categoryExams!.add(new CategoryExams.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categoryExams != null) {
      data['category_exams'] = this.categoryExams!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryExams {
  int? id;
  String? image;
  String? name;
  List<Detail>? detail;
  int? percent;
  int? category;

  CategoryExams({this.id, this.image, this.name, this.percent, this.category,this.detail});

  CategoryExams.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    if (json['detail'] != null) {
      detail = <Detail>[];
      json['detail'].forEach((v) {
        detail!.add( Detail.fromJson(v));
      });
    }    percent = json['percent'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['name'] = this.name;
    data['detail'] = this.detail;
    data['percent'] = this.percent;
    data['category'] = this.category;
    return data;
  }
}
class Detail {
  int? questions;
  int? percent;

  Detail({this.questions, this.percent});

  Detail.fromJson(Map<String, dynamic> json) {
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
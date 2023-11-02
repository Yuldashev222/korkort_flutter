class QuestionResponse {
  int? id;
  int? categoryId;
  String? category;
  String? questionText;
  String? questionGif;
  int? questionGifLastFrameNumber;
  num? questionGifDuration;
  String? questionImage;
  bool? isSaved;
  List<VariantSet>? variantSet;

  QuestionResponse(
      {this.id,
        this.categoryId,
        this.category,
        this.questionText,
        this.questionGifDuration,
        this.questionGif,
        this.questionGifLastFrameNumber,
        this.questionImage,
        this.isSaved,
        this.variantSet});

  QuestionResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    category = json['category'];
    questionText = json['question_text'];
    questionGif = json['question_gif'];
    questionGifDuration = json['question_gif_duration'];
    questionGifLastFrameNumber = json['question_gif_last_frame_number'];
    questionImage = json['question_image'];
    isSaved = json['is_saved'];
    if (json['variants'] != null) {
      variantSet = <VariantSet>[];
      json['variants'].forEach((v) {
        variantSet!.add(new VariantSet.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['category'] = this.category;
    data['question_text'] = this.questionText;
    data['question_gif'] = this.questionGif;
    data['question_gif_last_frame_number'] = this.questionGifLastFrameNumber;
    data['question_image'] = this.questionImage;
    data['is_saved'] = this.isSaved;
    if (this.variantSet != null) {
      data['variant_set'] = this.variantSet!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VariantSet {
  int? id;
  bool? isCorrect;
  String? text;

  VariantSet({this.id, this.isCorrect, this.text});

  VariantSet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isCorrect = json['is_correct'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_correct'] = this.isCorrect;
    data['text'] = this.text;
    return data;
  }
}

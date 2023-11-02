class LessonResponse {
  int? id;
  String? title;
  bool? isOpen;
  bool? isCompleted;
  double? lessonTime;
  String? image;
  String? text;
  String? video;
  List<WordInfos>? wordInfos;
  List<Sources>? sources;
  List<Lessons>? lessons;
  List<Questions>? questions;

  LessonResponse(
      {this.id,
        this.title,
        this.isOpen,
        this.isCompleted,
        this.lessonTime,
        this.image,
        this.text,
        this.video,
        this.wordInfos,
        this.sources,
        this.lessons,
        this.questions});

  LessonResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    isOpen = json['is_open'];
    isCompleted = json['is_completed'];
    lessonTime = json['lesson_time'];
    image = json['image'];
    text = json['text'];
    video = json['video'];
    if (json['word_infos'] != null) {
      wordInfos = <WordInfos>[];
      json['word_infos'].forEach((v) {
        wordInfos!.add(new WordInfos.fromJson(v));
      });
    }
    if (json['sources'] != null) {
      sources = <Sources>[];
      json['sources'].forEach((v) {
        sources!.add(new Sources.fromJson(v));
      });
    }
    if (json['lessons'] != null) {
      lessons = <Lessons>[];
      json['lessons'].forEach((v) {
        lessons!.add(new Lessons.fromJson(v));
      });
    }
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(new Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['is_open'] = this.isOpen;
    data['is_completed'] = this.isCompleted;
    data['lesson_time'] = this.lessonTime;
    data['image'] = this.image;
    data['text'] = this.text;
    data['video'] = this.video;
    if (this.wordInfos != null) {
      data['word_infos'] = this.wordInfos!.map((v) => v.toJson()).toList();
    }
    if (this.sources != null) {
      data['sources'] = this.sources!.map((v) => v.toJson()).toList();
    }
    if (this.lessons != null) {
      data['lessons'] = this.lessons!.map((v) => v.toJson()).toList();
    }
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WordInfos {
  int? id;
  String? word;
  String? info;

  WordInfos({this.id, this.word, this.info});

  WordInfos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    word = json['word'];
    info = json['info'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.word;
    data['info'] = this.info;
    return data;
  }
}

class Sources {
  int? id;
  String? text;
  String? link;

  Sources({this.id, this.text, this.link});

  Sources.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['link'] = this.link;
    return data;
  }
}

class Lessons {
  int? id;
  int? lessonPermission;
  String? title;
  bool? isOpen;
  bool? isCompleted;
  double? lessonTime;

  Lessons(
      {this.id, this.title, this.isOpen, this.isCompleted, this.lessonTime,this.lessonPermission});

  Lessons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    lessonPermission=json["lesson_permission"];
    isOpen = json['is_open'];
    isCompleted = json['is_completed'];
    lessonTime = json['lesson_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data["lesson_permission"]=this.lessonPermission;
    data['is_open'] = this.isOpen;
    data['is_completed'] = this.isCompleted;
    data['lesson_time'] = this.lessonTime;
    return data;
  }
}

class Questions {
  int? id;
  String? questionText;
  String? questionGif;
  String?questionImage;
  num?gifLastFrameNumber;
  bool?isSaved;

  List<VariantSet>? variantSet;

  Questions({this.id, this.questionText, this.questionGif, this.variantSet,this.questionImage,this.isSaved,this.gifLastFrameNumber});

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    questionImage = json['question_image'];
    questionText = json['question_text'];
    gifLastFrameNumber = json['question_gif_last_frame_number'];
    questionGif = json['question_gif'];
    isSaved = json['is_saved'];
    if (json['variant_set'] != null) {
      variantSet = <VariantSet>[];
      json['variant_set'].forEach((v) {
        variantSet!.add(new VariantSet.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question_image']=this.questionImage;
    data['question_text'] = this.questionText;
    data['question_gif_last_frame_number'] = this.questionGif;
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

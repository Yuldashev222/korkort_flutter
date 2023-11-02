class BooksIdResponse {
  int? id;
  String? title;
  bool? isCompleted;
  String? audio;
  List<Parts>? parts;

  BooksIdResponse(
      {this.id, this.title, this.isCompleted, this.audio, this.parts});

  BooksIdResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    isCompleted = json['is_completed'];
    audio = json['audio'];
    if (json['parts'] != null) {
      parts = <Parts>[];
      json['parts'].forEach((v) {
        parts!.add(new Parts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['is_completed'] = this.isCompleted;
    data['audio'] = this.audio;
    if (this.parts != null) {
      data['parts'] = this.parts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Parts {
  String? image;
  String? title;
  String? text;
  String? greenText;
  String? yellowText;
  String? redText;

  Parts(
      {this.image,
        this.title,
        this.text,
        this.greenText,
        this.yellowText,
        this.redText});

  Parts.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
    text = json['text'];
    greenText = json['green_text'];
    yellowText = json['yellow_text'];
    redText = json['red_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['title'] = this.title;
    data['text'] = this.text;
    data['green_text'] = this.greenText;
    data['yellow_text'] = this.yellowText;
    data['red_text'] = this.redText;
    return data;
  }
}

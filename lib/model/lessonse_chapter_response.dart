class LessonChapterResponse {
  String? title;
  String? desc;
  String? image;
  int? lessons;
  int? lastLesson;
  int? chapterHour;
  int? chapterMinute;
  int? completedLessons;
  int? isOpen;
  int? id;

  LessonChapterResponse(
      {this.title,
        this.desc,
        this.image,
        this.lessons,
        this.lastLesson,
        this.chapterHour,
        this.chapterMinute,
        this.isOpen,
        this.id,
        this.completedLessons});

  LessonChapterResponse.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    desc = json['desc'];
    image = json['image'];
    lessons = json['lessons'];
    lastLesson = json['last_lesson'];
    chapterHour = json['chapter_hour'];
    chapterMinute = json['chapter_minute'];
    completedLessons = json['completed_lessons'];
    isOpen = json['is_open'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['image'] = this.image;
    data['lessons'] = this.lessons;
    data['last_lesson'] = this.lastLesson;
    data['chapter_hour'] = this.chapterHour;
    data['chapter_minute'] = this.chapterMinute;
    data['completed_lessons'] = this.completedLessons;
    data['is_open'] = this.isOpen;
    data['id'] = this.id;
    return data;
  }
}

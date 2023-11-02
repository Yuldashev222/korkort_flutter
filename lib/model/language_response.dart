class LanguageResponse {
  String? languageId;
  String? name;

  LanguageResponse({this.languageId, this.name});

  LanguageResponse.fromJson(Map<String, dynamic> json) {
    languageId = json['language_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['language_id'] = this.languageId;
    data['name'] = this.name;
    return data;
  }
}
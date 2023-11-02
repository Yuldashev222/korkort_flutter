class StatisticsResponse {
  dynamic count;
  int? weekday;

  StatisticsResponse({this.count, this.weekday});

  StatisticsResponse.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    weekday = json['weekday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['weekday'] = this.weekday;
    return data;
  }
}

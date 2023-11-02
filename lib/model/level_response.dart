class LevelResponse {
  int? id;
  int? ball;
  int? orderingNumber;
  String? name;
  String? desc;

  LevelResponse(
      {this.id,
        this.ball,
        this.orderingNumber,
        this.name,
        this.desc});

  LevelResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ball = json['ball'];
    orderingNumber = json['ordering_number'];
    name = json['name'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ball'] = this.ball;
    data['ordering_number'] = this.orderingNumber;
    data['name'] = this.name;
    data['desc'] = this.desc;
    return data;
  }
}

class TariffResponse {
  num? studentDiscountValue;
  bool? studentDiscountIsPercent;
  num? tariffDiscountValue;
  bool? tariffDiscountIsPercent;
  String? tariffDiscountTitle;
  String? tariffDiscountImage;
  num? studentBonusMoney;
  List<Objects>? objects;

  TariffResponse(
      {this.studentDiscountValue,
        this.studentDiscountIsPercent,
        this.tariffDiscountValue,
        this.tariffDiscountIsPercent,
        this.tariffDiscountTitle,
        this.tariffDiscountImage,
        this.studentBonusMoney,
        this.objects});

  TariffResponse.fromJson(Map<String, dynamic> json) {
    studentDiscountValue = json['student_discount_value'];
    studentDiscountIsPercent = json['student_discount_is_percent'];
    tariffDiscountValue = json['tariff_discount_value'];
    tariffDiscountIsPercent = json['tariff_discount_is_percent'];
    tariffDiscountTitle = json['tariff_discount_title'];
    tariffDiscountImage = json['tariff_discount_image'];
    studentBonusMoney = json['student_bonus_money'];
    if (json['objects'] != null) {
      objects = <Objects>[];
      json['objects'].forEach((v) {
        objects!.add(new Objects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['student_discount_value'] = this.studentDiscountValue;
    data['student_discount_is_percent'] = this.studentDiscountIsPercent;
    data['tariff_discount_value'] = this.tariffDiscountValue;
    data['tariff_discount_is_percent'] = this.tariffDiscountIsPercent;
    data['tariff_discount_title'] = this.tariffDiscountTitle;
    data['tariff_discount_image'] = this.tariffDiscountImage;
    data['student_bonus_money'] = this.studentBonusMoney;
    if (this.objects != null) {
      data['objects'] = this.objects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Objects {
  int? id;
  String? title;
  String? desc;
  num? days;
  num? price;
  bool? tariffDiscount;
  bool? studentDiscount;
  num? tariffDiscountAmount;
  num? studentDiscountAmount;

  Objects(
      {this.id,
        this.title,
        this.desc,
        this.days,
        this.price,
        this.tariffDiscount,
        this.studentDiscount,
        this.tariffDiscountAmount,
        this.studentDiscountAmount});

  Objects.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desc = json['desc'];
    days = json['days'];
    price = json['price'];
    tariffDiscount = json['tariff_discount'];
    studentDiscount = json['student_discount'];
    tariffDiscountAmount = json['tariff_discount_amount'];
    studentDiscountAmount = json['student_discount_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['days'] = this.days;
    data['price'] = this.price;
    data['tariff_discount'] = this.tariffDiscount;
    data['student_discount'] = this.studentDiscount;
    data['tariff_discount_amount'] = this.tariffDiscountAmount;
    data['student_discount_amount'] = this.studentDiscountAmount;
    return data;
  }
}

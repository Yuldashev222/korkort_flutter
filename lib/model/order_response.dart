class OrderResponse {
  int? count;
  List<Results>? results;

  OrderResponse({this.count, this.results});

  OrderResponse.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int? id;
  String? orderId;
  String? studentEmail;
  num? studentBonusAmount;
  bool? useBonusMoney;
  num? purchasedPrice;
  num? studentDiscountAmount;
  num? studentDiscountValue;
  bool? studentDiscountIsPercent;
  String? expireAt;
  String? createdAt;
  String? purchasedAt;
  bool? isPaid;
  String? paymentLink;
  String? tariffTitle;
  num? tariffPrice;
  num? tariffDays;
  String? tariffDiscountTitle;
  num? tariffDiscountAmount;
  num? tariffDiscountValue;
  bool? tariffDiscountIsPercent;
  String? calledStudentCode;
  String? calledStudentEmail;
  bool? calledStudentBonusAdded;
  num? tariff;
  num? calledStudent;

  Results(
      {this.id,
        this.orderId,
        this.studentEmail,
        this.studentBonusAmount,
        this.useBonusMoney,
        this.purchasedPrice,
        this.studentDiscountAmount,
        this.studentDiscountValue,
        this.studentDiscountIsPercent,
        this.expireAt,
        this.createdAt,
        this.purchasedAt,
        this.isPaid,
        this.paymentLink,
        this.tariffTitle,
        this.tariffPrice,
        this.tariffDays,
        this.tariffDiscountTitle,
        this.tariffDiscountAmount,
        this.tariffDiscountValue,
        this.tariffDiscountIsPercent,
        this.calledStudentCode,
        this.calledStudentEmail,
        this.calledStudentBonusAdded,
        this.tariff,
        this.calledStudent});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    studentEmail = json['student_email'];
    studentBonusAmount = json['student_bonus_amount'];
    useBonusMoney = json['use_bonus_money'];
    purchasedPrice = json['purchased_price'];
    studentDiscountAmount = json['student_discount_amount'];
    studentDiscountValue = json['student_discount_value'];
    studentDiscountIsPercent = json['student_discount_is_percent'];
    expireAt = json['expire_at'];
    createdAt = json['created_at'];
    purchasedAt = json['purchased_at'];
    isPaid = json['is_paid'];
    paymentLink = json['payment_link'];
    tariffTitle = json['tariff_title'];
    tariffPrice = json['tariff_price'];
    tariffDays = json['tariff_days'];
    tariffDiscountTitle = json['tariff_discount_title'];
    tariffDiscountAmount = json['tariff_discount_amount'];
    tariffDiscountValue = json['tariff_discount_value'];
    tariffDiscountIsPercent = json['tariff_discount_is_percent'];
    calledStudentCode = json['called_student_code'];
    calledStudentEmail = json['called_student_email'];
    calledStudentBonusAdded = json['called_student_bonus_added'];
    tariff = json['tariff'];
    calledStudent = json['called_student'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['student_email'] = this.studentEmail;
    data['student_bonus_amount'] = this.studentBonusAmount;
    data['use_bonus_money'] = this.useBonusMoney;
    data['purchased_price'] = this.purchasedPrice;
    data['student_discount_amount'] = this.studentDiscountAmount;
    data['student_discount_value'] = this.studentDiscountValue;
    data['student_discount_is_percent'] = this.studentDiscountIsPercent;
    data['expire_at'] = this.expireAt;
    data['created_at'] = this.createdAt;
    data['purchased_at'] = this.purchasedAt;
    data['is_paid'] = this.isPaid;
    data['payment_link'] = this.paymentLink;
    data['tariff_title'] = this.tariffTitle;
    data['tariff_price'] = this.tariffPrice;
    data['tariff_days'] = this.tariffDays;
    data['tariff_discount_title'] = this.tariffDiscountTitle;
    data['tariff_discount_amount'] = this.tariffDiscountAmount;
    data['tariff_discount_value'] = this.tariffDiscountValue;
    data['tariff_discount_is_percent'] = this.tariffDiscountIsPercent;
    data['called_student_code'] = this.calledStudentCode;
    data['called_student_email'] = this.calledStudentEmail;
    data['called_student_bonus_added'] = this.calledStudentBonusAdded;
    data['tariff'] = this.tariff;
    data['called_student'] = this.calledStudent;
    return data;
  }
}

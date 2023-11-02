class CheckOrderResponse {
  num? id;
  String? orderId;
  String? studentEmail;
  num? studentBonusAmount;
  double? studentDiscountAmount;
  num? studentDiscountValue;
  bool? studentDiscountIsPercent;
  dynamic expireAt;
  dynamic purchasedAt;
  String? createdAt;
  bool? isPaid;
  bool? useBonusMoney;
  String? paymentLink;
  String? tariffTitle;
  num? tariffPrice;
  num? tariffDay;
  String? tariffDiscountTitle;
  num? tariffDiscountAmount;
  num? tariffDiscountValue;
  bool? tariffDiscountIsPercent;
  String? calledStudentCode;
  String? calledStudentEmail;
  bool? calledStudentBonusAdded;
  num? tariff;
  num? tariffDiscount;
  num? calledStudent;

  CheckOrderResponse(
      {this.id,
        this.orderId,
        this.studentEmail,
        this.studentBonusAmount,
        this.studentDiscountAmount,
        this.studentDiscountValue,
        this.studentDiscountIsPercent,
        this.expireAt,
        this.purchasedAt,
        this.createdAt,
        this.isPaid,
        this.useBonusMoney,
        this.paymentLink,
        this.tariffTitle,
        this.tariffPrice,
        this.tariffDay,
        this.tariffDiscountTitle,
        this.tariffDiscountAmount,
        this.tariffDiscountValue,
        this.tariffDiscountIsPercent,
        this.calledStudentCode,
        this.calledStudentEmail,
        this.calledStudentBonusAdded,
        this.tariff,
        this.tariffDiscount,
        this.calledStudent});

  CheckOrderResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    studentEmail = json['student_email'];
    studentBonusAmount = json['student_bonus_amount'];
    studentDiscountAmount = json['student_discount_amount'];
    studentDiscountValue = json['student_discount_value'];
    studentDiscountIsPercent = json['student_discount_is_percent'];
    expireAt = json['expire_at'];
    purchasedAt = json['purchased_at'];
    createdAt = json['created_at'];
    isPaid = json['is_paid'];
    useBonusMoney = json['use_bonus_money'];
    paymentLink = json['payment_link'];
    tariffTitle = json['tariff_title'];
    tariffPrice = json['tariff_price'];
    tariffDay = json['tariff_day'];
    tariffDiscountTitle = json['tariff_discount_title'];
    tariffDiscountAmount = json['tariff_discount_amount'];
    tariffDiscountValue = json['tariff_discount_value'];
    tariffDiscountIsPercent = json['tariff_discount_is_percent'];
    calledStudentCode = json['called_student_code'];
    calledStudentEmail = json['called_student_email'];
    calledStudentBonusAdded = json['called_student_bonus_added'];
    tariff = json['tariff'];
    tariffDiscount = json['tariff_discount'];
    calledStudent = json['called_student'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['order_id'] = orderId;
    data['student_email'] = studentEmail;
    data['student_bonus_amount'] = studentBonusAmount;
    data['student_discount_amount'] = studentDiscountAmount;
    data['student_discount_value'] = studentDiscountValue;
    data['student_discount_is_percent'] = studentDiscountIsPercent;
    data['expire_at'] = expireAt;
    data['purchased_at'] = purchasedAt;
    data['created_at'] = createdAt;
    data['is_paid'] = isPaid;
    data['use_bonus_money'] = useBonusMoney;
    data['payment_link'] = paymentLink;
    data['tariff_title'] = tariffTitle;
    data['tariff_price'] = tariffPrice;
    data['tariff_day'] = tariffDay;
    data['tariff_discount_title'] = tariffDiscountTitle;
    data['tariff_discount_amount'] = tariffDiscountAmount;
    data['tariff_discount_value'] = tariffDiscountValue;
    data['tariff_discount_is_percent'] = tariffDiscountIsPercent;
    data['called_student_code'] = calledStudentCode;
    data['called_student_email'] = calledStudentEmail;
    data['called_student_bonus_added'] = calledStudentBonusAdded;
    data['tariff'] = tariff;
    data['tariff_discount'] = tariffDiscount;
    data['called_student'] = calledStudent;
    return data;
  }
}

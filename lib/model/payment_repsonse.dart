  class PaymentCreateResponse {
  String? checkoutUrl;
  bool? isPaid;

  PaymentCreateResponse({this.checkoutUrl, this.isPaid});

  PaymentCreateResponse.fromJson(Map<String, dynamic> json) {
    checkoutUrl = json['checkout_url'];
    isPaid = json['is_paid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['checkout_url'] = checkoutUrl;
    data['is_paid'] = isPaid;
    return data;
  }
}

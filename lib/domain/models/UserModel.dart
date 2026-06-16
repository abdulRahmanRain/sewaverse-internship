class UserModel {
  final String orderId;
  final String orderDate;
  final String customerId;
  final String customerName;
  final String productId;
  final String productName;
  final String category;
  final String brand;
  final int quantity;
  final double unitPrice;
  final double discount;
  final double tax;
  final double shippingCost;
  final double totalAmount;
  final String paymentMethod;
  final String orderStatus;
  final String city;
  final String state;
  final String country;
  final String sellerId;

  UserModel({
    required this.orderId,
    required this.orderDate,
    required this.customerId,
    required this.customerName,
    required this.productId,
    required this.productName,
    required this.category,
    required this.brand,
    required this.quantity,
    required this.unitPrice,
    required this.discount,
    required this.tax,
    required this.shippingCost,
    required this.totalAmount,
    required this.paymentMethod,
    required this.orderStatus,
    required this.city,
    required this.state,
    required this.country,
    required this.sellerId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      orderId: json["OrderID"],
      orderDate: json["OrderDate"],
      customerId: json["CustomerID"],
      customerName: json["CustomerName"],
      productId: json["ProductID"],
      productName: json["ProductName"],
      category: json["Category"],
      brand: json["Brand"],
      quantity: int.parse(json["Quantity"].toString()),
      unitPrice: double.parse(json["UnitPrice"].toString()),
      discount: double.parse(json["Discount"].toString()),
      tax: double.parse(json["Tax"].toString()),
      shippingCost: double.parse(json["ShippingCost"].toString()),
      totalAmount: double.parse(json["TotalAmount"].toString()),
      paymentMethod: json["PaymentMethod"],
      orderStatus: json["OrderStatus"],
      city: json["City"],
      state: json["State"],
      country: json["Country"],
      sellerId: json["SellerID"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "OrderID": orderId,
      "OrderDate": orderDate,
      "CustomerID": customerId,
      "CustomerName": customerName,
      "ProductID": productId,
      "ProductName": productName,
      "Category": category,
      "Brand": brand,
      "Quantity": quantity,
      "UnitPrice": unitPrice,
      "Discount": discount,
      "Tax": tax,
      "ShippingCost": shippingCost,
      "TotalAmount": totalAmount,
      "PaymentMethod": paymentMethod,
      "OrderStatus": orderStatus,
      "City": city,
      "State": state,
      "Country": country,
      "SellerID": sellerId,
    };
  }
}
class UserModel {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? email;
  String? firstName;
  String? lastName;
  String? billingAddressId;
  String? phone;
  bool? hasAccount;
  String? metadata;
  List<String>? orders;
  List<String>? shippingAddresses;

  UserModel(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.email,
      this.firstName,
      this.lastName,
      this.billingAddressId,
      this.phone,
      this.hasAccount,
      this.metadata,
      this.orders,
      this.shippingAddresses});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    billingAddressId = json['billing_address_id'];
    phone = json['phone'];
    hasAccount = json['has_account'];
    metadata = json['metadata'];
    if (json['orders'] != null) {
      orders = <String>[];
      json['orders'].forEach((v) {
        orders!.add(v);
      });
    }
    if (json['shipping_addresses'] != null) {
      shippingAddresses = <String>[];
      json['shipping_addresses'].forEach((v) {
        shippingAddresses!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['billing_address_id'] = this.billingAddressId;
    data['phone'] = this.phone;
    data['has_account'] = this.hasAccount;
    data['metadata'] = this.metadata;
    if (this.orders != null) {
      data['orders'] = this.orders!.map((v) => v).toList();
    }
    if (this.shippingAddresses != null) {
      data['shipping_addresses'] =
          this.shippingAddresses!.map((v) => v).toList();
    }
    return data;
  }
}

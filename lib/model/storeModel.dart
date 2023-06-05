class StoreModel {
  String? title;
  String? email;
  String? description;
  String? address;
  String? zipcode;
  String? phone;
  double? latitude;
  double? longitude;
  String? handle;
  String? status;
  String? image;
  bool? drivethru;
  bool? wifiaccess;
  String? id;
  String? createdAt;
  String? updatedAt;

  StoreModel(
      {this.title,
      this.email,
      this.description,
      this.address,
      this.zipcode,
      this.phone,
      this.latitude,
      this.longitude,
      this.handle,
      this.status,
      this.image,
      this.drivethru,
      this.wifiaccess,
      this.id,
      this.createdAt,
      this.updatedAt});

  StoreModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    email = json['email'];
    description = json['description'];
    address = json['address'];
    zipcode = json['zipcode'];
    phone = json['phone'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    handle = json['handle'];
    status = json['status'];
    image = json['image'];
    drivethru = json['drivethru'];
    wifiaccess = json['wifiaccess'];
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['email'] = this.email;
    data['description'] = this.description;
    data['address'] = this.address;
    data['zipcode'] = this.zipcode;
    data['phone'] = this.phone;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['handle'] = this.handle;
    data['status'] = this.status;
    data['image'] = this.image;
    data['drivethru'] = this.drivethru;
    data['wifiaccess'] = this.wifiaccess;
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

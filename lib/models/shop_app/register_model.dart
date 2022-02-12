class shopRegisterModel{
  String? name;
  String? phone;
  String? email;
  String? password;
  String? image;
  shopRegisterModel.fromJson(Map<String, dynamic>json){
  name=json['name'];
  phone=json['phone'];
  email=json['email'];
  password=json['password'];
  image=json['image'];
  }
}
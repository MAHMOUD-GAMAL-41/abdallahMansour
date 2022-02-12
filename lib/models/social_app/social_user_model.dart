class socialUserModel {
String? name;
  String? email;
  String? phone;
  String? password;
  String? uId;
  String? bio;
  String? image;
  String? cover;
  bool? isEmailVerified;

  socialUserModel({
     this.phone,
     this.password,
     this.email,
     this.name,
     this.uId,
     this.bio,
     this.image,
     this.cover,
     this.isEmailVerified,
  });

  socialUserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    bio = json['bio'];
    image = json['image'];
    cover = json['cover'];
    password = json['password'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'bio': bio,
      'image': image,
      'cover': cover,
      'password': password,
      'isEmailVerified': isEmailVerified,
    };
  }
}

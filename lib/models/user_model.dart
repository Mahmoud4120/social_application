class SocialUserModel {
  String? email;
  String? phone;
  String? name;
  String? uId;
  String? image;
  String? bio;
  String? cover;
  bool? isEmailVerified;
  SocialUserModel(
      { this.name,
       this.email,
       this.phone,
       this.uId,
       this.image,
       this.bio,
         this.cover,
       this.isEmailVerified});
  SocialUserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phone = json['phone'];
    name = json['name'];
    uId = json['uId'];
    bio = json['bio'];
    image = json['image'];
    cover = json['cover'];
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
      'cover' : cover,
      'isEmailVerified': isEmailVerified
    };
  }
}

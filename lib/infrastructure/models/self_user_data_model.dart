import 'package:la27mobile/domain/entities/self_user_data.dart';

class SelfUserDataModel {
  final String userId;
  final String userName;
  final String demonName;
  final String? profilePicture;
  final String? banner;
  final String? description;
  final int? pinnedTuipId;
  final String createdAt;
  final String? birthday;
  final int followers;
  final int following;
  final int tuipsCount;
  final int likesCount;

  SelfUserDataModel({
    required this.userId,
    required this.userName,
    required this.demonName,
    this.profilePicture,
    this.banner,
    this.description,
    required this.pinnedTuipId,
    required this.createdAt,
    this.birthday,
    required this.followers,
    required this.following,
    required this.tuipsCount,
    required this.likesCount,
  });

  factory SelfUserDataModel.fromJson(Map<String, dynamic> json) =>
      SelfUserDataModel(
        userId: json['userId'],
        userName: json['userName'],
        demonName: json['demonName'],
        profilePicture: json['profilePicture'],
        banner: json['banner'],
        description: json['description'],
        pinnedTuipId: json['pinnedTuipId'],
        createdAt: json['createdAt'],
        birthday: json['birthday'],
        followers: json['followers'],
        following: json['following'],
        tuipsCount: json['tuipsCount'],
        likesCount: json['likesCount'],
      );

  SelfUserData toSelfUserDataEntity() => SelfUserData(
        userId: userId,
        userName: userName,
        demonName: demonName,
        profilePicture: profilePicture,
        banner: banner,
        description: description,
        pinnedTuipId: pinnedTuipId,
        createdAt: createdAt,
        birthday: birthday,
        followers: followers,
        following: following,
        tuipsCount: tuipsCount,
        likesCount: likesCount,
      );
}

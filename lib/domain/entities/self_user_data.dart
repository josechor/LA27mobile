class SelfUserData {
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

  SelfUserData({
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
}

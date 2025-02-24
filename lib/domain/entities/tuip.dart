class Tuip {
  final String demondId;
  final String demonName;
  final int? parent;
  final String? profilePicture;
  final int? quoting;
  final int quotingCount;
  final int responsesCount;
  final int? secta;
  final int likesCount;
  final String tuipContent;
  final String tuipCreatedAt;
  final int tuipId;
  final List<String> tuipMultimedia;
  final String userName;
  final int youLiked;
  final Tuip? parentData;
  final Tuip? quotingData;

  Tuip({
    required this.demondId,
    required this.demonName,
    this.parent,
    this.profilePicture,
    this.quoting,
    required this.quotingCount,
    required this.responsesCount,
    this.secta,
    required this.likesCount,
    required this.tuipContent,
    required this.tuipCreatedAt,
    required this.tuipId,
    required this.tuipMultimedia,
    required this.userName,
    required this.youLiked,
    required this.parentData,
    required this.quotingData,
  });
}

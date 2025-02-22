import 'package:la27mobile/domain/entities/tuip.dart';

class TuipModel {
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

  TuipModel({
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
    this.parentData,
    this.quotingData,
  });

  factory TuipModel.fromJson(Map<String, dynamic> json) {
    try {
      return TuipModel(
        demondId: json['demonId'],
        demonName: json['demonName'],
        parent: json['parent'],
        profilePicture: json['profilePicture'],
        quoting: json['quoting'],
        quotingCount: json['quotingCount'],
        responsesCount: json['responsesCount'],
        secta: json['secta'],
        likesCount: json['likesCount'],
        tuipContent: json['tuipContent'],
        tuipCreatedAt: json['tuipCreatedAt'],
        tuipId: json['tuipId'],
        tuipMultimedia: List<String>.from(json['tuipMultimedia']),
        userName: json['userName'],
        youLiked: json['youLiked'],
        parentData: json['parentData'] != null
            ? TuipModel.fromJson(json['parentData']).toTuipEntity()
            : null,
        quotingData: json['quotingData'] != null
            ? TuipModel.fromJson(json['quotingData']).toTuipEntity()
            : null,
      );
    } catch (e) {
      throw Exception('Error parsing tuip model: $e');
    }
  }

  Tuip toTuipEntity() => Tuip(
        demondId: demondId,
        demonName: demonName,
        parent: parent,
        profilePicture: profilePicture,
        quoting: quoting,
        quotingCount: quotingCount,
        responsesCount: responsesCount,
        secta: secta,
        likesCount: likesCount,
        tuipContent: tuipContent,
        tuipCreatedAt: tuipCreatedAt,
        tuipId: tuipId,
        tuipMultimedia: tuipMultimedia,
        userName: userName,
        youLiked: youLiked,
        parentData: parentData,
        quotingData: quotingData,
      );
}

import 'package:la27mobile/infrastructure/datasources/tuips_datasource_imp.dart';
import 'package:la27mobile/infrastructure/repositories/tuips_repository_imp.dart';

class Tuip {
  final String demondId;
  final String demonName;
  final int? parent;
  final String? profilePicture;
  final int? quoting;
  final int quotingCount;
  final int responsesCount;
  final int? secta;
  int likesCount;
  final String tuipContent;
  final String tuipCreatedAt;
  final int tuipId;
  final List<String> tuipMultimedia;
  final String userName;
  int youLiked;
  final Tuip? parentData;
  final Tuip? quotingData;
  final TuipsRepositoryImp tuipsRepository =
      TuipsRepositoryImp(datasource: TuipsDatasourceImp());
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

// nombre en ingles que cambia de acuerdo a la accion

  Future<void> setLikeOrDislike() async {
    if (youLiked == 1) {
      await tuipsRepository.removeLike(tuipId: tuipId);
      youLiked = 0;
      likesCount--;
    } else {
      await tuipsRepository.setLike(tuipId: tuipId);
      youLiked = 1;
      likesCount++;
    }
  }
}

import 'dart:io';

class PostTuip {
  final String content;
  final List<File> media;
  final int? quoting;
  final int? secta;
  final int? parent;

  PostTuip(
      {required this.media,
      this.quoting,
      this.secta,
      this.parent,
      required this.content});
}

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:la27mobile/domain/entities/post_tuip.dart';
import 'package:la27mobile/infrastructure/datasources/tuips_datasource_imp.dart';
import 'package:la27mobile/infrastructure/repositories/tuips_repository_imp.dart';
import 'dart:io';

class PostTuipPage extends StatefulWidget {
  final String? replyingTo;
  final String? quoting;

  const PostTuipPage({super.key, this.replyingTo, this.quoting});

  @override
  PostTuipPageState createState() => PostTuipPageState();
}

class PostTuipPageState extends State<PostTuipPage> {
  final TextEditingController _tuipController = TextEditingController();
  final List<File> _mediaFiles = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> _pickMedia(ImageSource source, {bool isVideo = false}) async {
    final picker = ImagePicker();
    final pickedFile = isVideo
        ? await picker.pickVideo(source: source)
        : await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _mediaFiles.add(File(pickedFile.path));
      });
    }
  }

  void _sendTuip() async {
    final PostTuip tuip =
        PostTuip(media: _mediaFiles, content: _tuipController.text);
    final TuipsRepositoryImp tuipsRepository =
        TuipsRepositoryImp(datasource: TuipsDatasourceImp());
    await tuipsRepository.postTuip(tuip: tuip);
    _tuipController.clear();
    _mediaFiles.clear();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _tuipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escribir Tuip'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (widget.replyingTo != null)
              _TuipPreview(tuipText: widget.replyingTo!, isReply: true),
            TextField(
              controller: _tuipController,
              maxLines: null,
              maxLength: 254,
              decoration: InputDecoration(
                hintText: "¿Qué estás pensando?",
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey.shade400),
              ),
            ),
            if (widget.quoting != null)
              _TuipPreview(tuipText: widget.quoting!, isReply: false),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.photo),
                      onPressed: () => _pickMedia(ImageSource.gallery),
                    ),
                    IconButton(
                      icon: Icon(Icons.camera_alt),
                      onPressed: () => _pickMedia(ImageSource.camera),
                    ),
                    IconButton(
                      icon: Icon(Icons.videocam),
                      onPressed: () =>
                          _pickMedia(ImageSource.camera, isVideo: true),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendTuip,
                ),
              ],
            ),
            Wrap(
              children: _mediaFiles
                  .map((file) => Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.file(file,
                                width: 150, height: 150, fit: BoxFit.cover),
                          ),
                          Positioned(
                              right: 5,
                              top: 5,
                              child: IconButton.filled(
                                  style: ButtonStyle(
                                    fixedSize: WidgetStateProperty.all(
                                        Size.square(10)),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _mediaFiles.remove(file);
                                    });
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    size: 16,
                                  ))),
                        ],
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _TuipPreview extends StatelessWidget {
  final String tuipText;
  final bool isReply;

  const _TuipPreview({required this.tuipText, required this.isReply});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(isReply ? Icons.reply : Icons.format_quote, color: Colors.blue),
          SizedBox(width: 8),
          Expanded(
              child: Text(tuipText, style: TextStyle(color: Colors.black54))),
        ],
      ),
    );
  }
}

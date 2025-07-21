import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'repo/repository.dart';

class PreviewPage extends StatefulWidget {
  final String imageUrl;
  final int imageId;
  const PreviewPage({super.key, required this.imageId, required this.imageUrl});

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  Repository repo = Repository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: CachedNetworkImage(
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        imageUrl: widget.imageUrl,
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}

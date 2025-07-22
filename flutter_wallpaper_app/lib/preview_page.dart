import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_app/no_connection.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'repo/repository.dart';

class PreviewPage extends StatefulWidget {
  final String imageUrl;
  final int imageId;
  const PreviewPage({super.key, required this.imageId, required this.imageUrl});

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  StreamSubscription? _internetConnectionStreamSubscription;
  bool _isConnectedToInternet = true;

  void _checkInternetStatusOnce() async {
    final hasInternet = await InternetConnection().hasInternetAccess;
    print('Status awal internet: $hasInternet');
    setState(() {
      _isConnectedToInternet = hasInternet;
    });
  }

  @override
  void initState() {
    _checkInternetStatusOnce();
    _internetConnectionStreamSubscription = InternetConnection().onStatusChange
        .listen((status) {
          switch (status) {
            case InternetStatus.connected:
              setState(() {
                _isConnectedToInternet = true;
              });
              break;
            // case InternetStatus.disconnected:
            //   setState(() {
            //     isConnectedToInternet = false;
            //   });
            //   break;
            default:
              setState(() {
                _isConnectedToInternet = false;
              });
          }
        });
    super.initState();
  }

  @override
  void dispose() {
    _internetConnectionStreamSubscription?.cancel();
    super.dispose();
  }

  // Repository instance to handle image downloading
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
      body:
          !_isConnectedToInternet
              ? noConnection(context)
              : CachedNetworkImage(
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                imageUrl: widget.imageUrl,
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(230, 10, 10, .5),
        foregroundColor: const Color.fromRGBO(255, 255, 255, .8),
        shape: const CircleBorder(),
        onPressed: () {
          repo.downloadImage(
            imageUrl: widget.imageUrl,
            imageId: widget.imageId,
            context: context,
          );
        },
        child: const Icon(Icons.download),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

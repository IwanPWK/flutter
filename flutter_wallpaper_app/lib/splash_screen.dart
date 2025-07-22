import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_app/modal/modal.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'main_page.dart';
import 'no_connection.dart';
import 'repo/repository.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  Repository repo = Repository();
  StreamSubscription? _internetConnectionStreamSubscription;
  bool _isConnectedToInternet = true;
  int pageNumber = 1;
  late Future<List<Images>> imagesList;
  String splashImageUrl = '';

  late final AnimationController animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 5),
  );

  // late final animation = Tween(begin: 0.0, end: 1.0).animate(
  //   CurvedAnimation(
  //     parent: animationController,
  //     curve: Curves.easeIn,
  //   ),
  // );
  late final animation = Tween(
    begin: 0.0,
    end: 1.0,
  ).animate(animationController);

  void _navigator() async {
    await Future.delayed(const Duration(seconds: 10), () {});
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => MainPage()),
        (route) => false,
      );
    }
  }

  void _checkInternetStatusOnce() async {
    final hasInternet = await InternetConnection().hasInternetAccess;
    print('Status awal internet: $hasInternet');
    setState(() {
      _isConnectedToInternet = hasInternet;
    });
  }

  void _loadRandomSplashImage() async {
    _checkInternetStatusOnce();
    _internetConnectionStreamSubscription = InternetConnection().onStatusChange
        .listen((status) {
          print('Internet status SC: $status');
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
    imagesList = repo.getImagesList(pageNumber: pageNumber);
    await imagesList.then((list) {
      if (list.isNotEmpty) {
        final randomIndex = Random().nextInt(list.length);
        final randomImagePath = list[randomIndex].imagePotraitPath;

        // Gunakan nilai ini misalnya untuk background splash:
        setState(() {
          splashImageUrl = randomImagePath;
        });
      }
    });
    animationController.forward();
    _navigator();
  }

  @override
  void initState() {
    _loadRandomSplashImage();
    super.initState();
  }

  @override
  void dispose() {
    _internetConnectionStreamSubscription?.cancel();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          !_isConnectedToInternet
              ? noConnection(context)
              : Center(
                child: FadeTransition(
                  opacity: animation,
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                        imageUrl: splashImageUrl,
                        // placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget:
                            (context, url, error) => const Icon(Icons.error),
                      ),
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 40,
                              height: 40,
                              child: CircularProgressIndicator(
                                backgroundColor: const Color.fromARGB(
                                  91,
                                  255,
                                  255,
                                  255,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.8),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    "I'Wan+ Wallpaper App",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 50,
                        left: 0,
                        right: 0,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.6),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  "Powered by pexels.com",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.6),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  "Special thanks to\nCode Hub",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}

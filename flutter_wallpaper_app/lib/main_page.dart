import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'modal/modal.dart';
import 'no_connection.dart';
import 'preview_page.dart';
import 'repo/repository.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Repository repo = Repository();
  StreamSubscription? _internetConnectionStreamSubscription;
  bool _isConnectedToInternet = true;
  ScrollController scrollController = ScrollController();
  TextEditingController textEditingController = TextEditingController();
  late Future<List<Images>> imagesList;
  String searchQuery = '';
  int pageNumber = 1;
  final List<String> categories = [
    'Pharmacy',
    'Nature',
    'Abstract',
    'Technology',
    'Mountains',
    'Cars',
    'Bikes',
    'People',
  ];

  void getImagesBySearch({required String query, String pageQuery = '1'}) {
    imagesList = repo.getImagesBySearch(query: query, pageQuery: pageQuery);
    searchQuery = query;
    setState(() {});
  }

  void _checkInternetStatusOnce() async {
    final hasInternet = await InternetConnection().hasInternetAccess;
    print('Status awal internet: $hasInternet');
    setState(() {
      _isConnectedToInternet = hasInternet;
    });
  }

  Future<void> _handleRefresh() async {
    setState(() {
      imagesList = repo.getImagesList(pageNumber: 1);
      searchQuery = '';
    });
  }

  @override
  void initState() {
    _checkInternetStatusOnce();
    _internetConnectionStreamSubscription = InternetConnection().onStatusChange
        .listen((status) {
          print('Internet status: $status');
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
    searchQuery = '';
    super.initState();
  }

  @override
  void dispose() {
    _internetConnectionStreamSubscription?.cancel();
    textEditingController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "I'Wan+ ",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.deepOrangeAccent,
                fontSize: 22,
              ),
            ),
            Text(
              'Wallpaper',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.green,
                fontSize: 22,
              ),
            ),
            Text(
              'App',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.pink,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
      body:
          !_isConnectedToInternet
              ? noConnection(context)
              : LiquidPullToRefresh(
                onRefresh: _handleRefresh,
                color: Colors.deepOrange,
                height: MediaQuery.sizeOf(context).height,
                backgroundColor: Colors.green.shade600,
                child: SingleChildScrollView(
                  controller: scrollController,
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: textEditingController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 25),
                            labelText: 'Search',
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.blue,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: IconButton(
                                onPressed: () {
                                  getImagesBySearch(
                                    query: textEditingController.text,
                                  );
                                },
                                icon: const Icon(Icons.search),
                              ),
                            ),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp('[a-zA-Z0-9]'),
                            ),
                          ],
                          onSubmitted: (value) {
                            getImagesBySearch(query: value);
                          },

                          textInputAction: TextInputAction.search,
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: 40,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                getImagesBySearch(query: categories[index]);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 0,
                                    ),
                                    child: Center(
                                      child: Text(categories[index]),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      FutureBuilder(
                        future: imagesList,
                        builder: ((context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: Text(
                                  'Something went wrong: ${snapshot.error}',
                                ),
                              ),
                            );
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: Center(child: Text('No images found.')),
                            );
                          }

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                ),
                                child: MasonryGridView.count(
                                  controller: scrollController,
                                  itemCount: snapshot.data?.length,
                                  shrinkWrap: true,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5,
                                  crossAxisCount: 2,
                                  itemBuilder: (context, index) {
                                    double height = (index % 10 + 1) * 100;
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) => PreviewPage(
                                                  imageId:
                                                      snapshot
                                                          .data![index]
                                                          .imageID,
                                                  imageUrl:
                                                      snapshot
                                                          .data![index]
                                                          .imagePotraitPath,
                                                ),
                                          ),
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          height: height > 300 ? 300 : height,
                                          imageUrl:
                                              snapshot
                                                  .data![index]
                                                  .imagePotraitPath,
                                          errorWidget:
                                              (context, url, error) =>
                                                  const Icon(Icons.error),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                              MaterialButton(
                                minWidth: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20,
                                ),
                                color: Colors.blue,
                                textColor: Colors.white,
                                onPressed: () {
                                  pageNumber++;
                                  searchQuery.isNotEmpty
                                      ? imagesList = repo.getImagesBySearch(
                                        query: searchQuery,
                                        pageQuery: '$pageNumber',
                                      )
                                      : imagesList = repo.getImagesList(
                                        pageNumber: pageNumber,
                                      );

                                  setState(() {});
                                },
                                child: const Text('Load More'),
                              ),
                            ],
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}

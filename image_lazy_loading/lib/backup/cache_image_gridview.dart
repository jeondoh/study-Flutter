// main.dart
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _controller;
  final _baseUrl = 'https://jsonplaceholder.typicode.com/posts';
  final int _limit = 20;

  List _posts = [];
  int _page = 0;
  bool _isFirstLoadRunning = false;
  bool _hasNextPage = true;
  bool _isLoadMoreRunning = false;

  @override
  void initState() {
    super.initState();
    _firstLoad();
    _controller = ScrollController()..addListener(_loadMore);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fucking Lazy Loading',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _isFirstLoadRunning
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    itemCount: _posts.length,
                    controller: _controller,
                    cacheExtent: 500,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 320,
                      mainAxisSpacing: 17,
                      crossAxisSpacing: 16,
                    ),
                    itemBuilder: (_, index) {
                      String indexNumber =
                          (index + 1).toString().padLeft(4, '0');
                      print(indexNumber);
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 10,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              width: 200,
                              height: 200,
                              child: cachedImageNetwork(
                                key: indexNumber,
                                imgUrl:
                                    'http://10.10.100.107/res/resize/HanaTest4/HANA${indexNumber}.gif',
                              ),
                              // child: Image.network(
                              //   // 'http://10.10.100.107/res/nft/HanaTest/HANA${indexNumber}.gif',
                              //   'http://10.10.100.107/res/resize/HanaTest4/HANA${indexNumber}.gif',
                              //   key: ValueKey(index),
                              // ),
                            ),
                            ListTile(
                              title: Text(_posts[index]['title']),
                              // subtitle: Text(_posts[index]['body']),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                if (_isLoadMoreRunning == true)
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 40),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                if (_hasNextPage == false)
                  Container(
                    padding: const EdgeInsets.only(top: 30, bottom: 40),
                    color: Colors.amber,
                    child: const Center(
                      child: Text('You have fetched all of the content'),
                    ),
                  ),
              ],
            ),
    );
  }

  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });

    try {
      final res =
          await http.get(Uri.parse("$_baseUrl?_page=$_page&_limit=$_limit"));
      setState(() {
        _posts = json.decode(res.body);
      });
    } catch (err) {
      if (kDebugMode) {
        print('Something went wrong');
      }
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      _page += 1; // Increase _page by 1

      try {
        final res =
            await http.get(Uri.parse("$_baseUrl?_page=$_page&_limit=$_limit"));

        final List fetchedPosts = json.decode(res.body);
        if (fetchedPosts.isNotEmpty) {
          setState(() {
            _posts.addAll(fetchedPosts);
          });
        } else {
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        if (kDebugMode) {
          print('Something went wrong!');
        }
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  static GestureDetector cachedImageNetwork({
    required String imgUrl,
    required String key,
    GestureTapCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: imgUrl,
        width: 200,
        height: 200,
        cacheManager: CacheManager(
          Config(
            key,
            stalePeriod: const Duration(seconds: 10),
            maxNrOfCacheObjects: 50,
          ),
        ),
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CircularProgressIndicator(value: downloadProgress.progress),
        // placeholder: (context, url) => const Center(
        //   child: Center(
        //     child: CircularProgressIndicator(),
        //   ),
        // ),
      ),
    );
  }
}

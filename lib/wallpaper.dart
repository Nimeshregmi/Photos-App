import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:api_practice/fullscreen.dart';

class WallPaper extends StatefulWidget {
  const WallPaper({super.key});
  @override
  State<WallPaper> createState() => _WallPaperState();
}

class _WallPaperState extends State<WallPaper> {
  List images = [];
  int page = 1;
  @override
  initState() {
    super.initState();
    fetchApi();
  }

  fetchApi() async {
    await http.get(Uri.parse("https://api.pexels.com/v1/curated?per_page=80"),
        headers: {
          'Authorization':
              'e5b0gpJ6hbAgZ4AKwr4LpyphGaOBaGdBfkDeopHaW4DeErVk4gZDZboq'
        }).then((value) {
      Map result = jsonDecode(value.body);
      images = result['photos'];
      setState(() {});
    });
  }

  loadMore() async {
    page = page + 1;
    setState(() {});
    String url =
        'https://api.pexels.com/v1/curated?per_page=80&page=$page';
    await http.get(Uri.parse(url), headers: {
      'Authorization':
          'e5b0gpJ6hbAgZ4AKwr4LpyphGaOBaGdBfkDeopHaW4DeErVk4gZDZboq'
    }).then((value) {
      Map result = jsonDecode(value.body);
      images.addAll(result['photos']);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: GridView.builder(
            itemCount: images.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              childAspectRatio: 2 / 3,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            FullScreen(imgUrl: images[index]['src']['large2x']),
                      ));
                },
                child: Container(
                  color: Colors.white,
                  child: Image.network(images[index]['src']['portrait']),
                ),
              );
            },
          )),
          InkWell(
            onTap: () {
              loadMore();
            },
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.orange.shade300, width: 3),
                    color: Colors.grey),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .06,
                child: const Center(
                  child: Text(
                    'Load More',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                )),
          )
        ],
      ),
    );
  }
}

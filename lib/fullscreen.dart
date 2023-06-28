import 'package:flutter/material.dart';
// import 'package:';

class FullScreen extends StatefulWidget {
  final String imgUrl;

  const FullScreen({super.key, required this.imgUrl});

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(child: Container(
              child: Image.network(widget.imgUrl),
            )),
            InkWell(
            onTap: () {
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
                    'Set Walpaper',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                )),
          )
          ],
        ),
      ),
    );
  }
}

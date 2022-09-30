import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Upload extends StatelessWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
          color: Colors.black,
        ),
      ),
      body: Container(color: Colors.white),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:insta_clone/src/components/avatar_widget.dart';
import 'package:insta_clone/src/components/image_data.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  Widget _storyBoardList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          100,
          (index) => const AvatarWidget(
              type: AvatarType.TYPE1,
              thumbPath:
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdhYaYsDh1RdhNgNoxBJSEEe35kScKz-Apyg&usqp=CAU'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: ImageData(
          IconsPath.logo,
          width: 270,
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageData(
                IconsPath.directMessage,
                width: 50,
              ),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          _storyBoardList(),
          // _postList(),
        ],
      ),
    );
  }
}

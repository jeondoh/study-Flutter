import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone/src/components/avatar_widget.dart';
import 'package:insta_clone/src/components/image_data.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({Key? key}) : super(key: key);

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const AvatarWidget(
              type: AvatarType.TYPE3,
              nickname: 'jeondoh',
              size: 40,
              thumbPath:
                  'https://img.freepik.com/premium-photo/astronaut-in-outer-open-space-over-the-planet-earth-stars-provide-the-background-erforming-a-space-above-planet-earth-sunrise-sunset-our-home-iss-elements-of-this-image-furnished-by-nasa_150455-16829.jpg?w=2000'),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ImageData(
                IconsPath.postMoreIcon,
                width: 30,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _image() {
    return CachedNetworkImage(
        imageUrl:
            'https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg');
  }

  Widget _infoCount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ImageData(IconsPath.likeOffIcon, width: 65),
              const SizedBox(width: 15),
              ImageData(IconsPath.replyIcon, width: 60),
              const SizedBox(width: 15),
              ImageData(IconsPath.directMessage, width: 50),
            ],
          ),
          ImageData(IconsPath.bookMarkOffIcon, width: 50),
        ],
      ),
    );
  }

  Widget _infoDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '????????? 150???',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          ExpandableText(
            // ????????? ???????????? ?????? ??????(????????? ?????? ????????????)
            '???????????????.\n???????????????.\n???????????????.\n???????????????.\n???????????????.',
            prefixText: 'jeondoh', // ?????? ?????? ?????????
            prefixStyle:
                const TextStyle(fontWeight: FontWeight.bold), // prefix ?????????
            onPrefixTap: () {}, // prefix ????????? ?????????
            expandText: '?????????', // ????????? ????????? ??????
            collapseText: '??????', // ????????? ?????? ????????????
            expandOnTextTap: true, // ????????? ????????? ????????? ?????????
            collapseOnTextTap: true, // ????????? ????????? ?????? ?????????
            linkColor: Colors.grey, // ????????? & ?????? ?????? ???
            maxLines: 3, // ????????? ?????? ?????? ?????? ??????
          ),
        ],
      ),
    );
  }

  Widget _replyTextBtn() {
    return GestureDetector(
      onTap: () {},
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Text(
          '?????? 199??? ?????? ??????',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _dateAgo() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
        '1??????',
        style: TextStyle(color: Colors.grey, fontSize: 11),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _header(),
          const SizedBox(height: 15),
          _image(),
          const SizedBox(height: 15),
          _infoCount(),
          const SizedBox(height: 5),
          _infoDescription(),
          const SizedBox(height: 5),
          _replyTextBtn(),
          const SizedBox(height: 5),
          _dateAgo(),
        ],
      ),
    );
  }
}

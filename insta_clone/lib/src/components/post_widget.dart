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
            '좋아요 150개',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          ExpandableText(
            // 글자가 많을시에 라인 줄임(더보기 버튼 추가가능)
            '내용입니다.\n내용입니다.\n내용입니다.\n내용입니다.\n내용입니다.',
            prefixText: 'jeondoh', // 내용 이전 텍스트
            prefixStyle:
                const TextStyle(fontWeight: FontWeight.bold), // prefix 스타일
            onPrefixTap: () {}, // prefix 클릭시 이벤트
            expandText: '더보기', // 텍스트 더보기 버튼
            collapseText: '접기', // 더보기 이후 접기버튼
            expandOnTextTap: true, // 텍스트 클릭시 더보기 활성화
            collapseOnTextTap: true, // 텍스트 클릭시 접기 활성화
            linkColor: Colors.grey, // 더보기 & 접기 버튼 색
            maxLines: 3, // 더보기 버튼 생성 기준 라인
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
          '댓글 199개 모두 보기',
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
        '1일전',
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

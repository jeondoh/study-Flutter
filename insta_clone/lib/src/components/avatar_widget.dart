import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

enum AvatarType { TYPE1, TYPE2, TYPE3 }

class AvatarWidget extends StatelessWidget {
  final bool? hasStory;
  final String thumbPath;
  final String? nickname;
  final AvatarType type;
  final double? size;

  const AvatarWidget({
    Key? key,
    required this.type,
    required this.thumbPath,
    this.hasStory,
    this.nickname,
    this.size,
  }) : super(key: key);

  Widget type1Widget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.purple,
            Colors.orange,
          ],
        ),
        shape: BoxShape.circle,
      ),
      child: Container(
        // 그라데이션 이전 흰색 테두리 설정
        padding: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(65),
          child: SizedBox(
            width: 65,
            height: 65,
            child: CachedNetworkImage(
              imageUrl: thumbPath,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case AvatarType.TYPE1:
        return type1Widget();
      case AvatarType.TYPE2:
      case AvatarType.TYPE3:
        break;
    }
    return Container();
  }
}

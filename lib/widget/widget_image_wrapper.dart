import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter/common/resource_mananger.dart';

/// @Author: smarthane
/// @GitHub: https://github.com/smarthane
/// @Description:
/// @Date: 2020/11/29

enum ImageType {
  normal,
  random, //随机
  assets, //资源目录
}

class WrapperImage extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final BoxFit fit;
  final ImageType imageType;

  WrapperImage(
      {@required this.url,
      @required this.width,
      @required this.height,
      this.imageType: ImageType.normal,
      this.fit: BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      placeholder: (_, __) =>
          ResourceHelper.placeHolder(width: width, height: height),
      errorWidget: (_, __, ___) =>
          ResourceHelper.error(width: width, height: height),
      fit: fit,
    );
  }

  String get imageUrl {
    switch (imageType) {
      case ImageType.random:
        return ResourceHelper.randomUrl(
            key: url, width: width.toInt(), height: height.toInt());
      case ImageType.assets:
        return ResourceHelper.wrapAssets(url);
      case ImageType.normal:
        return url;
    }
    return url;
  }
}

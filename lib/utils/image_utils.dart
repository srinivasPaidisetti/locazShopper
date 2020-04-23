import 'package:flutter/material.dart';

enum IMAGE { ICON, BG_IMAGE, LOGO }

class ImageUtils {
  static Widget getImage({
    @required IMAGE imageType,
    @required dynamic imageName,
    Size size,
    Color color,
    BoxFit fit,
    double height,
    double width,
  }) {
    return Image.asset(
      _getImagePath(imageType, imageName),
      color: color,
      width: size?.width ?? width,
      height: size?.height ?? height,
      fit: fit,
    );
  }

  static Icon getMaterialIcon(IconData iconData, {Color color, double size}) {
    return Icon(
      iconData,
      color: color,
      size: size,
    );
  }

  static String _getImagePath(IMAGE imageType, String imageName) {
    switch (imageType) {
      case IMAGE.BG_IMAGE:
        return 'assets/images/bg/$imageName';
      case IMAGE.ICON:
        return 'assets/images/icons/$imageName';
      case IMAGE.LOGO:
        return 'assets/images/logo/$imageName';
      default:
        throw UnimplementedError();
    }
  }
}

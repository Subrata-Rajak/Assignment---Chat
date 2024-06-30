const String _images = "assets/images";
// const String _svgs = "assets/svgs";
// const String _anims = "assets/anims";
// const String _videos = "assets/videos";

class ImagePaths {
  static ImagePaths instance = ImagePaths();

  final String noInternetBgPath = "$_images/no_internet_bg.png";
}

class SvgPaths {
  static SvgPaths instance = SvgPaths();
}

class AnimPaths {
  static AnimPaths instance = AnimPaths();
}

class VideoPaths {
  static VideoPaths instance = VideoPaths();
}

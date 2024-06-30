import 'package:flutter/material.dart';

import '../../../../utils/assets_paths.dart';
import '../basics.dart';

class NoInterNet extends StatelessWidget with CommonWidgets {
  const NoInterNet({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xffF9F9FC),
      ),
      width: size.width,
      height: size.height,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(
              ImagePaths.instance.noInternetBgPath,
            ),
            width: 200,
            height: 200,
          ),
          verticalSpace(height: 10),
          const Text(
            "Oops!",
            style: TextStyle(
              color: Color(0xff27C57A),
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          verticalSpace(height: 80),
          const Text(
            "No Internet Connection",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          verticalSpace(height: 20),
          const Text(
            "Please check your internet connectivity and try again",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

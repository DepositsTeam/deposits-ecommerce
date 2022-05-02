import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class CustomSvgimage extends StatelessWidget {
  final String image;
  final Color? color;
  final double? height;
  final double? width;
  final BoxFit fit;
  const CustomSvgimage({
    Key? key,
    required this.image,
    this.color,
    this.height,
    this.width,
    this.fit = BoxFit.contain
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
     image,
     width: width,
     height: height,
     color: color,
     fit: fit,
     package: 'deposits_ecommerce');
  }
}
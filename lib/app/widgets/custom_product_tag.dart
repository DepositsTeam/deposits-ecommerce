import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class CustomProductTag extends StatelessWidget {
  final String text;
  final String status;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color containerColor, textColor;

  const CustomProductTag(
      {Key? key,
      required this.text,
      required this.containerColor,
      required this.textColor,
      this.fontWeight,
      this.fontSize,
      required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        child: Container(
          height: 35,
          color: containerColor,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(text,
                  style: TextStyle(
                      fontSize: fontSize??16.0,
                      fontWeight: fontWeight ?? FontWeight.w600,
                      color: textColor)),
            ),
          ),
        ),
      ),
    );
  }
}

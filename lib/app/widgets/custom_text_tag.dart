import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class CustomTextTag extends StatelessWidget {
  final String? text;
  final String? status;
  final double? width;
  final double? height;

  const CustomTextTag({Key? key, this.text, this.status,this.width,this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        child: Container(
          width: width??100,
          height: height??33,
          color: status == 'Available' ||
                  status == 'Completed' ||
                  status == 'active'
              ? AppColors.availableTagBackground
              : status == 'inactive'
                  ? AppColors.inActiveTagBackground
                  : AppColors.outOfStockTagBackground,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(text!.toTitleCase(),
                  style: TextStyle(
                      fontSize: 14.0,
                      color: status == 'Available' ||
                              status == 'Completed' ||
                              status == 'active'
                          ? AppColors.availableTagTextColor
                          : status == 'inactive'
                              ? AppColors.inActiveTagTextColor
                              : AppColors.outOfStockTagTextColor)),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:deposits_ecommerce/app/common/utils/exports.dart';
import 'package:flutter/gestures.dart';

class CustomRichTextWidget extends StatelessWidget {
  final String? title1, title2, title3, title4, title5, title6, title7;
  final Function()? onSubtitleTap2, onSubtitleTap4, onSubtitleTap6;
  final TextAlign textAlign;

  const CustomRichTextWidget({
    Key? key,
    this.title1,
    this.title2,
    this.title3,
    this.title4,
    this.title5,
    this.title6,
    this.title7,
    this.onSubtitleTap2,
    this.onSubtitleTap4,
    this.onSubtitleTap6,
    this.textAlign = TextAlign.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign,
      text: TextSpan(
        text: title1,
        style: AppTextStyle.regularStyle.copyWith(
          color: AppColors.mineShaft,
          fontSize: Dimens.fontSize14,
        ),
        children: [
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = onSubtitleTap2,
            text: ' $title2',
            style: AppTextStyle.regularStyle.copyWith(
                fontSize: Dimens.fontSize14, color: AppColors.activButtonColor()),
          ),
          TextSpan(
              text: ' $title3 ',
              style: AppTextStyle.regularStyle.copyWith(
                color: AppColors.mineShaft,
                fontSize: Dimens.fontSize14,
              )),
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = onSubtitleTap4,
            text: '$title4 ',
            style: AppTextStyle.regularStyle.copyWith(
                fontSize: Dimens.fontSize14, color: AppColors.activButtonColor()),
          ),
          TextSpan(
              text: title5,
              style: AppTextStyle.regularStyle.copyWith(
                color: AppColors.mineShaft,
                fontSize: Dimens.fontSize14,
              )),
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = onSubtitleTap6,
            text: ' $title6 ',
            style: AppTextStyle.regularStyle.copyWith(
                fontSize: Dimens.fontSize14, color: AppColors.activButtonColor()),
          ),
          TextSpan(
              text: title7,
              style: AppTextStyle.regularStyle.copyWith(
                color: AppColors.mineShaft,
                fontSize: Dimens.fontSize14,
              )),
        ],
      ),
    );
  }
}

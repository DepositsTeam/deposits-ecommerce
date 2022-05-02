import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class CustomListTileWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Widget? leading;
  final EdgeInsetsGeometry? contentPadding;

  const CustomListTileWidget({
    Key? key,
    required this.title,
    this.onTap,
    required this.subTitle,
    this.trailing,
    this.leading,
    this.contentPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: onTap,
        dense: false,
        hoverColor: Colors.transparent,
        tileColor: Colors.transparent,
        selectedTileColor: Colors.transparent,
        focusColor: Colors.transparent,
        contentPadding: contentPadding??
            const EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 0),
        title: Text(
          title,
          style: AppTextStyle.semiBoldStyle.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.w600,
            fontSize: Dimens.fontSize16,
          ),
        ),
        subtitle: subTitle.isNotEmpty
            ? Text(
                subTitle,
                style: AppTextStyle.semiBoldStyle.copyWith(
                  color: const Color(0xff8895A7),
                  fontWeight: FontWeight.w400,
                  fontSize: Dimens.fontSize14,
                ),
              )
            : null,
        leading: leading == null ? null : leading ?? const Icon(Icons.home_max),
        trailing: trailing == null ? null : trailing ?? const Icon(Icons.arrow_forward_ios_sharp),
      );
  }
}

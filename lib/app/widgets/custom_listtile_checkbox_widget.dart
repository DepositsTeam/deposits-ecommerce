import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class CustomListTileCheckBoxWidget extends StatefulWidget {
  final String title;
  final String subTitle;
  final VoidCallback onTap;
  final Widget? trailing;
  final Widget? leading;
  final EdgeInsetsGeometry? contentPadding;
  final ValueChanged<bool>? onSelect;
  final bool selector;

  const CustomListTileCheckBoxWidget({
    Key? key,
    required this.title,
    required this.onTap,
    required this.subTitle,
    this.trailing,
    this.leading,
    this.contentPadding,
    this.onSelect,
    this.selector = false,
  }) : super(key: key);

  @override
  State<CustomListTileCheckBoxWidget> createState() =>
      _CustomListTileCheckBoxWidgetState();
}

class _CustomListTileCheckBoxWidgetState
    extends State<CustomListTileCheckBoxWidget> {
  var switchSelector = false;

  switcher() {
    setState(() {
      switchSelector = !switchSelector;
      if (widget.onSelect != null) {
        widget.onSelect!(switchSelector);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 5),
          child: Row(
            children: [
              Expanded(
                  flex: 7,
                  child: Row(
                    children: [
                      //checker
                      if (widget.selector == true) ...[
                        switchSelector
                            ? InkWell(
                                onTap: switcher,
                                child: Container(
                                  width: 15.0,
                                  height: 15.0,
                                  alignment: Alignment.center,
                                  decoration:  BoxDecoration(
                                    color: AppColors.activButtonColor(),
                                  ),
                                  child: const Center(
                                      child: Icon(
                                    Icons.check,
                                    size: 15,
                                    color: AppColors.white,
                                  )),
                                ),
                              )
                            : InkWell(
                                onTap: switcher,
                                child: Container(
                                  width: 15.0,
                                  height: 15.0,
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    border: Border.all(
                                      width: 1.0,
                                      color: AppColors.black.withOpacity(.4),
                                    ),
                                  ),
                                ),
                              ),
                      ],
                      horizontalSpaceTiny,
                      //text and subtitle
                      InkWell(
                        onTap: widget.onTap,
                        child: Row(
                          children: [
                            widget.leading!,
                            horizontalSpaceTiny,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.title,
                                  overflow: TextOverflow.clip,
                                  softWrap: true,
                                  style: AppTextStyle.semiBoldStyle.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: Dimens.fontSize16,
                                  ),
                                ),
                                verticalSpaceTiny,
                                Text(
                                  widget.subTitle,
                                  style: AppTextStyle.semiBoldStyle.copyWith(
                                    color: AppColors.doveGray,
                                    fontWeight: FontWeight.w300,
                                    fontSize: Dimens.fontSize14,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
              Expanded(flex: 3, child: widget.trailing!)
            ],
          ),
        )
        );
  }
}

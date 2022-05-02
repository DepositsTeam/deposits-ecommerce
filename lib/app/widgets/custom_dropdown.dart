import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class DropdownWidget extends StatefulWidget {
  final List<String>? items;
  final ValueChanged<String>? itemCallBack;
  final String? currentItem;
  final String? hintText,title;
  final FormFieldValidator? validator;

 const DropdownWidget({
    Key? key,
    this.items,
    this.itemCallBack,
    this.currentItem,
    this.hintText,
    this.title,
    this.validator
  }): super(key: key);

  @override
  State<StatefulWidget> createState() => _DropdownState(currentItem!);
}

class _DropdownState extends State<DropdownWidget> {
  List<DropdownMenuItem<String>> dropDownItems = [];
  String currentItem;

  _DropdownState(this.currentItem);

  @override
  void initState() {
    super.initState();
    for (String item in widget.items!) {
      dropDownItems.add(DropdownMenuItem(
        value: item,
        child: Text(
          item,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyle.regularStyle.copyWith(
            fontSize:  Dimens.fontSize14,
            color: AppColors.mineShaft,
          ),
        )
      ));
    }
  }

  @override
  void didUpdateWidget(DropdownWidget oldWidget) {
    if (this.currentItem != widget.currentItem) {
      setState(() {
        this.currentItem = widget.currentItem!;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
            width: Get.width,
            child: DropdownButtonFormField(
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down_rounded,
              color: Color(0xFFC0C4C9),),
              value: currentItem,
              decoration: InputDecoration(
                hintText: widget.hintText ,
                labelText: widget.title,
                contentPadding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                border: const OutlineInputBorder() ,
                enabledBorder: const OutlineInputBorder(
                  borderSide:  BorderSide(color: AppColors.borderColor),
                ),
                disabledBorder: const OutlineInputBorder(
                  borderSide:  BorderSide(color: AppColors.borderColor),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide:  BorderSide(color: AppColors.borderColor),
                ),
                hintStyle: AppTextStyle.regularStyle.copyWith(
                  fontSize:  Dimens.fontSize14,
                  color: AppColors.mineShaft,
                ),
                floatingLabelBehavior: widget.currentItem == null || widget.currentItem == null
                    ? FloatingLabelBehavior.never
                    : FloatingLabelBehavior.always,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: widget.validator,
              onChanged: (selectedItem) => setState(() {
                  currentItem = selectedItem as String;
                  widget.itemCallBack!(currentItem);
                }),
              items: dropDownItems
            ),
          );
  }
}
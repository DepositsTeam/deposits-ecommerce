import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class CustomCheckboxWidget extends FormField<bool> {
  CustomCheckboxWidget({
    Key? key,
    required bool value,
    
    FormFieldSetter<bool>? onSaved,
    required Widget titleWidget,
  }) : super(
          key: key,
          initialValue: value,
          onSaved: onSaved,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          // validator: (v) => Validators.validateCheckbox(v: v!),
          builder: (state) {
            return CheckboxListTile(
              activeColor: AppColors.green,
              checkColor: AppColors.white,
              dense: state.hasError,
              value: state.value,
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: state.didChange,
              title: titleWidget,
              subtitle: state.hasError
                  ? Builder(
                      builder: (_) => Text(
                        state.errorText!,
                        style: TextStyle(color: Theme.of(_).errorColor),
                      ),
                    )
                  : null,
            );
          },
        );
}

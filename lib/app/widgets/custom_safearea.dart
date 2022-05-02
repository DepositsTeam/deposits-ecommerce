
import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class ColoredSafeArea extends StatelessWidget {
  final Widget child;
  final Color? color;

  const ColoredSafeArea({Key? key, required this.child, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? Theme.of(context).colorScheme.primaryVariant,
      child: SafeArea(
        child: child,
      ),
    );
  }
}
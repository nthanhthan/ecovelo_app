import 'package:flutter/cupertino.dart';

class OutsideUnfocus extends StatelessWidget {
  final Widget child;
  final BuildContext ctx;
  const OutsideUnfocus({Key? key, required this.ctx, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentScope = FocusScope.of(ctx);
        if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: child,
    );
  }
}

import 'package:flutter/material.dart';

class BehindKeyboardWidget extends StatefulWidget {
  const BehindKeyboardWidget({
    Key? key,
    required this.child,
    this.reversed = false,
    this.keepView = false,
    required this.context,
  }) : super(key: key);

  final Widget child;

  /// As default, view hide when keyboard opened.
  /// Set reversed = true, it'll reverse the logic.
  final bool reversed;

  /// if you want hide view but keep the layout, set keepView = true as default
  /// otherwise a view will dispose when keyboard opened
  /// Both mode support touch through below widget as well
  final bool keepView;

  final BuildContext context;

  @override
  _BehindKeyboardWidgetState createState() => _BehindKeyboardWidgetState();
}

class _BehindKeyboardWidgetState extends State<BehindKeyboardWidget> {
  bool _keyboardVisible = false;

  @override
  Widget build(BuildContext context) {
    _keyboardVisible = MediaQuery.of(widget.context).viewInsets.bottom != 0;
    final bool visible =
        !(widget.reversed ? !_keyboardVisible : _keyboardVisible);
    return widget.keepView
        ? Opacity(
            opacity: visible ? 1 : 0,
            child: IgnorePointer(
              ignoring: !visible,
              child: widget.child,
            ),
          )
        : Visibility(
            child: IgnorePointer(
              ignoring: !visible,
              child: widget.child,
            ),
            visible: visible,
          );
  }
}

import 'package:flutter/material.dart';

abstract class SwitchControler {
  void setValue(bool value);
}

// ignore: must_be_immutable
class CustomSwitch extends StatefulWidget implements SwitchControler {
  bool value;
  final Future<bool> Function(bool) onChanged;
  final Color activeColor;
  final Color inactiveColor;
  final Widget activeText;
  final Widget inactiveText;
  final Color activeTextColor;
  final Color inactiveTextColor;
  final Color borderColor;
  final double width;
  final double height;
  late final _CustomSwitchState _customSwitchState;

  CustomSwitch({Key? key, 
    required this.value,
    required this.onChanged,
    this.activeColor = Colors.green,
    this.inactiveColor = Colors.grey,
    this.activeText = const Text('On'),
    this.inactiveText = const Text('Off'),
    this.activeTextColor = Colors.white,
    this.inactiveTextColor = Colors.white,
    this.borderColor = Colors.white,
    this.width = 70,
    this.height = 35,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _CustomSwitchState createState() {
    _customSwitchState = _CustomSwitchState();
    return _customSwitchState;
  }

  @override
  void setValue(bool value) {
    _customSwitchState.setValue(value);
  }
}

class _CustomSwitchState extends State<CustomSwitch> with SingleTickerProviderStateMixin {
  late final Animation<Alignment> _circleAnimation;
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 60));
    _circleAnimation = AlignmentTween(
            begin: widget.value ? Alignment.centerRight : Alignment.centerLeft, end: widget.value ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(parent: _animationController, curve: Curves.linear));
  }

  void setValue(bool value) {
    if (_animationController.isCompleted) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
    setState(() {
      widget.value = !widget.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: () async {
            bool result = await widget.onChanged(widget.value);
            if (result) {
              if (_animationController.isCompleted) {
                _animationController.reverse();
              } else {
                _animationController.forward();
              }
              setState(() {
                widget.value = !widget.value;
              });
            }
          },
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: _circleAnimation.value == Alignment.centerLeft ? widget.inactiveColor : widget.activeColor,
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.black45,
                //     offset: Offset(0.3, 0.2),
                //     blurRadius: 1.0,
                //     spreadRadius: 1.0,
                //   ),
                // ],
                border: Border.all(color: widget.borderColor)),
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 4.0, right: 4.0, left: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _circleAnimation.value == Alignment.centerRight
                      ? Expanded(
                          child: Padding(padding: const EdgeInsets.only(left: 4.0, right: 4.0), child: widget.activeText),
                        )
                      : Container(),
                  Align(
                    alignment: _circleAnimation.value,
                    child: Container(
                      width: widget.height - 10,
                      height: widget.height - 10,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.black45,
                          //     offset: Offset(0.3, 0.2),
                          //     blurRadius: 1.0,
                          //     spreadRadius: 1.0,
                          //   ),
                          // ],
                          border: Border.all(color: widget.borderColor)),
                    ),
                  ),
                  _circleAnimation.value == Alignment.centerLeft
                      ? Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                            child: widget.inactiveText,
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

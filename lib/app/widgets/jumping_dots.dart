import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';


const _kVerticalOffset = -6.0;

class JumpingDots extends StatefulWidget {
  final int numberOfDots;
  final Color color;
  final double size;
  final Duration animationDuration;

  const JumpingDots({
    Key? key,
    this.numberOfDots = 3,
    this.size = 5,
    this.animationDuration = AppProperties.defaultAnimatedDuration,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  _JumpingDotsState createState() => _JumpingDotsState();
}

class _JumpingDotsState extends State<JumpingDots>
    with TickerProviderStateMixin {
  List<AnimationController>? _animationControllers;
  final List<Animation<double>> _animations = [];

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  @override
  void dispose() {
    for (var controller in _animationControllers!) {
      controller.dispose();
    }
    super.dispose();
  }

  void _initAnimation() {
    _animationControllers = List.generate(
      widget.numberOfDots,
      (index) {
        return AnimationController(
          vsync: this,
          duration: widget.animationDuration,
        );
      },
    ).toList();

    for (int i = 0; i < widget.numberOfDots; i++) {
      _animations.add(Tween<double>(begin: 0, end: _kVerticalOffset)
          .animate(_animationControllers![i]));
    }

    for (int i = 0; i < widget.numberOfDots; i++) {
      _animationControllers?[i].addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationControllers?[i].reverse();
          if (i != widget.numberOfDots - 1) {
            _animationControllers?[i + 1].forward();
          }
        }
        if (i == widget.numberOfDots - 1 &&
            status == AnimationStatus.dismissed) {
          _animationControllers?[0].forward();
        }
      });
    }
    _animationControllers?.first.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4, 7.5, 0, 7.5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.numberOfDots, (index) {
            return AnimatedBuilder(
              animation: _animationControllers![index],
              builder: (context, child) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Transform.translate(
                    offset: Offset(0, _animations[index].value),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.color,
                      ),
                      height: widget.size,
                      width: widget.size,
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

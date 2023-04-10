import 'package:flutter/material.dart';

class HeaderContents extends StatelessWidget {
  final Widget body;
  const HeaderContents({Key? key, this.body = const SizedBox()}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      children: [
        Container(
          width: double.infinity,
          height: 36,
          color: Theme.of(context).bottomAppBarColor,
        ),
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(100),
            topRight: Radius.circular(100),
          ),
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            height: 40,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10, left: 30, right: 30),
          child: body,
        ),
      ],
    );
  }
}

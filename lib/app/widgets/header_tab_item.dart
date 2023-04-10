import 'package:flutter/material.dart';

class HeaderTabItem extends StatelessWidget {
  final String title;
  final Widget leadingIcon;
  final Widget? badge;
  const HeaderTabItem({Key? key, 
    required this.title,
    required this.leadingIcon,
    this.badge,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        children: <Widget>[
          const SizedBox(
            width: 3,
          ),
          leadingIcon,
          const SizedBox(
            width: 6,
          ),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          badge ?? const SizedBox.shrink(),
          // ClipOval(
          //   child: Container(
          //     width: 30,
          //     height: 30,
          //     color: ColorConst.GRAY_MEDIUM,
          //     padding: EdgeInsets.all(5),
          //     child: Center(
          //       child: Text(
          //         "$noRecord",
          //         style: TextStyle(
          //           color: Colors.white,
          //         ),
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}

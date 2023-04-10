
import 'package:flutter/material.dart';

class NoDataLoaded extends StatelessWidget {
  final Color backgroundColor;
  final Color iconColor;
  final Color messageColor;
  final String? message;
  final IconData icon;

  const NoDataLoaded({Key? key, 
    this.backgroundColor = const Color(0xFFe2e6e9),
    this.icon = Icons.layers_clear,
    this.iconColor = const Color(0xFF9ba5af),
    this.message,
    this.messageColor = const Color(0xFF9ba5af),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(5),
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(100),
                  topRight: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                ),
                color: backgroundColor,
              ),
              child: ClipOval(
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 40,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(color: backgroundColor),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(100),
                  bottomLeft: Radius.circular(100),
                  topRight: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                ),
                color: Colors.white54,
              ),
              child: Text(
                message ?? "You have no items",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: messageColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

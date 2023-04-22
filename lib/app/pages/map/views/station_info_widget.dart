import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StationInfoWidget extends StatelessWidget {
  final StationModel station;

  const StationInfoWidget({required this.station, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.grey.shade300),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: SvgPicture.asset(AssetsConst.iconLocation)),
            const SizedBox(
              width: 56,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  station.address ?? '',
                  style: TextStyle(
                    color: AppColors.main.shade200,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

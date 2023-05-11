import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class JourneyDetailView extends GetView<JourneyDetailConroller> {
  const JourneyDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _builbody(context);
  }

  Widget _builbody(BuildContext context) {
    _showBottomSheet(context);
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.defaultBackground,
      appBar: AppBar(
        backgroundColor: AppColors.defaultBackground,
        title: Text(
          S.of(context).journeyDetail,
          style: AppTextStyles.subHeading1().copyWith(
            color: AppColors.colorText,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back,
            size: 30,
            color: Color(0xff28303f),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: InkWell(
          onTap: () {
            _showBottomSheet(context);  
          },
          child: Container(
            height: 50,
            margin: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 10,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: AppColors.main.shade200,
              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.center,
            child: Text(
              S.of(context).detail,
              style: AppTextStyles.body1().copyWith(
                color: AppColors.main.shade400,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
      body: const GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(16.0706181, 108.2240623),
          zoom: 12,
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: AppColors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          builder: (BuildContext context) {
            return ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.6,
                ),
                child: _gridAnalysis(context));
          },
        );
      },
    );
  }

  Widget _gridAnalysis(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 5,
              width: 40,
              decoration: BoxDecoration(
                color: AppColors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _itemAnalysis(
                        context,
                        AssetsConst.iconDistanceGreen,
                        S.of(context).totalDistances,
                        "19",
                        "km",
                      ),
                      _itemAnalysis(
                        context,
                        AssetsConst.iconClock,
                        S.of(context).totalTime,
                        "300",
                        "minutes",
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _itemAnalysis(
                        context,
                        AssetsConst.iconCarbon,
                        S.of(context).carbon,
                        "0.8",
                        "kg",
                      ),
                      _itemAnalysis(
                        context,
                        AssetsConst.iconEnrgy,
                        S.of(context).energy,
                        "200",
                        "kcal",
                      ),
                    ],
                  ),
                ),
              ],
            ),
            _itineraryWidget(context),
            Column(
              children: [
                _detailJourney(
                  context,
                  S.of(context).titleTime,
                  "07:30 - 08:30 o 01 May 2023",
                ),
                _detailJourney(
                  context,
                  S.of(context).titleJourneyCode,
                  "#011100110",
                ),
                _detailJourney(
                  context,
                  S.of(context).titlePayment,
                  "Ride Pass",
                ),
              ],
            ),
            _bottomButton(context),
          ],
        ),
      ),
    );
  }

  Widget _bottomButton(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: AppColors.main.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            S.of(context).shareJourney,
            style: AppTextStyles.body1().copyWith(
              color: AppColors.main.shade400,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 10),
          Icon(
            Icons.share,
            color: AppColors.main.shade400,
          ),
        ],
      ),
    );
  }

  Widget _itineraryWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SvgPicture.asset(AssetsConst.fromTo),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _containerItinerary(
                context,
                "ECO 01 - Hodfords - 74 Do Ba",
              ),
              _containerItinerary(
                context,
                "ECO 02 - Son Tra 01 - 06 Bui Quoc Hung",
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _containerItinerary(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: AppColors.grey.shade200,
            width: 1,
          ),
        ),
        color: AppColors.grey.shade600,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
          child: SizedBox(
            width: 290,
            child: Text(
              text,
              style: AppTextStyles.body2().copyWith(
                color: AppColors.grey.shade500,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _itemAnalysis(
    BuildContext context,
    String icon,
    String text,
    String number,
    String unit,
  ) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: OutlinedButton(
        onPressed: null,
        style: OutlineButtonStyle.enable(
          sizeType: SizeButtonType.custom,
          customPadding: const EdgeInsets.fromLTRB(12, 15, 5, 15),
          outlineColor: AppColors.grey.shade100,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: AppColors.main.shade400,
                borderRadius: BorderRadius.circular(7),
              ),
              child: SvgPicture.asset(icon),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: AppTextStyles.tiny().copyWith(
                      color: AppColors.grey.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        number,
                        style: AppTextStyles.body1()
                            .copyWith(color: AppColors.main.shade200),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        unit,
                        style: AppTextStyles.tiny().copyWith(
                          color: AppColors.grey.shade300,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _detailJourney(
    BuildContext context,
    String title,
    String des,
  ) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.tiny().copyWith(
              color: AppColors.grey.shade500,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            des,
            style: AppTextStyles.tiny().copyWith(
              color: AppColors.grey.shade400,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

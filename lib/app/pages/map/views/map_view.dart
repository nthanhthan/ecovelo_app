import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MapView extends GetView<MapController> {
  const MapView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LimitedScaleFactor(
      child: _buildBody(context),
    );
  }

  void _onGoClicked() {
    controller.goClick();
  }

  void _onChooseSuggestFacility(StationModel station) {
    controller.chooseStation(station);
  }

  void _onChangeSearch(String text) {
    if (text.isEmpty || text.trim().isEmpty) {}
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultBackground,
      body: Stack(
        children: [
          Obx(
            () => controller.isLoading
                ? GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        controller.myMarkers.first.position.latitude,
                        controller.myMarkers.first.position.longitude,
                      ),
                      zoom: 13,
                    ),
                    markers: controller.myMarkers,
                  )
                : const GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(16.0706181, 108.2240623),
                      zoom: 15,
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 60,
              left: 12,
              right: 12,
            ),
            child: SearchInput<StationModel>(
              searchController: controller.stationTextController,
              searchFocus: controller.searchNode,
              labelText: S.of(context).lableSearch,
              suggestionsCallback: (pattern) async {
                return await controller.loadListStation(pattern);
              },
              onSuggestionSelected: _onChooseSuggestFacility,
              onChanged: _onChangeSearch,
              itemBuilder: (context, station) {
                return ListTile(
                  key: ValueKey(station.stationId),
                  title: StationInfoWidget(station: station),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void showBottomSheet(
    BuildContext context,
    StationModel station,
  ) {
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
                maxHeight: MediaQuery.of(context).size.height * 0.7,
              ),
              child: _contentShowBottom(context, station),
            );
          },
        );
      },
    );
  }

  Widget _contentShowBottom(
    BuildContext context,
    StationModel station,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 5,
                width: 40,
                decoration: BoxDecoration(
                  color: AppColors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              S.of(context).stationNumber(station.stationId ?? ""),
              style: AppTextStyles.subHeading1()
                  .copyWith(color: AppColors.grey.shade500),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Image.asset(
                      AssetsConst.bikeStation,
                      height: 130,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    children: [
                      Text(
                        controller.checkBikeLeft(station.numBicycle ?? 0)
                            ? S.of(context).ready
                            : S.of(context).noBike,
                        style: AppTextStyles.body1()
                            .copyWith(color: AppColors.grey.shade500),
                      ),
                      const SizedBox(height: 10),
                      _percentWidget(
                        context,
                        station.numBicycle ?? 0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _itineraryWidget(
              context,
              station,
            ),
            Visibility(
                visible: controller.checkBikeLeft(station.numBicycle ?? 0),
                child: _bottomButton(context)),
          ],
        ),
      ),
    );
  }

  Widget _bottomButton(BuildContext context) {
    return InkWell(
      onTap: controller.checkMyPositon() ? _onGoClicked : null,
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20,
        ),
        decoration: BoxDecoration(
          color: controller.checkMyPositon()
              ? AppColors.main.shade200
              : AppColors.grey.shade300,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              S.of(context).goStation,
              style: AppTextStyles.body1().copyWith(
                color: AppColors.main.shade400,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itineraryWidget(BuildContext context, StationModel station) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(AssetsConst.fromToMap),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Obx(() => _containerItinerary(
                    context,
                    controller.getMyAddress ?? S.of(context).yourAddress,
                    Icons.my_location,
                  )),
              Visibility(
                visible: controller.caculateDistance(
                        LatLng(station.lat ?? 0, station.lng ?? 0)) !=
                    null,
                child: Row(
                  children: [
                    SvgPicture.asset(AssetsConst.iconDistanceGreen),
                    const SizedBox(width: 15),
                    Text(
                      controller
                          .caculateDistance(
                              LatLng(station.lat ?? 0, station.lng ?? 0))
                          .toString(),
                      style: AppTextStyles.body1().copyWith(
                        color: AppColors.main.shade200,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () => _containerItinerary(
                  context,
                  controller.getStationAddress ?? "",
                  Icons.location_on,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _containerItinerary(
    BuildContext context,
    String text,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
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
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Icon(
                icon,
                color: AppColors.main.shade200,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  text,
                  style: AppTextStyles.body2().copyWith(
                    color: AppColors.grey.shade500,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _percentWidget(
    BuildContext context,
    int numbicyle,
  ) {
    bool checkNumbicyle = controller.checkNumbicycle(numbicyle);
    return CircularPercentIndicator(
      radius: 45.0,
      lineWidth: 9.0,
      animation: true,
      percent: numbicyle == 0
          ? 1
          : checkNumbicyle
              ? 0.8
              : 0.4,
      center: Text(
        numbicyle.toString(),
        style: AppTextStyles.heading1().copyWith(
            color: numbicyle == 0
                ? AppColors.warning.shade400
                : checkNumbicyle
                    ? AppColors.main.shade200
                    : AppColors.warning.shade400),
      ),
      backgroundColor: AppColors.grey.shade200,
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: numbicyle == 0
          ? AppColors.grey.shade200
          : checkNumbicyle
              ? AppColors.main.shade200
              : AppColors.warning.shade400,
    );
  }
}

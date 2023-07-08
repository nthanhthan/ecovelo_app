import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EcoStationView extends GetView<EcoStationController> {
  const EcoStationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  void _onChangeSearch(String text) {
    if (text.isEmpty || text.trim().isEmpty) {}
  }

  void _onChooseSuggestFacility(StationModel station) {
    controller.stationTextController.clear();
    // controller.chooseStation(station);
  }

  void notifyActive() {
    showDialog<void>(
      context: Get.context!,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      AssetsConst.icEcovelo,
                      height: 70,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      S.of(context).confirmActiveBicycle("ECOVELO-01"),
                      style: AppTextStyles.subHeading1().copyWith(
                        color: AppColors.main.shade200,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: FilledBtnStyle.enable(isFullWidth: true),
                      child: Text(
                        S.of(context).confirm,
                        style: AppTextStyles.body1().copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultBackground,
      appBar: AppBar(
        backgroundColor: AppColors.colorAppBar,
        title: Text(
          S.of(context).station,
          style: AppTextStyles.heading1().copyWith(color: AppColors.white),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: AppColors.grey.shade100,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _searchBicycle(context),
              const SizedBox(height: 20),
              _bicycleItem(context, false, "ECOVELO-01", "Station-01"),
              _bicycleItem(context, true, "ECOVELO-02", "Station-03"),
              _bicycleItem(context, true, "ECOVELO-03", "Station-05"),
              _bicycleItem(context, false, "ECOVELO-04", "Station-01"),
              _bicycleItem(context, true, "ECOVELO-05", "Station-02"),
              _bicycleItem(context, true, "ECOVELO-06", "Station-03"),
              _bicycleItem(context, true, "ECOVELO-07", "Station-06"),
              _bicycleItem(context, false, "ECOVELO-08", "Station-01"),
              _bicycleItem(context, true, "ECOVELO-09", "Station-02"),
              _bicycleItem(context, true, "ECOVELO-10", "Station-05"),
              _bicycleItem(context, false, "ECOVELO-11", "Station-04"),
              _bicycleItem(context, true, "ECOVELO-12", "Station-02"),
              _bicycleItem(context, true, "ECOVELO-13", "Station-05"),
              _bicycleItem(context, true, "ECOVELO-14", "Station-06"),
              _bicycleItem(context, false, "ECOVELO-15", "Station-03"),
              _bicycleItem(context, true, "ECOVELO-16", "Station-04"),
              _bicycleItem(context, true, "ECOVELO-17", "Station-05"),
              _bicycleItem(context, false, "ECOVELO-18", "Station-01"),
              _bicycleItem(context, true, "ECOVELO-19", "Station-02"),
              _bicycleItem(context, true, "ECOVELO-20", "Station-03"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchBicycle(BuildContext context) {
    return SearchInput<StationModel>(
      searchController: controller.stationTextController,
      searchFocus: controller.searchNode,
      labelText: S.of(context).searchBicycle,
      suggestionsCallback: (pattern) async {
        return await controller.loadListStation(pattern);
      },
      onSuggestionSelected: _onChooseSuggestFacility,
      onChanged: _onChangeSearch,
      itemBuilder: (context, station) {
        return ListTile(
          key: ValueKey(station.id),
          title: StationInfoWidget(station: station),
        );
      },
    );
  }

  Widget _bicycleItem(
      BuildContext context, bool isUsing, String name, String station) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: AppColors.grey.shade100,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: AppTextStyles.body1().copyWith(
                        color: AppColors.main,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              showBottomStation(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  station,
                                  style: AppTextStyles.body2()
                                      .copyWith(color: AppColors.grey),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              notifyActive();
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  S.of(context).active,
                                  style: AppTextStyles.body2()
                                      .copyWith(color: AppColors.grey),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Column(
                children: [
                  Image.asset(
                    isUsing ? AssetsConst.stationRed : AssetsConst.station,
                    height: 50,
                  ),
                  Text(
                    isUsing ? S.of(context).running : S.of(context).freeBike,
                    style: AppTextStyles.body2().copyWith(
                        color: isUsing ? AppColors.warning : AppColors.success),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: AppColors.main.shade200,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  "Phú Thượng, Hoà Sơn, Hoà Vang, Đà Nẵng",
                  style: AppTextStyles.body2().copyWith(color: AppColors.main),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void showBottomStation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      builder: (BuildContext context) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.9,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: _stationWidget(context),
          ),
        );
      },
    );
  }

  Widget _stationWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text("Station_01",
              style:
                  AppTextStyles.subHeading1().copyWith(color: AppColors.main)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                color: AppColors.main.shade200,
              ),
              const SizedBox(width: 5),
              Text(
                "Phú Thượng, Hoà Sơn, Hoà Vang, Đà Nẵng",
                style: AppTextStyles.body2().copyWith(color: AppColors.main),
                textAlign: TextAlign.start,
              ),
            ],
          ),
          _stationBicleWidget(context),
          _bicycleWidget(context, "ECOVELO-01"),
          _bicycleWidget(context, "ECOVELO-07"),
          _bicycleWidget(context, "ECOVELO-12"),
          _bicycleWidget(context, "ECOVELO-15"),
          _bicycleWidget(context, "ECOVELO-17"),
          _bicycleWidget(context, "ECOVELO-18"),
          _bicycleWidget(context, "ECOVELO-21"),
        ],
      ),
    );
  }

  Widget _stationBicleWidget(BuildContext context) {
    return Row(children: [
      Expanded(
        child: _analysisItem(
          context,
          false,
          10,
        ),
      ),
      Expanded(
        child: _analysisItem(
          context,
          true,
          5,
        ),
      ),
    ]);
  }

  Widget _analysisItem(
    BuildContext context,
    bool isUsing,
    int num,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 5,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        color: AppColors.grey.shade100,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              isUsing ? AssetsConst.stationRed : AssetsConst.station,
              height: 50,
            ),
            const SizedBox(width: 10),
            Text(
              num.toString(),
              style: AppTextStyles.body1().copyWith(
                color: AppColors.main,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bicycleWidget(BuildContext context, String nameBicycle) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey),
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            AssetsConst.station,
            height: 50,
          ),
          Text(
            nameBicycle,
            style: AppTextStyles.body1().copyWith(
              color: AppColors.main,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            "Running",
            style: AppTextStyles.body2().copyWith(color: AppColors.success),
          ),
        ],
      ),
    );
  }
}

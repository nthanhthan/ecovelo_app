import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_charts/flutter_charts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EcoUserView extends GetView<EcoUserController> {
  const EcoUserView({Key? key}) : super(key: key);

  void _userDetailClick() {
    Get.toNamed(Routes.ecoUserDetail);
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultBackground,
      appBar: AppBar(
        backgroundColor: AppColors.colorAppBar,
        title: Text(
          S.of(context).accUser,
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
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _topWiget(context),
              chartToRun(),
              const SizedBox(height: 20),
              _itemUser(context),
              _itemUser(context),
              _itemUser(context),
              _itemUser(context),
              _itemUser(context),
              _itemUser(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topWiget(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: AppColors.main.shade200,
          borderRadius: BorderRadius.circular(16),
        ),
        child: _gridAnalysis(context));
  }

  Widget _gridAnalysis(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _itemAnalysis(
                  context,
                  S.of(context).totalUser,
                  "10",
                ),
                _itemAnalysis(
                  context,
                  S.of(context).authenticated,
                  "5",
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
                  S.of(context).unauthenticated,
                  "4",
                ),
                _itemAnalysis(
                  context,
                  S.of(context).pendingProcessing,
                  "1",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemAnalysis(
    BuildContext context,
    String text,
    String number,
  ) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: OutlinedButton(
        onPressed: null,
        style: OutlineButtonStyle.enable(
          sizeType: SizeButtonType.custom,
          customPadding: const EdgeInsets.fromLTRB(12, 15, 5, 15),
          outlineColor: AppColors.secondary.shade200,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    text,
                    style: AppTextStyles.tiny().copyWith(
                      color: AppColors.grey.shade100,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  number,
                  style: AppTextStyles.body1().copyWith(
                    color: AppColors.grey.shade100,
                  ),
                ),
                const SizedBox(width: 4),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _itemUser(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: OutlinedButton(
        onPressed: _userDetailClick,
        style: OutlineButtonStyle.enable(
          sizeType: SizeButtonType.custom,
          outlineColor: AppColors.grey.shade300,
          customPadding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 15,
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "1. Thanh Than -User",
                        style: AppTextStyles.body1()
                            .copyWith(color: AppColors.main),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          "0901948483",
                          style: AppTextStyles.body2()
                              .copyWith(color: AppColors.main),
                        ),
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
                Text(
                  "Authenticated",
                  style: AppTextStyles.body2().copyWith(color: AppColors.main),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color(0xffBFBFBF),
                    width: 1.0,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  _itemActivites(
                    context,
                    AssetsConst.icEcovelo,
                    S.of(context).totalRent,
                    "10",
                  ),
                  _itemActivites(
                    context,
                    AssetsConst.problemIC,
                    S.of(context).numFall,
                    "0",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget chartToRun() {
    LabelLayoutStrategy? xContainerLabelLayoutStrategy;
    ChartData chartData;
    ChartOptions chartOptions = const ChartOptions();
    // Example shows how to create ChartOptions instance
    //   which will request to end Y axis at maximum data (as all data negative).
    // Even though startYAxisAtDataMinRequested is set to true, this will not be granted on bar chart,
    //   as it does not make sense there.
    chartOptions = const ChartOptions(
      dataContainerOptions: DataContainerOptions(
        startYAxisAtDataMinRequested: true,
      ),
    );
    chartData = ChartData(
      dataRows: const [
        [-20.0, -25.0, -30.0, -35.0, -40.0, -20.0],
        [-35.0, -40.0, -20.0, -25.0, -30.0, -20.0],
      ],
      xUserLabels: const ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
      dataRowsLegends: const [
        'Off zero 1',
        'Off zero 2',
      ],
      chartOptions: chartOptions,
    );
    var lineChartContainer = LineChartTopContainer(
      chartData: chartData,
      xContainerLabelLayoutStrategy: xContainerLabelLayoutStrategy,
    );

    var lineChart = LineChart(
      painter: LineChartPainter(
        lineChartContainer: lineChartContainer,
      ),
    );
    return lineChart;
  }

  Widget _itemActivites(
    BuildContext context,
    String icon,
    String text,
    String number,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 0),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: AppColors.main.shade400,
            borderRadius: BorderRadius.circular(12),
          ),
          child: SvgPicture.asset(
            icon,
            width: 30,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: AppTextStyles.tiny().copyWith(
                color: AppColors.grey.shade500,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              number,
              style: AppTextStyles.body1()
                  .copyWith(color: AppColors.main.shade200),
            ),
            const SizedBox(width: 4),
          ],
        )
      ],
    );
  }
}

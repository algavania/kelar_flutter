import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:kelar_flutter/core/color_values.dart';
import 'package:kelar_flutter/core/styles.dart';
import 'package:kelar_flutter/features/dashboard/data/models/sensor/sensor_model.dart';
import 'package:kelar_flutter/features/dashboard/view/bloc/dashboard_bloc.dart';
import 'package:kelar_flutter/injector/injector.dart';
import 'package:kelar_flutter/l10n/l10n.dart';
import 'package:kelar_flutter/routes/router.dart';
import 'package:kelar_flutter/utils/extensions.dart';
import 'package:kelar_flutter/utils/logger.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _bloc = Injector.instance<DashboardBloc>();
  SensorModel? _lastSensor;
  var _hasFetched = false;

  @override
  void initState() {
    _bloc
      ..add(const DashboardEvent.getSensors())
      ..add(const DashboardEvent.getForecast());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'K3LAR',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Styles.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIntroductionWidget(),
              const SizedBox(
                height: Styles.bigSpacing,
              ),
              _buildMonitoringWidget(),
              const SizedBox(
                height: Styles.bigSpacing,
              ),
              const AirQualityTable(),
              const SizedBox(
                height: Styles.bigSpacing,
              ),
              _buildAnalyticWidget(),
              const SizedBox(
                height: Styles.bigSpacing,
              ),
              _buildForecastWidget(),
              const SizedBox(
                height: Styles.bigSpacing,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForecastWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                context.l10n.forecast,
                style: context.textTheme.titleLarge,
              ),
            ),
            IconButton(
              onPressed: () {
                _bloc.add(const DashboardEvent.getForecast());
              },
              icon: const Icon(
                IconsaxPlusBold.refresh,
                color: ColorValues.primary50,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: Styles.defaultSpacing,
        ),
        BlocBuilder<DashboardBloc, DashboardState>(
          bloc: _bloc,
          builder: (context, state) {
            final adviceText = _bloc.forecast ?? 'Lorem ipsum dolor sit amet';
            return Skeletonizer(
              enabled: _bloc.forecast == null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCard(
                    context.l10n.futurePrediction,
                    adviceText,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildAnalyticWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                context.l10n.analysis,
                style: context.textTheme.titleLarge,
              ),
            ),
            IconButton(
              onPressed: () {
                if (_lastSensor != null) {
                  _bloc.add(DashboardEvent.getClassifications(_lastSensor!));
                }
              },
              icon: const Icon(
                IconsaxPlusBold.refresh,
                color: ColorValues.primary50,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: Styles.defaultSpacing,
        ),
        BlocBuilder<DashboardBloc, DashboardState>(
          bloc: _bloc,
          builder: (context, state) {
            var adviceText = 'Lorem ipsum dolor sit amet';
            if (_bloc.advice != null) {
              adviceText = _bloc.advice!.advice.join('\n\n');
            }
            return Skeletonizer(
              enabled: _bloc.advice == null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCard(
                    context.l10n.roomQuality,
                    _bloc.advice?.quality ?? 'Baik',
                  ),
                  const SizedBox(
                    height: Styles.defaultSpacing,
                  ),
                  _buildCard(
                    context.l10n.workEnvironment,
                    adviceText,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCard(
    String title,
    String text,
  ) {
    return Container(
      width: 100.w,
      padding: const EdgeInsets.all(Styles.defaultPadding),
      decoration: BoxDecoration(
        color: ColorValues.white,
        borderRadius: BorderRadius.circular(Styles.defaultBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.textTheme.titleMedium,
          ),
          const SizedBox(
            height: Styles.defaultSpacing,
          ),
          Text(
            text,
            style: context.textTheme.bodyMedium.copyWith(
              color: ColorValues.grey50,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonitoringWidget() {
    return BlocBuilder<DashboardBloc, DashboardState>(
      bloc: _bloc,
      builder: (context, state) {
        return StreamBuilder<List<SensorModel>>(
          stream: _bloc.sensorStream,
          builder: (context, snapshot) {
            var data = generateMockSensorModel();
            if (snapshot.data?.isNotEmpty ?? false) {
              data = snapshot.data!.first;
              _lastSensor = data;
              if (_bloc.lastData.isEmpty) {
                _bloc.lastData = snapshot.data ?? [];
              }
              if (!_hasFetched) {
                _hasFetched = true;
                _bloc.add(DashboardEvent.getClassifications(data));
              }
            }
            logger.d('snapshot ${snapshot.data}');
            return Skeletonizer(
              enabled: snapshot.data == null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.monitoring,
                    style: context.textTheme.titleLarge,
                  ),
                  Text(
                    context.l10n
                        .latestTime(data.date.toFormattedLongDateWithHour()),
                    style: context.textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: Styles.defaultSpacing,
                  ),
                  _buildRowItems(
                    _buildMonitoringItemWidget(
                      context.l10n.humidity,
                      Symbols.humidity_percentage,
                      data.humidity,
                      '%',
                    ),
                    _buildMonitoringItemWidget(
                      context.l10n.temperature,
                      Symbols.thermostat,
                      data.temperature,
                      'C',
                    ),
                  ),
                  const SizedBox(
                    height: Styles.defaultSpacing,
                  ),
                  _buildRowItems(
                    _buildMonitoringItemWidget(
                      context.l10n.co2,
                      Symbols.air,
                      data.co2,
                      'ppm',
                    ),
                    _buildMonitoringItemWidget(
                      context.l10n.co,
                      Symbols.air,
                      data.co,
                      'ppm',
                    ),
                  ),
                  const SizedBox(
                    height: Styles.defaultSpacing,
                  ),
                  _buildRowItems(
                    _buildMonitoringItemWidget(
                      context.l10n.pm25,
                      Symbols.airwave,
                      data.pm25,
                      'ug/m3',
                    ),
                    _buildViewStatisticWidget(),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildRowItems(Widget item1, Widget item2) {
    return Row(
      children: [
        Expanded(
          child: item1,
        ),
        const SizedBox(
          width: Styles.defaultSpacing,
        ),
        Expanded(
          child: item2,
        ),
      ],
    );
  }

  Widget _buildViewStatisticWidget() {
    return GestureDetector(
      onTap: () {
        AutoRouter.of(context).navigate(const StatisticRoute());
      },
      child: Container(
        constraints: BoxConstraints(
          minHeight: 11.h,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: Styles.mediumPadding,
          vertical: Styles.smallPadding,
        ),
        decoration: BoxDecoration(
          color: ColorValues.primary50,
          borderRadius: BorderRadius.circular(Styles.defaultBorder),
          border: Border.all(color: ColorValues.primary50),
        ),
        child: Row(
          children: [
            const Icon(
              IconsaxPlusBold.chart,
              color: ColorValues.white,
            ),
            const SizedBox(
              width: Styles.defaultSpacing,
            ),
            Expanded(
              child: Text(
                context.l10n.viewStatistic,
                style: context.textTheme.titleMedium
                    .copyWith(color: ColorValues.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonitoringItemWidget(
    String title,
    IconData icon,
    num value,
    String unit,
  ) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 11.h,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: Styles.mediumPadding,
        vertical: Styles.smallPadding,
      ),
      decoration: BoxDecoration(
        color: ColorValues.white,
        borderRadius: BorderRadius.circular(Styles.defaultBorder),
        border: Border.all(color: ColorValues.grey10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(title)),
              Icon(
                icon,
                color: ColorValues.primary30,
              ),
            ],
          ),
          const SizedBox(
            height: Styles.mediumSpacing,
          ),
          RichText(
            text: TextSpan(
              text: value.toString(),
              style: context.textTheme.titleMedium
                  .copyWith(color: ColorValues.primary50),
              children: [
                TextSpan(
                  text: unit,
                  style: context.textTheme.titleSmall.copyWith(
                    color: ColorValues.grey30,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntroductionWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Styles.defaultPadding,
        vertical: Styles.biggerPadding,
      ),
      constraints: BoxConstraints(
        minHeight: 18.h,
      ),
      width: 100.w,
      decoration: BoxDecoration(
        color: ColorValues.white,
        borderRadius: BorderRadius.circular(Styles.defaultBorder),
        image: const DecorationImage(
          image: Svg(
            'assets/home/card_bg.svg',
          ),
          fit: BoxFit.contain,
          alignment: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _getGreetingBasedOnTime(),
            style: context.textTheme.titleLarge
                .copyWith(color: ColorValues.primary70),
          ),
          const SizedBox(
            height: Styles.defaultSpacing,
          ),
          _buildIconText(
            IconsaxPlusBold.calendar,
            DateTime.now().toFormattedFullDate(),
          ),
          const SizedBox(
            height: Styles.smallSpacing,
          ),
          _buildIconText(IconsaxPlusBold.location, 'PT K3LAR Indonesia'),
        ],
      ),
    );
  }

  Widget _buildIconText(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: ColorValues.primary50,
          size: 18,
        ),
        const SizedBox(
          width: Styles.defaultSpacing,
        ),
        Flexible(
          child: Text(
            text,
            style: const TextStyle(color: ColorValues.grey50),
          ),
        ),
      ],
    );
  }

  String _getGreetingBasedOnTime() {
    final date = DateTime.now();
    final hours = date.hour;
    logger.d('hour $hours');
    var greeting = context.l10n.goodMorning;
    if (hours >= 1 && hours <= 11) {
      greeting = context.l10n.goodMorning;
    } else if (hours >= 11 && hours <= 14) {
      greeting = context.l10n.goodAfternoon;
    } else if (hours >= 14 && hours <= 17) {
      greeting = context.l10n.goodEvening;
    } else if (hours >= 17 && hours <= 24) {
      greeting = context.l10n.goodNight;
    }
    return greeting;
  }
}

class AirQualityTable extends StatefulWidget {
  const AirQualityTable({super.key});

  @override
  State<AirQualityTable> createState() => _AirQualityTableState();
}

class _AirQualityTableState extends State<AirQualityTable> {
  late AirQualityDataSource _airQualityDataSource;

  @override
  void initState() {
    super.initState();
    _airQualityDataSource = AirQualityDataSource(getAirQualityData());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.indicator,
          style: context.textTheme.titleLarge,
        ),
        const SizedBox(
          height: Styles.defaultSpacing,
        ),
        SfDataGrid(
          source: _airQualityDataSource,
          columnWidthMode: ColumnWidthMode.fill,
          showVerticalScrollbar: false,
          columns: <GridColumn>[
            GridColumn(
              columnName: 'Nama',
              label: Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                child: const Text(
                  'Nama',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            GridColumn(
              columnName: 'Baik',
              label: Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                child: const Text(
                  'Baik',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            GridColumn(
              columnName: 'Buruk',
              label: Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                child: const Text(
                  'Buruk',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  List<AirQuality> getAirQualityData() {
    return [
      AirQuality('Kelembaban', '30-50%', '>60% atau <30%'),
      AirQuality('Suhu', '20-25°C', '>30°C atau <20°C'),
      AirQuality('CO2', '<1000 ppm', '>1000 ppm'),
      AirQuality('CO', '<10 ppm', '>10 ppm'),
      AirQuality('PM2.5', '0-12 ug/m³', '>12 ug/m³'),
    ];
  }
}

class AirQuality {
  AirQuality(this.nama, this.baik, this.buruk);

  final String nama;
  final String baik;
  final String buruk;
}

class AirQualityDataSource extends DataGridSource {
  AirQualityDataSource(this.airQualityData) {
    buildDataGridRows();
  }

  List<AirQuality> airQualityData;
  List<DataGridRow> dataGridRows = [];

  void buildDataGridRows() {
    dataGridRows = airQualityData
        .map<DataGridRow>(
          (dataGridRow) => DataGridRow(
            cells: [
              DataGridCell<String>(columnName: 'Nama', value: dataGridRow.nama),
              DataGridCell<String>(columnName: 'Baik', value: dataGridRow.baik),
              DataGridCell<String>(
                  columnName: 'Buruk', value: dataGridRow.buruk,),
            ],
          ),
        )
        .toList();
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: Text(
            row.getCells()[0].value.toString(),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: Text(
            row.getCells()[1].value.toString(),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: Text(
            row.getCells()[2].value.toString(),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

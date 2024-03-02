import 'package:beaver_learning/src/widgets/shared/app_drawer.dart';
import 'package:beaver_learning/src/widgets/shared/widgets/CustomDropdown.dart';
import 'package:flutter/material.dart';
import 'package:beaver_learning/data/constants.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  final String title = AppConstante.AppTitle;
  static const routeName = '/StatisticsScreen';

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: const Text("Statistics"),
        drawer: const AppDrawer());
  }
}

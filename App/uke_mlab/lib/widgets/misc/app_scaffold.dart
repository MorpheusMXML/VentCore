import 'package:flutter/material.dart';
import 'package:uke_mlab/widgets/appbar/statusbar.dart';
import 'package:uke_mlab/widgets/menu/menu.dart';

class AppScaffold extends StatelessWidget {
  final Widget screen;

  const AppScaffold({
    Key? key,
    required this.screen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppMenu(),
      appBar: AppBar(title: const StatusBar()),
      body: screen,
    );
  }
}

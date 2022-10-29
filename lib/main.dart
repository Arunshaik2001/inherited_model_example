import 'dart:math';

import 'package:flutter/material.dart';
import 'package:inherited_model_example/color_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final colors = [
    Colors.red,
    Colors.amber,
    Colors.black,
    Colors.blue,
    Colors.deepPurpleAccent,
    Colors.indigo,
    Colors.green
  ];

  var color1 = Colors.green as Color;
  var color2 = Colors.indigo as Color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: AvailableColorModel(
          child: Column(
            children: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      color1 = colors.getRandomElement();
                    });
                  },
                  child: const Text("Update Color1")),
              TextButton(
                  onPressed: () {
                    setState(() {
                      color2 = colors.getRandomElement();
                    });
                  },
                  child: const Text("Update Color2")),
              const ColorWidget(
                color: AvailableColors.one,
              ),
              const ColorWidget(
                color: AvailableColors.two,
              )
            ],
          ),
          colors1: color1,
          colors2: color2),
    );
  }
}

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(Random().nextInt(length));
}

enum AvailableColors { one, two }

class AvailableColorModel extends InheritedModel<AvailableColors> {
  final Color colors1;
  final Color colors2;

  const AvailableColorModel(
      {required Widget child, required this.colors1, required this.colors2})
      : super(child: child);

  @override
  bool updateShouldNotify(covariant AvailableColorModel oldWidget) {
    print("updateShouldNotify");
    return oldWidget.colors1 != colors1 || oldWidget.colors2 != colors2;
  }

  @override
  bool updateShouldNotifyDependent(covariant AvailableColorModel oldWidget,
      Set<AvailableColors> dependencies) {
    print("updateShouldNotifyDependent ${dependencies.length} ${dependencies.toString()}");

    if (dependencies.contains(AvailableColors.one) &&
        oldWidget.colors1 != colors1) {
      return true;
    }

    if (dependencies.contains(AvailableColors.two) &&
        oldWidget.colors2 != colors2) {
      return true;
    }

    return false;
  }

  static AvailableColorModel? of(BuildContext context, AvailableColors aspect) {
    return InheritedModel.inheritFrom(context, aspect: aspect);
  }
}

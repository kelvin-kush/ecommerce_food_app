import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/adapters.dart';

Box? box;
 String? name;

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  void initBox() async {
    box = await Hive.openBox('testBox');
    box?.put('name', 'Kush');
    name = box?.get('name');
    print('Name: ${box?.get('name')}');
  }

  @override
  void initState() {
    super.initState();
    initBox();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(name!)),
     // print('Name is')
    );
  }
}

import 'package:alerta_dengue/views/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(const AlertaDengue());

class AlertaDengue extends StatelessWidget {
  const AlertaDengue({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

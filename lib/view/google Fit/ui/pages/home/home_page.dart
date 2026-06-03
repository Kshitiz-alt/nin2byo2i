import 'package:flutter/material.dart';
import 'package:nin2byo2i/view/google%20Fit/ui/pages/home/home_controller.dart';
import 'package:nin2byo2i/view/google%20Fit/ui/widgets/my_card.dart';

class GoogleFit extends StatefulWidget {
  const GoogleFit({super.key});

  @override
  State<GoogleFit> createState() => _GoogleFitState();
}

class _GoogleFitState extends State<GoogleFit> {
  final controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //  FloatingActionButton(
          //    onPressed: () => controller.getDataFirebase(),
          //    child: const Icon(Icons.data_array),
          //  ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () => controller.getData(),
            child: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: controller.blodGlucoses,
        builder: (context, value, child) {
          return GridView(
              padding: const EdgeInsets.all(15),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15),
              children: [
                for (final bloodGlucose in value)
                  MyCard(bloodGlucose: bloodGlucose),
              ]);
        },
      ),
    );
  }
}

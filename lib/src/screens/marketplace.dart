import 'package:beaver_learning/src/widgets/shared/app_drawer.dart';
import 'package:beaver_learning/src/widgets/shared/widgets/CustomDropdown.dart';
import 'package:flutter/material.dart';

class MarketPlaceScreen extends StatefulWidget {
  const MarketPlaceScreen({super.key});

  final String title = "My Learning App";
  static const routeName = '/MarketPlaceScreen';

  @override
  State<MarketPlaceScreen> createState() => _MarketPlaceScreenState();
}

class Course {
  final String name;
  final double price;

  Course(this.name, this.price);
}

class _MarketPlaceScreenState extends State<MarketPlaceScreen> {
  List<Course> courses = [
    Course("cours 1", 29.99),
    Course("cours 2", 18.20),
    Course("cours 3", 7.99),
    Course("cours 4", 15.50),
    Course("cours 5", 23.00),
    Course("cours 6", 5.99)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: courses.length,
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        Text(courses[index].name),
                      ],
                    )),
                    Container(
                      margin: const EdgeInsets.all(4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.remove_red_eye_sharp,
                            color: Colors.deepOrange,
                          ),
                          Text('${courses[index].price} €',
                              style: const TextStyle(
                                  color: Colors.purpleAccent,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }),
        drawer: const AppDrawer());
  }
}

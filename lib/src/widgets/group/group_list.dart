import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/widgets/group/group_detail.dart';
import 'package:flutter/material.dart';

class GroupList extends StatelessWidget {
  final List<GroupData> groups;

  GroupList({required this.groups});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: groups.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    Text(groups[index].title),
                    Text('parent ${groups[index].parentId}'),
                  ],
                )),
                Container(
                    margin: const EdgeInsets.all(4),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => GroupDetail(group: groups[index]),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.remove_red_eye_sharp,
                        color: Colors.deepOrange,
                      ),
                    ))
              ],
            ),
          );
        });
  }
}

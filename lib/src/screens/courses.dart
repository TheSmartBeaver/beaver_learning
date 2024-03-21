import 'package:beaver_learning/src/models/db/database.dart';
import 'package:beaver_learning/src/models/db/databaseInstance.dart';
import 'package:beaver_learning/src/widgets/course/course_detail.dart';
import 'package:beaver_learning/src/widgets/course/course_summary.dart';
import 'package:beaver_learning/src/widgets/shared/app_drawer.dart';
import 'package:beaver_learning/src/widgets/shared/widgets/CustomDropdown.dart';
import 'package:flutter/material.dart';
import 'package:beaver_learning/data/constants.dart';
import 'package:transparent_image/transparent_image.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  final String title = AppConstante.AppTitle;
  static const routeName = '/CoursesScreen';

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

// class Course {
//   final String name;
//   final String photoUrl;

//   Course(this.name, this.photoUrl);
// }

class _CoursesScreenState extends State<CoursesScreen> {
  // List<Course> courses = [
  //   Course("Apprends à parler Anglais",
  //       "https://img.pixers.pics/pho_wat(s3:700/FO/40/70/37/94/700_FO40703794_f3c68522bf4a853d282896173902b992.jpg,450,700,cms:2018/10/5bd1b6b8d04b8_220x50-watermark.png,over,230,650,jpg)/coussins-decoratifs-drapeau-anglais-big-ben-verticale.jpg.jpg"),
  //   Course("Apprends à parler Espagnol",
  //       "https://www.revueconflits.com/wp-content/uploads/2020/03/espagnol-espagne-amerique.jpg"),
  //   Course("Deviens pro sur Fortnite",
  //       "https://cdn2.unrealengine.com/Fortnite+Esports%2Fevents%2Fchampionseries-ch2s2%2FEN_12BR_FNCS_Announce_Social-1920x1080-482846711f666b4d00ff657065e338a8fbd14aee.jpg"),
  //   Course("Deviens pro sur FC 24",
  //       "https://miro.medium.com/v2/resize:fit:1400/0*y9ULQIXlaaTTqldx.png")
  // ];


  @override
  Widget build(BuildContext context) {
    late List<Course> courses;

    Future<void> init() async {
      AppDatabase database = MyDatabaseInstance.getInstance();
      courses = await database.select(database.courses).get();
      }

    return Scaffold(
        appBar: AppBar(title: Text("Your courses")),
        body: FutureBuilder(
      future: init(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          return GridView.builder(
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
                    Column(
                      children: [
                        Text(courses[index].title,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.visible)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Expanded(
                      child: FadeInImage(
                          placeholder: MemoryImage(kTransparentImage),
                          image: NetworkImage(courses[index].imageUrl),
                          fit: BoxFit.cover),
                    ),
                    Container(
                        margin: const EdgeInsets.all(4),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (ctx) => CourseDetail(course: courses[index])),
                              );
                            },
                            child: const Icon(
                              Icons.remove_red_eye_sharp,
                              color: Colors.deepOrange,
                            ))),
                  ],
                ),
              );
            });
        }
      }),
        drawer: const AppDrawer());
  }
}

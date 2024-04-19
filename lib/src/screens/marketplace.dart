import 'package:beaver_learning/src/widgets/shared/app_drawer.dart';
import 'package:beaver_learning/src/widgets/shared/widgets/CustomDropdown.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:beaver_learning/data/constants.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter/services.dart';

class MarketPlaceScreen extends StatefulWidget {
  const MarketPlaceScreen({super.key});

  final String title = AppConstante.AppTitle;
  static const routeName = '/MarketPlaceScreen';

  @override
  State<MarketPlaceScreen> createState() => _MarketPlaceScreenState();
}

class Course {
  final String name;
  final double price;
  final String photoUrl;

  Course(this.name, this.price, this.photoUrl);
}

class _MarketPlaceScreenState extends State<MarketPlaceScreen> {
  bool _isOnline = false;

  List<Course> courses = [
    Course("Apprends à parler Anglais", 29.99,
        "https://img.pixers.pics/pho_wat(s3:700/FO/40/70/37/94/700_FO40703794_f3c68522bf4a853d282896173902b992.jpg,450,700,cms:2018/10/5bd1b6b8d04b8_220x50-watermark.png,over,230,650,jpg)/coussins-decoratifs-drapeau-anglais-big-ben-verticale.jpg.jpg"),
    Course("Apprends à parler Espagnol", 18.20,
        "https://www.revueconflits.com/wp-content/uploads/2020/03/espagnol-espagne-amerique.jpg"),
    Course("Deviens artiste avec Blender", 7.99,
        "https://blendamator.com/wp-content/uploads/2022/06/Banniere-Blender-Reseaux-Sociaux.jpg"),
        //"https://cdn2.unrealengine.com/Fortnite+Esports%2Fevents%2Fchampionseries-ch2s2%2FEN_12BR_FNCS_Announce_Social-1920x1080-482846711f666b4d00ff657065e338a8fbd14aee.jpg"
    Course("Deviens pro sur FC 24", 15.50,
        "https://miro.medium.com/v2/resize:fit:1400/0*y9ULQIXlaaTTqldx.png"),
    Course("40 leçons pour se réconcilier avec les maths", 23.00,
        "https://as2.ftcdn.net/v2/jpg/05/78/85/81/1000_F_578858115_vELC84iWEazGN75kTrn1hBtcaDw8oRmX.jpg"),
    Course("Apprends l'électronique avec Arduino", 5.99,
        "https://i0.wp.com/www.programmingelectronics.com/wp-content/uploads/2018/06/Kit3.jpg")
  ];

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    Connectivity().onConnectivityChanged.listen((result) {
      if (result != ConnectivityResult.none) {
        setState(() {
          _isOnline = true;
        });
      } else {
        setState(() {
          _isOnline = false;
        });
      }
    });
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }

  Future<void> _checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _isOnline = false;
      });
    } else {
      setState(() {
        _isOnline = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Marketplace"),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_rounded),
            onPressed: () {
              // Action pour les filtres avancés
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                // Action pour la recherche
              },
            ),
          ),
          Expanded(
            child: _isOnline
                ? GridView.builder(
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
                                Text(
                                  courses[index].name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Expanded(
                              child: FadeInImage(
                                placeholder: MemoryImage(kTransparentImage),
                                image: NetworkImage(courses[index].photoUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text("Whooops !"),
                                          content: const Text(
                                              'Ce cours est actuellement en cours de développement. Veuillez réessayer plus tard !'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Okay'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    child: const Icon(
                                      Icons.remove_red_eye_sharp,
                                      color: Colors.deepOrange,
                                    ),
                                  ),
                                  Text(
                                    '${courses[index].price} €',
                                    style: const TextStyle(
                                      color: Colors.purpleAccent,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Pas de connexion Internet'),
                        Text('Veuillez activer votre connexion Internet'),
                      ],
                    ),
                  ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
    );
  }
}

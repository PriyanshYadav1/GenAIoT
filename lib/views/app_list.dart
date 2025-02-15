import 'package:flutter/material.dart';
import 'hamburger_menu.dart';
import '../models/app_model.dart';
import 'assets.dart';

class AppsGrid extends StatefulWidget {
  const AppsGrid({super.key});

  @override
  State<AppsGrid> createState() => _AppsGridState();
}

class _AppsGridState extends State<AppsGrid> {
  final List<App> apps = [
    App(name: "Bulldozer", imageUrl: "https://cdn.pixabay.com/photo/2024/03/01/14/10/ai-generated-8606642_1280.png"),
    App(name: "Police Car Monitoring System", imageUrl: "https://cdn.pixabay.com/photo/2024/03/01/14/10/ai-generated-8606642_1280.png"),
    App(name: "Home Security Monitoring", imageUrl: "https://cdn.pixabay.com/photo/2024/03/01/14/10/ai-generated-8606642_1280.png"),
    App(name: "Pump Monitoring System", imageUrl: "https://cdn.pixabay.com/photo/2024/03/01/14/10/ai-generated-8606642_1280.png"), App(name: "Bulldozer", imageUrl: "https://cdn.pixabay.com/photo/2024/03/01/14/10/ai-generated-8606642_1280.png"),
    App(name: "Police Car Monitoring System Police Car Monitoring System", imageUrl: "https://cdn.pixabay.com/photo/2024/03/01/14/10/ai-generated-8606642_1280.png"),
    App(name: "Home Security Monitoring", imageUrl: "https://cdn.pixabay.com/photo/2024/03/01/14/10/ai-generated-8606642_1280.png"),
    App(name: "Pump Monitoring System", imageUrl: "https://cdn.pixabay.com/photo/2024/03/01/14/10/ai-generated-8606642_1280.png"),
    // ... other apps
  ];


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leadingWidth: 100,
          leading: Builder(
            builder: (context) => Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
                // const Expanded(
                //   child: Padding(
                //     padding: EdgeInsets.only(left: 8.0),
                //     child: CircleAvatar(
                //       radius: 100,
                //       backgroundImage: NetworkImage(
                //         'https://example.com/profile_image.jpg',
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          title: const Text('Apps'), centerTitle: true,
        ),
        drawer: AppDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
            ),
            itemCount: apps.length,
            itemBuilder: (context, index) {
              final app = apps[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AssetsPage(appName: app.name,),
                    ),
                  );
                },
                child: Card(
                  elevation: 30.0,

                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width*0.7,
                    height: MediaQuery.of(context).size.height*0.25,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: AspectRatio(
                            aspectRatio: 16/12,
                            child: Image.network(
                              app.imageUrl,
                              fit: BoxFit.cover,
                             width: double.infinity,
                             height: MediaQuery.of(context).size.height*0.25,
                             //  height: 170,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            app.name,
                            style: const TextStyle(fontSize: 16.0),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

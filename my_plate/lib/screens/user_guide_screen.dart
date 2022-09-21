import 'package:flutter/material.dart';
import 'package:my_plate/screens/profile_screen.dart';

import '../models/user_guide.dart';
import '../services/firestore_service.dart';

class UserGuideListScreen extends StatelessWidget {
  static String routeName = '/user-guide';
  @override
  Widget build(BuildContext context) {
    FirestoreService fsService = FirestoreService();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff588157),
          title: Text('User Guide'),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(ProfilePage.routeName);
            },
          ),
        ),
        body: StreamBuilder<List<UserGuide>>(
          stream: fsService.getUserGuide(),
          builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting)
    return Center(child: CircularProgressIndicator());
    else {
            return ListView.builder(
              padding: EdgeInsets.all(10),

                itemCount: snapshot.data!.length,//itemCount prevents error (Range Error: index - not in inclusive range)
                itemBuilder: (context, index) {
                  // UserGuide guide = myGuides[index];

                  return Card(
                    child: ListTile(
                      title: Text(snapshot.data![index].title),
                      subtitle: Text(snapshot.data![index].description),
                        leading: SizedBox(
                          height: 35,
                          width:35,
                          child: Image.network(
                              snapshot.data![index].imageUrl),
                        ),
                      onTap: () {

                      },

                    ),
                  );
                });
          }}
        ));
  }
}
// Data type of list items is declared in class UserGuide
// class UserGuide {
//   String title;
//   String description;
//   IconData icon;
//   UserGuide(
//       {required this.title,
//         required this.description,
//         required this.icon
//       });
// }
// This is where the information of the list view is retrieved from
// List<UserGuide> myGuides = [

//   UserGuide(
//       title: 'My Calories',
//       description: 'Here you can track the calories you eat everyday.',
//       icon: Icons.assignment_sharp
//   ),

//   UserGuide(
//       title: 'Healthy Food Recommendations',
//       description: 'Here are some low calorie healthy recipes!',
//       icon: Icons.book
//   ),

//   UserGuide(
//       title: 'Profile',
//       description: 'Here you can view, edit and delete your details.',
//       icon: Icons.account_circle
//   ),


// ];

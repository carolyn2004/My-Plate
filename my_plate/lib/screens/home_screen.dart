import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_plate/providers/all_calories.dart';
import 'package:my_plate/screens/home_screen.dart';
import 'package:my_plate/screens/home_screen.dart';
import 'package:my_plate/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  static String routeName = '/main';

  @override

  State<MainScreen> createState() => _MainScreenState();

}


class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  AuthService authService = AuthService();
  logOut() {
    return authService.logOut().then((value) {
      FocusScope.of(context).unfocus();
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Logout successfully!'),));
      Navigator.of(context).pushNamed('/');
      }).catchError((error) {
      FocusScope.of(context).unfocus();
      String message = error.toString();
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
      Text(message),));

    });
  }
  final _controller = ConfettiController();
  bool isPlaying = false;
  // boolean is used to stop and start the confetti when button is clicked
  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }
  Widget build(BuildContext context) {

    return Stack(
      children:[ Scaffold(

        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xff588157),
          // centerTitle: true,
          title: Text("Welcome to My Plate!" ,textAlign: TextAlign.left,),
            actions: [
              IconButton(onPressed: ()=> logOut(), icon: Icon(Icons.logout))
            ]
        ),
        body: Container(
          child: Column(
            children: [

              Padding(
                padding: EdgeInsets.all(20),

              ),
              CarouselSlider(
                items: imgList
                    .map((item) => Container(
                  child: Center(
                    child: Image.network(
                      item,
                      fit: BoxFit.cover,
                      width: 1000,
                    ),
                  ),
                ))
                    .toList(),
                options: CarouselOptions(
                  autoPlay: true, //will slide on its own
                  aspectRatio: 0.8,
                  enlargeCenterPage: true,
                ),
              ),

              MaterialButton(
                color: Color(0xff588157),
                child: Text('Click this button to celebrate your health journey!', style: TextStyle(color: Colors.white),),
                onPressed: (){
if (isPlaying) {
   _controller.stop();
}
else{
  _controller.play();
}
isPlaying = !isPlaying;

ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  content: Text('Click the button again to stop/start the confetti!'),
));
                }
              )
            ],

          ),


        ),


          drawer: AppDrawer()

      ),
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(confettiController: _controller,
            blastDirection: -pi/2,//a radial value to determine the direction of the particle emission.
            // The default is set to PI (180 degrees).
            // A value of PI will emit to the left of the canvas/screen.
           gravity: 0.5,//change the speed at which the confetti falls.
            // A value between 0 and 1.
            // The higher the value the faster it will fall. Default is set to 0.1
            emissionFrequency: 0.05,
            //should be a value between 0 and 1.
            // The higher the value the higher the likelihood that particles will be emitted on a single frame.
            numberOfParticles: 8,
          blastDirectionality: BlastDirectionality.explosive,
              //an enum value to state if the particles shoot in random directions or a specific direction.
            // maxBlastForce: 1,
            // minBlastForce: 1,
    ),
        ),
    ],
    );

  }
  // images for the carousel slider are retrieved here
  final List<String> imgList = [
    'https://i.postimg.cc/x890DqKR/photo1654834343.jpg',
    'https://i.postimg.cc/QtQXycWC/photo1654834343-1.jpg',
    // 'https://i.postimg.cc/Kvz8z0jb/photo1654783503-3.jpg',
    'https://i.postimg.cc/gJFzsgj1/photo1654834343-2.jpg'
    // 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  ];
  }




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_plate/widgets/app_drawer.dart';
import 'package:timezone/data/latest.dart' as tz;

import '../widgets/notification_widget.dart';


class NotificationsPage extends StatefulWidget {
  static String routeName = '/notification';

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();

}

class _NotificationsPageState extends State<NotificationsPage> {

  @override
  void initState(){
    // super.initState();
    NotificationWidget.init();
    tz.initializeTimeZones();


  }

  Widget build(BuildContext context) {

    return Scaffold(

backgroundColor: Colors.white,
      appBar: AppBar(

          // automaticallyImplyLeading: false,
        title: Text('Notifications'),
        backgroundColor: Color(0xff588157),
      ),
      body: Column(
        children: [
Row(
 children: [
   Image.asset('images/notification.png', height: 350, width: 350, alignment: Alignment.center)
 ],
),
          Row(

            children: [

          Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
          "Would you like to receive daily or weekly notifications?",
          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
          ),
          ),
            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: (){
                  NotificationWidget.showScheduledDailyNotification(
                      title: 'Daily Notification',
                      body: "Remember to input your calories if you haven't! ",
                  );
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(
                    content: Text(

                        'Daily notifications has been set'),

                  ));
                },
                child:Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Color(0xff588157),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Text('Daily Notifications',style: TextStyle(color: Colors.white),),
                ),

              ),
              InkWell(
                onTap: (){
                  NotificationWidget.showScheduledWeeklyNotification(
                      title: 'Weekly notification',
                      body: "Remember to input your calories if you haven't!",

                      );
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(
                    content: Text(

                            'Weekly notifications has been set'),

                  ));
                },
                child:Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Color(0xff588157),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Text('Weekly Notifications',style: TextStyle(color: Colors.white),
                ),

              ),


              )],
          )


        ],
      ),
      drawer: AppDrawer(),
    );

  }
}

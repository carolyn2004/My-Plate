import 'package:flutter/material.dart';
import 'package:my_plate/models/calories.dart';
import 'package:my_plate/providers/all_calories.dart';
import 'package:my_plate/screens/home_screen.dart';
import 'package:my_plate/screens/login_screen.dart';
import 'package:my_plate/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import '../services/firestore_service.dart';

class RecordsPage extends StatefulWidget {
  static String routeName = '/records';

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  final controller = TextEditingController();
  double totalCalories = 0;
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controller.dispose();

  }

  @override
  Widget build(BuildContext context) {

    // AllCalories myCalories = Provider.of<AllCalories>(context);
    FirestoreService fsService = FirestoreService();

    return StreamBuilder<List<Calories>>(

      stream: fsService.getTotalCalories(controller.text),

      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        else {
          // print(snapshot.hasData);

          snapshot.data?.forEach((doc) {
            totalCalories += doc.numCalories;
            // break;
            // print(totalCalories);


          }

          );



          return Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text('Previous Records'),
                elevation: 0,
                brightness: Brightness.light,
                backgroundColor: Color(0xff588157),

              ),
              body: SingleChildScrollView(

                child: Container(

                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(children: [
                    SizedBox(height: 15,),
                    Text('Enter a date to get the total calories ',
                      style: TextStyle(
                        fontSize: 19, fontWeight: FontWeight.w500,),
                      textAlign: TextAlign.left,),
                    Image.asset('images/date.png', alignment: Alignment.center),


                    Form(

                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      //Prevents user from entering empty search field
                      child:
                      TextFormField(
                          controller: controller,
                          //controller helps to retrieve the user input (date)
                          //input is parsed in through the parameters of function in provider and total calories is calculated from there using a for loop
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff588157)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff588157)),
                              ),
                              hintText: 'Enter a search term',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  totalCalories=0;
                                  setState(() {
                                    if (controller.text == null) {
                                      print(totalCalories = 0);
                                    }
                                    else print(totalCalories);
                                  });
                                },
                                icon: Icon(Icons.search),
                                color: Color(0xff588157),)

                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return 'Valid field is required to perform search.';
                            String pattern = r'\d\d\d';
                            if (!RegExp(pattern).hasMatch(value))
                              return 'Please enter a valid date in the field.';
                            return null;
                          }
                      ),
                      //validators ensure that users cannot enter empty value in search field
                    ),


                    SizedBox(height: 20),
                    Row(

                      children: [

                        Text(
                          totalCalories.toString(),
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
              drawer: AppDrawer());
        }
      });
  }
}

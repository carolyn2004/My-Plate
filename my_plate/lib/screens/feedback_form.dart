
import 'package:flutter/material.dart';
import 'package:my_plate/widgets/app_drawer.dart';
import 'package:my_plate/widgets/checkbox2.dart';

import '../services/firestore_service.dart';

class FormApp extends StatefulWidget {
  static String routeName = '/form';

  @override
  _FormAppState createState() => _FormAppState();
}

class _FormAppState extends State<FormApp> {

  FirestoreService fsService = FirestoreService();
  String? issue;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  Map<String, String> fieldValues = {};
  setFieldValue(label, value) {
    fieldValues[label] = value;

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        resizeToAvoidBottomInset: false,//Prevents overflow error
        backgroundColor: Colors.white,
          appBar: AppBar(title: const Text('Feedback Form'),

              backgroundColor: Color(0xff588157),


          ),

          body: Form(

            key: _key,
            child: Container(

              padding: EdgeInsets.all(10),
              child: Column(

                children: [


Image.asset('images/feedback.png',alignment: Alignment.topCenter, height: 170,),
                  TextFormField(
                    maxLines: 10,
                    //obscureText: true,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff588157),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(

                          borderSide: BorderSide(
                            color: Color(0xff588157),
                            width: 0.0,
                          ),
                        ),
                        label: Text('Please describe the issue',style: TextStyle(color: Colors.black)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Field is required.';

                        else if (value.length < 20)
                          return 'Please enter a description that is at least 20 characters.';

else
                        return null;
                      },
                      onSaved: (value) {
                      print(value);
                       issue = value;

                      },
                  onChanged: (value) {
                      print(value);
                  },),


                  CheckboxFormField2(callback: setFieldValue),


                ],

              ),

            ),

          ),

          floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0xff588157),
            child: const Icon(Icons.save),

            onPressed: () {
              if (_key.currentState!.validate()) {
                // _key.currentState!.save();
                FocusScope.of(context).unfocus();
               //hides keyboard

                showAlertDialog();

//show alert dialogue when save button is clicked
              }
            },
          ),
        drawer: AppDrawer()
        );





  }
  void showAlertDialog() {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No",style: TextStyle(color: Color(0xff588157)),),
      onPressed:  () {Navigator.pop(context);},
    );
    Widget continueButton = TextButton(
      child: Text("Yes",style: TextStyle(color: Color(0xff588157))),
      onPressed:  () {
        _key.currentState!.save();
        print(issue);
        fsService.addFeedback(issue);


        //triggers action when user clicks yes
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Form submitted successfully!'),

        ));

        Navigator.pop(context);

      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text("Are you sure you want to submit this form?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );

  }
}



import 'package:flutter/material.dart';

class CheckboxFormField2 extends StatefulWidget {
  final Function callback;
  const CheckboxFormField2({Key? key, required this.callback}) : super(key: key);

  @override
  _CheckboxFormFieldState createState() => _CheckboxFormFieldState();
}

class _CheckboxFormFieldState extends State<CheckboxFormField2> {
  bool checkboxValue2 = false;

  @override
  Widget build(BuildContext context) {
    return FormField(

      builder: (state) {
        return Column(

          children: [

            Text(
              state.errorText ?? '', textAlign: TextAlign.right,
              style: TextStyle(

                color: Theme.of(context).errorColor,
              ),
            ),
            Row(

              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Checkbox(
                  activeColor: Color(0xff588157),
                  value: checkboxValue2,

                  onChanged: (value) {
                    checkboxValue2 = value!;
                    state.didChange(value);
                  },
                ),
                Text('By ticking this box, I agree that any feedback\nsubmitted in this form is truthful. ',
                  textAlign: TextAlign.start,),

              ],
            ),

          ],
        );
      },
      validator: (value) {
        if (!checkboxValue2) return 'You must check this box' ;
        return null;
      },
      onSaved: (value) {
        widget.callback('Check Box', value.toString());
      },

    );


  }
}

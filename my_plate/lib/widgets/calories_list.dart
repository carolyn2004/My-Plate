
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:my_plate/models/calories.dart';


import '../screens/edit_calories_screen.dart';
import '../services/firestore_service.dart';

class CaloriesList extends StatefulWidget {
  @override
  State<CaloriesList> createState() => _CaloriesListState();
}

class _CaloriesListState extends State<CaloriesList> {
  FirestoreService fsService = FirestoreService();
  void removeItem(String id) {
    showDialog<Null>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Confirmation'),
            content: Text('Are you sure you want to delete?'),
//alert dialogue to prompt user before they delete


            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      fsService.removeCalories(id);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('This meal has been deleted!'),
                      ));
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text('Yes',style: TextStyle(color: Color(0xff588157)))),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('No',style: TextStyle(color: Color(0xff588157)))),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // AllCalories CaloriesList = Provider.of<AllCalories>(context);
    return StreamBuilder<List<Calories>>(
        stream: fsService.getCalories(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting ?
          Center(child: CircularProgressIndicator()) :
          ListView.separated(
            itemBuilder: (ctx, i) {
              return Center(
                child: Slidable(
                  key: ValueKey(i),
                  endActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(
                          icon: Icons.delete,
                          foregroundColor: Color(0xff729671),
                          backgroundColor: Color(0xffCAD2C5),
                          onPressed: (ctx) {
                            removeItem(snapshot.data![i].id);
                          })
                    ],
                  ),
                  child: Container(
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            EditCaloriesScreen.routeName,
                            arguments: {'index': i,
                              'selected': snapshot.data![i]
                            });
                        // Navigator.of(context).pushNamed(EditCaloriesScreen.routeName,
                        //     arguments:{'index': i, 'selected': CaloriesList.getMyCalories()[i]});
                        // parse in index of list item to the edit screen so the initial value can appear


                      },

                      leading: CircleAvatar(
                        backgroundColor: Color(0xff588157),
                        maxRadius: 30,
                        child: Text(snapshot.data![i].mealType,
                            style: TextStyle(
                                fontSize: 12, color: Colors.white)),
                      ),
                      title: Text(
                        snapshot.data![i].mealName,
                      ),
                      isThreeLine: true,
                      subtitle: Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  snapshot.data![i].numCalories.toStringAsFixed(2) +
                                      ' KCAL',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(fontStyle: FontStyle.normal),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  snapshot.data?[i].consumptionDate ==
                                      null
                                      ? 'No Date Chosen'
                                      : "" +
                                      DateFormat('dd/MM/yyyy').format(
                                        //format the date to the preferred format
                                          snapshot.data![i].consumptionDate),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      // trailing: IconButton(
                      //   icon: Icon(Icons.delete),
                      //   onPressed: () {
                      //     removeItem(i, CaloriesList);
                      //   },
                      // ),
                    ),
                  ),
                ),
              );
            },
            itemCount: snapshot.data!.length,
            separatorBuilder: (ctx, i) {
              return Divider(height: 3, color: Colors.blueGrey);
            },
          );
        }
    );
  }
}

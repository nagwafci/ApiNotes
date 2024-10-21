import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/create.dart';
import 'package:todo/services.dart';

class Task extends StatelessWidget {
  Task(
      {super.key,
      required this.note,
      required GlobalKey<ScaffoldState> this.skey});
  Map<String, dynamic>? note;
  GlobalKey<ScaffoldState> skey;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Services>(context);
    return Container(
      child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.orange[300]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(note!["title"],
                      style: TextStyle(
                          decoration: note!["is_completed"]
                              ? TextDecoration.lineThrough
                              : TextDecoration.none)),
                ],
              ),
              Row(
                children: [
                  Text(
                    note!["description"],
                    overflow: TextOverflow.clip,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    DateFormat.yMMMMEEEEd()
                        .format(DateTime.parse(note!["created_at"])),
                    style: TextStyle(color: Colors.grey),
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        skey.currentState!
                            .showBottomSheet((context) => CreatePage(
                                  note: note,
                                ));
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Colors.blueAccent,
                      )),
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text("Are You Sure ?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      provider.Delete(note!["_id"]);
                                      Navigator.pop(context);
                                    },
                                    child: Text("yes"),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("No"))
                                ],
                              );
                            });
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      )),
                  Checkbox(
                      shape:
                          CircleBorder(side: BorderSide(color: Colors.white)),
                      value: note!["is_completed"],
                      onChanged: (val) {
                        provider.check(
                            val: val,
                            title: note!["title"],
                            des: note!["description"],
                            iscom: note!["is_completed"],
                            noteid: note!["_id"]);
                      })
                ],
              ),
            ],
          )),
    );
  }
}

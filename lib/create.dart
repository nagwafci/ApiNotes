import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/services.dart';

// ignore: must_be_immutable
class CreatePage extends StatefulWidget {
  Map? note;
  CreatePage({super.key, this.note});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  TextEditingController tasktitle = TextEditingController();
  TextEditingController task = TextEditingController();
  bool isEdit = false;

  @override
  void initState() {
    // TODO: implement initState
    final updateNote = widget.note;
    if (updateNote != null) {
      isEdit = true;
      tasktitle.text = updateNote["title"];
      task.text = updateNote["description"];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Services>(context);
    return Container(
      height: 400,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Task Title"),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: tasktitle,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("Task Description"),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: task,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange),
                          onPressed: () {
                            isEdit
                                ? provider.UpdateData(
                                    noteid: widget.note!["_id"],
                                    title: tasktitle.text,
                                    description: task.text,
                                    iscmplete: isEdit,
                                    context: context)
                                : provider.PostData(
                                    title: tasktitle.text,
                                    description: task.text,
                                    iscmplete: isEdit,
                                    context: context);
                          },
                          child: Text(
                            isEdit ? "Update Task" : "Create Task",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

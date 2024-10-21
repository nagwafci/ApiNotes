import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/create.dart';
import 'package:todo/seeall.dart';
import 'package:todo/services.dart';
import 'package:todo/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<Services>(context, listen: false).FetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List MyData = Provider.of<Services>(context).TodayList;
    final provider = Provider.of<Services>(context);
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      //  backgroundColor: Colors.black,
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          _scaffoldKey.currentState!.showBottomSheet((context) => CreatePage());
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Column(children: [Text("Welcome Back"), Text("Name")]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(
            children: [
              Expanded(
                  child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.orange),
                child: Text(DateFormat.yMMMMEEEEd().format(DateTime.now()),
                    style: const TextStyle(
                      color: Colors.white,
                    )),
              )),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                  style: IconButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  onPressed: () {
                    provider.FetchData();
                  },
                  icon: const Icon(
                    Icons.refresh,
                    color: Colors.white,
                  )),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text("Today's Tasks"),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.orange),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text("${MyData.length}"),
                ),
              )
            ],
          ),
          Row(
            children: [
              const Spacer(),
              ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SeeAll(
                                  skey: _scaffoldKey,
                                )));
                  },
                  child: const Text(
                    "See All",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: MyData.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> Notes =
                        MyData.reversed.toList()[index];
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Task(
                          note: Notes,
                          skey: _scaffoldKey,
                        ));
                  }))
        ]),
      ),
    );
  }
}

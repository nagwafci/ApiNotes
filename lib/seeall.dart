import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/create.dart';
import 'package:todo/services.dart';
import 'package:todo/task.dart';

class SeeAll extends StatefulWidget {
  SeeAll({super.key, required GlobalKey<ScaffoldState> this.skey});
  GlobalKey<ScaffoldState> skey;

  @override
  State<SeeAll> createState() => _SeeAllState();
}

class _SeeAllState extends State<SeeAll> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List MyData = Provider.of<Services>(context).AllList;
    final provider = Provider.of<Services>(context);
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          _scaffoldKey.currentState!.showBottomSheet((context) => CreatePage());
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Column(children: [Text("All Tasks")]),
        actions: [
          IconButton(
              style: IconButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.all(12),
                  shape: CircleBorder()),
              onPressed: () {
                provider.FetchData();
              },
              icon: const Icon(
                Icons.refresh,
                color: Colors.white,
              )),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(children: [
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

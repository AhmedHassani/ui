import 'package:flutter/material.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:newtwork_app/selectable_item.dart';
import 'selection_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Device extends StatefulWidget {
  const Device({Key? key}) : super(key: key);

  @override
  _DeviceState createState() => _DeviceState();
}

class _DeviceState extends State<Device> {
  final controller = DragSelectGridViewController();
  late CollectionReference db;
  @override
  void initState() {
    super.initState();
     db = FirebaseFirestore.instance.collection('db');
  }

  @override
  void dispose() {
    controller.removeListener(scheduleRebuild);
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          elevation:0,
      ),
      body:FutureBuilder<DocumentSnapshot>(
        future: db.doc("device").get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            return GridView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Item(name:data['${index+1}']["name"],image:data['${index+1}']["image"]);
              },
              itemCount: data.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 250,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10
              ),
            );
          }
          return Text("loading");
        },
      ),
    );
  }

  void scheduleRebuild() => setState(() {});
}
/*
GridView.builder(
        itemCount: 6,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 140,
        ),
        itemBuilder: (BuildContext context, int index) {
            return Item();
        },
      )
 */
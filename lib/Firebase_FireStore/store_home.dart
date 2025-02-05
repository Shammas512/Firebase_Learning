import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_learning/Firebase_FireStore/store.add.dart';
import 'package:flutter/material.dart';

class StoreHome extends StatefulWidget {
  const StoreHome({super.key});

  @override
  State<StoreHome> createState() => _StoreHomeState();
}

class _StoreHomeState extends State<StoreHome> {
  final ref = FirebaseFirestore.instance.collection("Users").snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PostDataFire()));
        },
        child: Icon(Icons.unarchive),
      ),
      appBar: AppBar(
        title: Text("Home Store"),
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder(
                  stream: ref,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator(),);
                    }
                    if (!snapshot.hasData) {
                      return Center(
                        child: Text("No data"),
                      );
                    }
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(snapshot.data!.docs[index]["Title"].toString()),
                          );
                        });
                  }))
        ],
      ),
    );
  }
}

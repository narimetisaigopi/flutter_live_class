import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_live_class/post_upload_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreem extends StatefulWidget {
  const HomeScreem({Key? key}) : super(key: key);

  @override
  State<HomeScreem> createState() => _HomeScreemState();
}

class _HomeScreemState extends State<HomeScreem> {
  User user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                User user = FirebaseAuth.instance.currentUser!;
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (builder) => HomeScreem()),
                    (route) => false);
              },
              icon: Icon(Icons.logout_sharp))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("posts").get().asStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: ((context, index) {
                  return Card(
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      child: Column(
                        children: [
                          Image.network(
                            snapshot.data!.docs[index]["url"],
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.fill,
                          ),
                          Text(snapshot.data!.docs[index]["title"]),
                          Text(snapshot.data!.docs[index]["timestamp"]
                              .toDate()
                              .toString()),
                        ],
                      ),
                    ),
                  );
                }));
          }
          return CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (builder) => PostUploadScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

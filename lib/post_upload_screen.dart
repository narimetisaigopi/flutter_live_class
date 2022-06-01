import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart' as p;

class PostUploadScreen extends StatefulWidget {
  const PostUploadScreen({Key? key}) : super(key: key);

  @override
  State<PostUploadScreen> createState() => _PostUploadScreenState();
}

class _PostUploadScreenState extends State<PostUploadScreen> {
  File? pickedImageFile;
  TextEditingController _textEditingController = TextEditingController();

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Post"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            pickedImageFile == null
                ? Center(
                    child: InkWell(
                      onTap: () async {
                        XFile? xFile = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        pickedImageFile = File(xFile!.path);
                        setState(() {});
                      },
                      child: Icon(
                        Icons.add_a_photo_sharp,
                        size: 120,
                      ),
                    ),
                  )
                : Image.file(
                    pickedImageFile!,
                    width: double.infinity,
                    height: 220,
                  ),
            SizedBox(
              height: 40,
            ),
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Title"),
            ),
            SizedBox(
              height: 20,
            ),
            loading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      uploadImage();
                    },
                    child: Text("Submit"))
          ],
        ),
      ),
    );
  }

  uploadImage() {
    setState(() {
      loading = true;
    });
    FirebaseStorage.instance
        .ref()
        .child("posts")
        .child(
            "post_image_${DateTime.now()}." + p.basename(pickedImageFile!.path))
        .putFile(pickedImageFile!)
        .then((snapshot) async {
      String url = await snapshot.ref.getDownloadURL();
      await addToFirestoreDB(url);
    });
  }

  addToFirestoreDB(String url) async {
    Map<String, dynamic> map = HashMap();
    map["url"] = url;
    map["title"] = _textEditingController.text;
    map["timestamp"] = DateTime.now();
    map["uid"] = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection("posts").add(map);
    setState(() {
      loading = false;
    });
    Navigator.pop(context);
  }
}

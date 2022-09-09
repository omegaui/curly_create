
import 'package:firebase_storage/firebase_storage.dart';

FirebaseStorage storage = FirebaseStorage.instanceFor(bucket: "gs://curly-create.appspot.com");
Reference storageRef = storage.ref();
Reference imagesRef = storageRef.child("images");



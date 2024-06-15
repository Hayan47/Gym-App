import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class ImageService {
  //?upload Image
  Future<String?> uploadImages({
    required Uint8List image,
    required String path,
  }) async {
    // final String imageName = imagesName + i.toString();
    final ref = FirebaseStorage.instance.ref().child(path);

    final uploadTask = ref.putData(image);
    // Calculate progress
    // final progress = (uploadTask.snapshot.bytesTransferred /
    //         uploadTask.snapshot.totalBytes *
    //         100)
    //     .toInt();

    // Trigger event with updated progress and uploaded URLs
    // context.read<UploadBloc>().add(UploadProgressEvent(progress: progress, uploadedUrls: uploadedUrls));

    final url = await (await uploadTask).ref.getDownloadURL();
    return url;
    // .snapshotEvents.listen((TaskSnapshot taskSnapshot) async {
    //   switch (taskSnapshot.state) {
    //     case TaskState.running:
    //       final progress =
    //           100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
    //       print("Upload $i is $progress% complete.");
    //       break;
    //     case TaskState.paused:
    //       print("Upload is paused.");
    //       break;
    //     case TaskState.canceled:
    //       print("Upload was canceled");
    //       break;
    //     case TaskState.error:
    //       break;
    //     case TaskState.success:
    //       final imageUrl = ref.getDownloadURL();
    //       print('Uploaded image $i: $imageUrl');
    //   }
    // });
  }
}

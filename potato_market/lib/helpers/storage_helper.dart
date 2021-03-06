import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class StorageHelper{
  // 이미지 asset을 받아서 스토리지에 저장후, url을 리턴
  static Future<List<String>> getImageUrls(List<Asset> assets) async {
    final StorageReference ref = FirebaseStorage.instance.ref().child('product-images');
    List<String> urls = List<String>();

    for (var image in assets) {
      ByteData byteData = await image.getByteData(quality: 50);
      List<int> imageData = byteData.buffer.asUint8List();
      final photoRef = ref.child(DateTime.now().toString() + '.jpg');
      final finRef = await photoRef.putData(imageData).onComplete;
      final String downloadUrl = await finRef.ref.getDownloadURL();
      urls.add(downloadUrl);
    }
    return urls;
  }

  static Future<List<String>> getDefaultProductUrl() async {
    List<String> urls = List<String>();
    final ref = FirebaseStorage.instance
        .ref()
        .child('default-images')
        .child('default-product.png');
    final url = await ref.getDownloadURL();
    urls.add(url);
    return urls;
  }

    static Future<String> getDefaultUserUrl() async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('default-images')
        .child('default-user.png');
    final url = await ref.getDownloadURL();
    return url;
  }
}
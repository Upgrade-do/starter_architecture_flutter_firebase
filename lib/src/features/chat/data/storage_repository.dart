import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show immutable, kIsWeb;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

@immutable
class StorageRepository {
  final _storage = FirebaseStorage.instance;

  Future<String> saveImageToStorage({
    required XFile image,
    required String messageId,
  }) async {
    try {
      Reference ref = _storage.ref('images').child(messageId);
      TaskSnapshot snapshot;

      if (kIsWeb) {
        // If running on web, use bytes
        Uint8List imageBytes = await image.readAsBytes();
        snapshot = await ref.putData(imageBytes);
      } else {
        // If running on mobile, use File
        snapshot = await ref.putFile(File(image.path));
      }

      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

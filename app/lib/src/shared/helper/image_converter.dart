import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

class ImageConverter {
  ImageConverter._();

  static img.Image? base64StringToImage(String base64String) {
    try {
      String withoutPrefix = base64String.split(',').last;
      Uint8List bytes = base64.decode(withoutPrefix);
      img.Image image = img.decodeImage(bytes)!;
      return image;
    } catch (e) {
      return null;
    }
  }

  static String? imageToBase64(String imagePath) {
    try {
      img.Image image = img.decodeImage(Uint8List.fromList(File(imagePath).readAsBytesSync()))!;
      List<int> pngBytes = img.encodePng(image);
      String base64String = base64.encode(pngBytes);
      return base64String;
    } catch (e) {
      return null;
    }
  }
}

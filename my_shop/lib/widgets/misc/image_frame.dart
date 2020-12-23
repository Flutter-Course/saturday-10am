import 'dart:io';

import 'package:flutter/material.dart';

class ImageFrame extends StatelessWidget {
  final File imageFile;
  final String imageUrl;
  final double scale;
  ImageFrame.fromFile(this.imageFile, [this.scale = 1]) : this.imageUrl = null;
  ImageFrame.fromNetwork(this.imageUrl, [this.scale = 1])
      : this.imageFile = null;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.black,
      radius: 80.1 * scale,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 80 * scale,
        child: CircleAvatar(
          backgroundColor: Colors.black,
          radius: 70 * scale,
          child: CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 70 - 0.1 * scale,
            backgroundImage: (imageFile != null)
                ? FileImage(imageFile)
                : (imageUrl != null)
                    ? NetworkImage(imageUrl)
                    : null,
            child: (imageFile == null && imageUrl == null)
                ? Center(
                    child: Icon(
                      Icons.image,
                      color: Colors.white,
                      size: 40,
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}

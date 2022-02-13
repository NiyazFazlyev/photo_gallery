import 'dart:io';

import 'package:flutter/material.dart';

import '../../image_page.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    Key? key,
    required this.file,
  }) : super(key: key);

  final File? file;

  @override
  Widget build(BuildContext context) {
    final fileCopy = file;
    return GestureDetector(
      onTap: fileCopy != null
          ? () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) {
                    return ImagePage(fileCopy);
                  },
                ),
              )
          : null,
      child: Container(
        decoration: BoxDecoration(border: Border.all()),
        alignment: Alignment.center,
        child: fileCopy != null ? Image.file(fileCopy) : Image.asset('assets/images/placeholder.png'),
      ),
    );
  }
}

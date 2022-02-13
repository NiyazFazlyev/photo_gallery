import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ImagePage extends StatelessWidget {
  const ImagePage(this.file, {Key? key}) : super(key: key);

  final File file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Platform.isIOS ? CupertinoIcons.share : Icons.share),
            onPressed: () {
              Share.shareFiles([file.path]);
            },
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Image.file(file),
        ),
      ),
    );
  }
}

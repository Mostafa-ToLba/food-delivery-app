
import 'package:flutter/material.dart';

class ProfilePicPhotoOpen extends StatelessWidget {
  String Image;

  ProfilePicPhotoOpen( this.Image, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(image: DecorationImage(image: NetworkImage('${this.Image}')))
    );
  }
}

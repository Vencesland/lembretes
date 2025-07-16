import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:transparent_image/transparent_image.dart';

class CustomImage extends StatelessWidget {


  final String image;
  final String title;
  final String subtitle;

  CustomImage({super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });


  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Card(
      elevation: 20,
      shadowColor: Colors.black,
      color: Colors.blueAccent[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child:
            //FadeInImage.memoryNetwork(image: image, placeholder: kTransparentImage, fit: BoxFit.cover,),
            Image(
              image: AssetImage(image),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );


  }
}
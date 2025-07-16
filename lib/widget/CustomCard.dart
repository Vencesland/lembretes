import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class CustomCard extends StatelessWidget{

  final String image;
  final String title;
  final String subtitle;

  CustomCard({super.key,
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
              Image.asset(image, fit: BoxFit.scaleDown,),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: AutoSizeText(
                title,
                style: TextStyle(fontSize: 20.0),
                overflow: TextOverflow.ellipsis,
                minFontSize: 10.0,
                maxLines: 2,
              ),
            ),
            Expanded(
              child: AutoSizeText(
                subtitle,
                style: TextStyle(fontSize: 15.0),
                overflow: TextOverflow.ellipsis,
                minFontSize: 15.0,
                maxLines: 2,
              ),
            ),


          ],
        ),
    );


  }
}
import 'package:flutter/material.dart';

class CustomList extends StatelessWidget{

  final String image;
  final String title;
  final String subtitle;

  CustomList({super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(decoration: BoxDecoration(
      border:Border.all(
        color: Colors.red
      ),
        borderRadius: BorderRadius.circular(30),
    ),
      child: SizedBox(
      width: 160,
      height: 160,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child:
            //FadeInImage.memoryNetwork(image: image, placeholder: kTransparentImage, fit: BoxFit.cover,),
            Image.asset(image, fit: BoxFit.scaleDown,),
          ),
          Column(
            children: [
              Text(title),
              SizedBox(width: 50,height: 20,),
              Text(subtitle),
            ],
          ),
        ],
      ),
    )
    );
  }

}
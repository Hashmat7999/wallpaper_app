

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:wallpaper_3pm/photos.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';


class PhotosDetailScreen extends StatefulWidget {
  final Photo photo;
  const PhotosDetailScreen({Key? key,
  required this.photo}) : super(key: key);

  @override
  _PhotosDetailScreenState createState() => _PhotosDetailScreenState();
}

class _PhotosDetailScreenState extends State<PhotosDetailScreen> {
  @override
  Widget build(BuildContext context) {
      return Scaffold(

        body: Stack(
          children: [
              Positioned.fill(
                child: Image.network(
                    widget.photo.full, fit:BoxFit.cover),),
            Positioned(
                left: 50,
                right: 50,
                bottom: 50,
                child:Container(
                  decoration:   BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.white24,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 20,
                        blurStyle:BlurStyle.outer,
                        spreadRadius: 5,
                        color: Colors.cyan,
                      )
                    ]
                  ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                          onPressed: ()async{
                          bool?  result=
                          await GallerySaver.saveImage(widget.photo.regular +'.jpg');
                          if( result != null && result == true){
                            print('Image Downloaded');
                       }
                         },
                          child:
                          const Text('Download ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                            backgroundColor: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            ),
                           )
                          ),

                           OutlinedButton(onPressed: () async{
                              File cachedImage= await DefaultCacheManager().getSingleFile(widget.photo.regular);  //image file
                              int location = WallpaperManagerFlutter.BOTH_SCREENS;  //Choose screen type
                              WallpaperManagerFlutter().setwallpaperfromFile(cachedImage, location);
                           },
                               child:
                               const Text('Set As Wallpaper ',
                                 style: TextStyle(
                                 fontWeight: FontWeight.bold,
                                 fontSize:  14,
                                  backgroundColor: Colors.black,

                        ),
                      ))
                    ],
                  ),
                )
            ),
          ],
        )
      );
  }
}

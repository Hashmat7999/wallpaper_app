import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:wallpaper_3pm/PhotosDetailScreen.dart';
import 'package:wallpaper_3pm/photos.dart';
import 'package:wallpaper_3pm/topic.dart';
import 'config.dart';
import 'package:wallpaper_3pm/navbar.dart';

class TopicsListScreen extends StatefulWidget {
  const TopicsListScreen({Key? key}) : super(key: key);

  @override
  _TopicsListState createState() => _TopicsListState();
}


class _TopicsListState extends State<TopicsListScreen> {
  int selectedIndex=0;
  late StreamController _topicStreamController;
  late Stream _topicStream;
  late StreamController _photoStreamController;
  late Stream _photoStream;


  getAllPhotos(String photoUrl) async{

    _photoStreamController.add('loading');
       String finalPhotoUrl=photoUrl+ '?client_id=TnAS8MuDgDlSS5GQQtR4xaVEpOo1P3zIFwHrxXpz0tI&per_page=30   ';
     http.Response response=await http.get(Uri.parse(finalPhotoUrl));

     if (response.statusCode==200){
         var jsonList=json.decode(response.body);
         List<Photo> photos=[];
         for (var jsonPhoto in jsonList){
           Photo photo=Photo.fromJson(jsonPhoto);
           photos.add(photo);
         }
         _photoStreamController.add(photos);
     }else{
       _photoStreamController.add('Wrong');
     }

}

  getAlTopics() async{
   http.Response response=await http.get(Uri.parse(Config.topicUrl));
   if (response.statusCode ==200){
   var jsonList=json.decode(response.body);
   List<Topic> topicList=[];
   for (var jsonTopic in jsonList){
     Topic topic=Topic.fromJson(jsonTopic);
     topicList.add(topic);
   }
   _topicStreamController.add(topicList);

   }

   else{
     _topicStreamController.add('wrong');

   }
  }
  @override
  void initState(){
    _topicStreamController = StreamController();
    _topicStream=_topicStreamController.stream;
    _photoStreamController=StreamController();
    _photoStream=_photoStreamController.stream;
    getAlTopics();
    _topicStreamController.add('loading');
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title:  const Text('Wallpaper',
        style: TextStyle(
          fontStyle: FontStyle.normal,
          decorationColor: Colors.red,
          fontWeight:FontWeight.bold,
          fontSize: 26,
          color: Colors.white
        ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:   [
          const Text('Trending Topics',
              style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.white,
              height: 2.1,
              fontStyle: FontStyle.normal,
            ),
          ),
          SizedBox(
            height: 72,
            child: StreamBuilder(
              stream: _topicStream,
              builder: (context, snapshot){
               if (snapshot.hasData){
                 if(snapshot.data =='loading'){
                   return const Center(child: CircularProgressIndicator());
                 }
                 else if(snapshot.data=='wrong'){
                     return const Center(
                     child: Text('Something went wrong'),
                   );
                 }
                 else{
                   List<Topic> topics=snapshot.data as List<Topic>;
                   return ListView.builder(
                       itemCount: topics.length,
                       scrollDirection:Axis.horizontal,
                       itemBuilder: (context, index){
                         Topic topic=topics[index];

                         return InkWell(
                           onTap: (){
                             setState(() {
                               selectedIndex=index;
                             }
                             );
                             getAllPhotos(topic.photos);
                         },
                           child: Container(
                               margin: const EdgeInsets.symmetric(vertical: 12,horizontal: 12),
                               padding: const EdgeInsets.all((14)),
                               decoration:   BoxDecoration(
                                 color: Colors.black,
                                 borderRadius:BorderRadius.circular(12),
                                 boxShadow: const [
                                   BoxShadow(
                                     blurRadius: 12,
                                     blurStyle: BlurStyle.outer,
                                     color: Colors.white54,
                                   )
                                 ]
                               ),
                                 child : Text(topic.title,
                                 style:  TextStyle(
                                   fontStyle: FontStyle.normal,
                                   fontSize: 16,
                                   fontWeight: FontWeight.bold,
                                   color: selectedIndex == index ? Colors.grey:Colors.cyanAccent,
                                 ),
                               )
                              ),
                             );
                           }
                          );
                         }
                        }
               else{
                      return const Center (
                      child: CircularProgressIndicator(),
                   );
                  }
                },
              )
            ),
            const SizedBox(
            height: 18,
          ),
            const Text('Photos',
            style: TextStyle(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
              fontSize: 30,
              letterSpacing: 2,
              decorationColor: Colors.grey,
              color: Colors.white,
            ),
          ),

             const SizedBox(
             height: 12,
           ),

           Expanded(child: StreamBuilder(
               stream: _photoStream,
               builder:(context, snapshot){
                 if (snapshot.hasData) {
                 if (snapshot.data == 'loading') {
                     return const Center (
                     child: CircularProgressIndicator(),
                   );
                 }
                   else if (snapshot.data == 'wrong') {
                   return const Center (
                     child: Text('Something went wrong'),
                   );
                 }

                   else {
                   List<Photo> photos = snapshot.data as List<Photo>;
                   return GridView.builder(
                         itemCount: photos.length,
                         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount (
                         mainAxisExtent: 220,
                         childAspectRatio: 10,
                         crossAxisSpacing: 10,
                         mainAxisSpacing: 15,
                         crossAxisCount: 2,
                       ),
                         itemBuilder: (context, index) {
                         Photo photo=photos[index];
                             return InkWell(
                               onTap: (){
                               Navigator.of(context).push(MaterialPageRoute(builder: (_)
                                {
                                 return PhotosDetailScreen(photo: photo);
                                 }
                                )
                               );
                              },

                               child: Container(
                                 padding: EdgeInsets.zero,
                                 decoration:  BoxDecoration(
                                 borderRadius: BorderRadius.circular(20.6),
                                 image:DecorationImage(
                                 image: NetworkImage(photo.thumb),
                                   fit: BoxFit.cover,
                                 )
                               ),
                             ),
                           );
                          }
                         );
                        }
                       }

               else{
                   return const Center (
                   child: CircularProgressIndicator(),
                  );
                 }
                }
               )
              )
             ],
            )
          );
         }
        }


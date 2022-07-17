class Config{


   static const topicUrl=
       "https://api.unsplash.com/topics/?client_id=TnAS8MuDgDlSS5GQQtR4xaVEpOo1P3zIFwHrxXpz0tI&per_page=30";
     static String getPhotosUrl(String photosUrl){
     return  photosUrl+
       '?client_id=TnAS8MuDgDlSS5GQQtR4xaVEpOo1P3zIFwHrxXpz0tI&per_page=30"';
 }
}
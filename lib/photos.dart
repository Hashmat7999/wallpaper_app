class Photo{
  late String regular;
  late String raw;
  late String full;
  late String small;
  late String thumb;
  Photo({
    required this.raw,
    required this.regular,
    required this.small,
    required this.thumb,
    required this.full,
});
  factory Photo.fromJson(Map<String, dynamic>map){
    return Photo(raw: map['urls']['raw'], regular: map['urls']['regular'], small: map['urls']['small'], thumb: map['urls']['thumb'], full: map['urls']['full'],);
  }



}
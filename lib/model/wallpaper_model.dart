class WallpaperModel{
  String photographer;
  String photographerUrl;
  String photographerId;
  SrcModel src;

  WallpaperModel({this.src,this.photographerUrl,this.photographerId,this.photographer});

  factory WallpaperModel.fromMap(Map<String,dynamic> jsonData){
    return WallpaperModel(
      src: SrcModel.fromMap(jsonData["src"]),
      photographerUrl: jsonData["photographer_url"],
      photographerId: jsonData["photographer_id"].toString(),
      photographer: jsonData["photographer"]
    );
  }
}

class SrcModel{
  String original;
  String small;
  String portrait;

  SrcModel({this.portrait,this.original,this.small});

  factory SrcModel.fromMap(Map<String,dynamic> jsonData){
    return SrcModel(
        portrait: jsonData["portrait"],
        original: jsonData["original"],
        small: jsonData["small"]
    );
  }
}
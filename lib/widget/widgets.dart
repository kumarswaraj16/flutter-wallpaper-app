import 'package:flutter/material.dart';
import 'package:flutter_app_wallpaperhub/model/wallpaper_model.dart';
import 'package:flutter_app_wallpaperhub/views/image_view.dart';

Widget BrandName() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        "Wallpaper",
        style: TextStyle(color: Colors.black87),
      ),
      Text(
        "Hub",
        style: TextStyle(color: Colors.blue),
      ),
    ],
  );
}

Widget WallpapersList({List<WallpaperModel> wallpapers, context}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: wallpapers
          .map((wallpaper) =>
          GridTile(
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ImageView(
                    imageUrl: wallpaper.src.portrait,
                  ),),);
              },
              child: Hero(
                tag: wallpaper.src.portrait,
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.network(
                      wallpaper.src.portrait,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ))
          .toList(),
    ),
  );
}

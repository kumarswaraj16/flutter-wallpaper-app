import 'dart:convert';
import 'package:flutter_app_wallpaperhub/widget/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_app_wallpaperhub/data/data.dart';
import 'package:flutter_app_wallpaperhub/model/wallpaper_model.dart';

class Categories extends StatefulWidget {

  final String categoriesName;
  Categories({this.categoriesName});

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

  List<WallpaperModel> wallpapers = new List();

  getSearchWallpapers(String query) async {
    var response = await http.get(
        "https://api.pexels.com/v1/search?query=$query&per_page=100",
        headers: {"Authorization": apiKey});
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });
    setState(() {});
  }

  @override
  void initState() {
    getSearchWallpapers(widget.categoriesName);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BrandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 16.0,
              ),
              WallpapersList(wallpapers: wallpapers, context: context),
            ],
          ),
        ),
      ),
    );
  }
}

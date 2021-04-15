import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_wallpaperhub/data/data.dart';
import 'package:flutter_app_wallpaperhub/model/categories_model.dart';
import 'package:flutter_app_wallpaperhub/model/wallpaper_model.dart';
import 'package:flutter_app_wallpaperhub/views/categories.dart';
import 'package:flutter_app_wallpaperhub/views/image_view.dart';
import 'package:flutter_app_wallpaperhub/views/search.dart';
import 'package:flutter_app_wallpaperhub/widget/widgets.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoriesModel> categories = new List();
  List<WallpaperModel> wallpapers = new List();

  TextEditingController searchController = new TextEditingController();

  getTrendingWallpapers() async {
    var response = await http.get(
        "https://api.pexels.com/v1/curated?per_page=100&page=1",
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
    getTrendingWallpapers();
    categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: BrandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff5f8fd),
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                margin: EdgeInsets.symmetric(
                  horizontal: 24.0,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: "Search Wallpapers",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Search(
                              searchQuery: searchController.text,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        child: Icon(Icons.search),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Container(
                height: 80,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoriesTile(
                      title: categories[index].categoriesName,
                      imageUrl: categories[index].imageUrl,
                    );
                  },
                ),
              ),
              SizedBox(
                height: 16,
              ),
              WallpapersList(wallpapers: wallpapers, context: context),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoriesTile extends StatelessWidget {
  final String imageUrl, title;

  CategoriesTile({this.title, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Categories(
                      categoriesName: title.toLowerCase(),
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 4.0),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                imageUrl,
                height: 50,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              color: Colors.black26,
              height: 50,
              width: 100,
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 15.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

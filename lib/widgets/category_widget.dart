// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';
import 'package:shop_mate/models/category_model.dart';
import 'package:shop_mate/screens/user_panel/all_category_product_screen.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  final futureFireBase =
      FirebaseFirestore.instance.collection('categories').get();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureFireBase,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Error"),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: Get.height / 5,
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        }

        if (snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text("No category found!"),
          );
        }

        if (snapshot.data != null) {
          return Container(
            height: Get.height / 5.0,
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                CategoryModel categoriesModel = CategoryModel(
                  categoryId: snapshot.data!.docs[index]['categoryId'],
                  categoryImg: snapshot.data!.docs[index]['categoryImg'],
                  categoryName: snapshot.data!.docs[index]['categoryName'],
                  createdAt: snapshot.data!.docs[index]['createdAt'],
                  updatedAt: snapshot.data!.docs[index]['updatedAt'],
                );
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.to(() => AllCategoryProductScreen(
                            categoryId: categoriesModel.categoryId,
                          )),
                      child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Container(
                          child: FillImageCard(
                            borderRadius: 14.0,
                            width: Get.width / 4.0,
                            heightImage: Get.height / 10,
                            imageProvider: CachedNetworkImageProvider(
                              categoriesModel.categoryImg,
                            ),
                            title: Center(
                              child: Text(
                                categoriesModel.categoryName,
                                style: TextStyle(fontSize: 12.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }
}

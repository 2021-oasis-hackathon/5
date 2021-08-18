import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Menu {
  final int id;
  final String name;
  final String detail;
  final int price;
  final String image;
  final int shopId;
  final bool recommend;

  Menu({
    required this.id,
    required this.name,
    required this.detail,
    required this.price,
    required this.image,
    required this.shopId,
    required this.recommend,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return new Menu(
      id: json['id'],
      name: json['name'],
      detail: json['detail'],
      price: json['price'],
      image: json['image'],
      shopId: json['shop_id'],
      recommend: json['recommend'],
    );
  }

  Widget toWidgetListItem() {
    return Container(
      child: Card(
        child: InkWell(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      this.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      this.price.toString() + "원",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(
                      height: 100,
                      width: 100,
                      imageUrl: this.image,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          new Icon(Icons.error),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget toWidgetRecommend() {
    return Container(
      width: 300,
      padding: EdgeInsets.all(8),
      alignment: Alignment.center,
      child: Card(
        child: InkWell(
          onTap: () {},
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      height: 70,
                      imageUrl: this.image,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          new Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  verticalDirection: VerticalDirection.up,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 10, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            this.name,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            this.price.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

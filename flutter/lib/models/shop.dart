import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Shop {
  final int id;
  final String name;
  final String detail;
  final double latitude;
  final double longitude;
  final String location;
  final String openTime;
  final int orderCount;
  final String image;

  Shop(
      {required this.id,
      required this.name,
      required this.detail,
      required this.latitude,
      required this.longitude,
      required this.location,
      required this.openTime,
      required this.orderCount,
      required this.image});

  factory Shop.fromJson(Map<String, dynamic> json) {
    return new Shop(
      id: json['id'],
      name: json['name'],
      detail: json['detail'],
      latitude: double.parse(json['latitude']),
      longitude: double.parse(json['longitude']),
      location: json['location'],
      openTime: json['open_time'],
      orderCount: json['order_count'],
      image: json['image'],
    );
  }

  Widget toWidget() {
    return Container(
      child: Card(
        child: Row(
          children: [
            Container(
              child: Column(
                children: [
                  Text(
                    this.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(this.openTime),
                  Text(this.location),
                ],
              ),
            ),
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  this.image,
                  height: 100.0,
                  width: 100.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget toWidgetGridTile() {
    return Container(
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
                      height: 140,
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
                          Row(
                            children: [
                              Icon(Icons.circle, color: Colors.green, size: 8),
                              Text(this.openTime,
                                  style: TextStyle(fontSize: 12)),
                            ],
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

  // create_table "shops", force: :cascade do |t|
  //   t.string "name"
  //   t.text "detail"
  //   t.decimal "latitude", precision: 10, scale: 6
  //   t.decimal "longitude", precision: 10, scale: 6
  //   t.string "location"
  //   t.string "open_time"
  //   t.integer "order_count", default: 0
  //   t.string "image"
  //   t.datetime "created_at", precision: 6, null: false
  //   t.datetime "updated_at", precision: 6, null: false
  //   t.integer "host_id"
  // end

    //   {
    //     "id": 1,
    //     "name": "마라마라탕",
    //     "detail": "마라탕을 팔아요.",
    //     "latitude": "123.123123",
    //     "longitude": "123.123123",
    //     "location": "경원대로 1234",
    //     "open_time": "09:00 ~ 23:00",
    //     "order_count": 0,
    //     "image": "www.image.com/image/1234.jpg",
    //     "created_at": "2021-08-16T11:33:37.330Z",
    //     "updated_at": "2021-08-16T11:33:37.330Z",
    //     "host_id": 1
    // }
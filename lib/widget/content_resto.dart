import 'package:flutter/material.dart';
import 'package:submissionfundamental/data/model/restauran_response.dart';
import 'package:submissionfundamental/ui/restodetail_page.dart';
import 'package:submissionfundamental/utils/styles.dart';

class ContentResto extends StatelessWidget {
  final Restaurant resto;
  const ContentResto({required this.resto});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          DetailRestoPage.routeName,
          arguments: resto.id,
        );
      },
      child: Column(children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(left: 40, bottom: 20),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Hero(
                      tag: resto.pictureId,
                      child: Image.network(
                        "https://restaurant-api.dicoding.dev/images/medium/${resto.pictureId}",
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ))),
            ),
            Expanded(
              child: Container(
                height: 100,
                width: 200,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    color: Colors.white70),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        resto.name,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 16,
                            color: secondaryColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            resto.city,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(resto.rating.toString())
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ]),
    );
  }
}

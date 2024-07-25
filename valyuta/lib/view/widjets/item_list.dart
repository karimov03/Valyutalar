import 'package:flutter/material.dart';
import '../../model/api_data.dart';

class ItemList extends StatelessWidget {
  final List<ApiData> data;

  const ItemList(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            padding: EdgeInsets.all(10),
            constraints: BoxConstraints(maxWidth: 400, maxHeight: 80),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 22, 24, 39),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "1 ${data[index].Ccy}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "${data[index].CcyNm_UZ}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white54,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                        height: 40,
                        child: Text(
                          "${data[index].Rate} uzs",
                          style: TextStyle(color: Colors.white),
                        )),
                    Row(
                      children: [
                        Container(
                          height: 20,
                          child: Image(
                            image: (double.parse(data[index].Diff) >= 0)
                                ? AssetImage("lib/images/ic_trending_up.png")
                                : AssetImage("lib/images/ic_trending_down.png"),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${data[index].Diff}",
                          style: TextStyle(
                              color: (double.parse(data[index].Diff) >= 0)
                                  ? Colors.green
                                  : Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

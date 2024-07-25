import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valyuta/model/api_data.dart';
import 'package:valyuta/view_model/provider/data_provider.dart';
import '../widjets/home_chart.dart';

class HomePage extends StatefulWidget {
  final List<ApiData> data;

  const HomePage(this.data, {Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 11, 12, 21),
      body: HomeBody(widget.data),
    );
  }

  Widget HomeBody(List<ApiData> data) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 11, 12, 21),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 15, 216, 137),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 32.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Valyuta",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  "Valyutalar > Aqsh dollari",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                ),
                              ),
                              Card(
                                color: Colors.white38,
                                elevation: 8,
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                                                    child: Container(
                                    constraints: BoxConstraints(maxWidth: 100),
                                    child: Text(
                                      "USD",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 24.0, right: 5.0, top: 5.0),
                              child: Text(
                                "${data[0].Rate}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 28.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5.0, right: 24.0, top: 17.0),
                              child: Text(
                                "UZS",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0.0, left: 24.0, bottom: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Bugungi o'sish ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "${data[0].Diff} uzs",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Icon(
                                        (double.parse(data[0].Diff) > 0)
                                            ? Icons.trending_up_outlined
                                            : Icons.trending_down_outlined,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
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
            SizedBox(height: 10),
            Container(
              color: const Color.fromARGB(255, 11, 12, 21),
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0, right: 24.0, left: 24.0, bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        "Oxirgi yangilanish",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        " ${data[0].Date.day}/${data[0].Date.month}/${data[0].Date.year}  00:00:00",
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 14.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(child: CandlestickChart()),
          ],
        ),
      ),
    );
  }
}


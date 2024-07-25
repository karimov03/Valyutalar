import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valyuta/view_model/provider/data_provider.dart';
import '../../view_model/provider/chip_provider.dart';
import '../widjets/line_chart.dart';
import 'package:shimmer/shimmer.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DataProvider>(context, listen: false).allData();
      Provider.of<DataProvider>(context, listen: false)
          .fetchCurrencyData("USD");
      Provider.of<DataProvider>(context, listen: false).fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);

    return ChangeNotifierProvider(
      create: (_) => SelectedChipProvider(),
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 11, 12, 21),
        body: SingleChildScrollView(
          child: Container(
            color: Color.fromARGB(255, 11, 12, 21),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    "Diagramma",
                    style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                dataProvider.isLoading
                    ? _buildLoadingLayout()
                    : Consumer<SelectedChipProvider>(
                        builder: (context, selectedChipProvider, child) {
                          if (dataProvider.alldata.isNotEmpty &&
                              selectedChipProvider.selectedChipIndex <
                                  dataProvider.alldata.length) {
                            final selectedCurrency = dataProvider
                                .alldata[selectedChipProvider.selectedChipIndex]
                                .Ccy;
                            dataProvider.fetchCurrencyData(selectedCurrency);
                            return dataProvider.isLoading
                                ? _buildShimmerEffect()
                                : LineChartWidget();
                          } else {
                            return Container(); // Zarur bo'lsa mos xabarni ko'rsatish
                          }
                        },
                      ),
                dataProvider.isallLoading
                    ? _buildLoadingLayout()
                    : Container(
                        height: 70, // Zarur bo'lsa balandlikni sozlang
                        child: Consumer<SelectedChipProvider>(
                          builder: (context, selectedChipProvider, child) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: dataProvider.alldata.length,
                              itemBuilder: (context, index) {
                                final isSelected =
                                    selectedChipProvider.selectedChipIndex ==
                                        index;
                                final chipColor = isSelected
                                    ? Colors.green
                                    : Color.fromARGB(255, 11, 12, 21);

                                return GestureDetector(
                                  onTap: () {
                                    selectedChipProvider.selectChip(index);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Chip(
                                      label: Text(
                                        dataProvider.alldata[index].CcyNm_UZ
                                            .toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      backgroundColor: chipColor,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                dataProvider.isallLoading
                    ? _buildLoadingLayout()
                    : Padding(
                        padding: const EdgeInsets.only(
                            left: 24.0, right: 24.0, top: 0),
                        child: Container(
                          alignment: Alignment.center,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.green,
                          ),
                          height: 110,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Consumer<SelectedChipProvider>(
                                builder:
                                    (context, selectedChipProvider, child) {
                                  if (dataProvider.alldata.isEmpty ||
                                      selectedChipProvider.selectedChipIndex >=
                                          dataProvider.alldata.length) {
                                    return Container(); // Zarur bo'lsa mos xabarni ko'rsatish
                                  }
                                  return Text(
                                    "${dataProvider.alldata[selectedChipProvider.selectedChipIndex].Rate} uzs",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 32.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  );
                                },
                              ),
                              Consumer<SelectedChipProvider>(
                                builder:
                                    (context, selectedChipProvider, child) {
                                  if (dataProvider.alldata.isEmpty ||
                                      selectedChipProvider.selectedChipIndex >=
                                          dataProvider.alldata.length) {
                                    return Container(); // Zarur bo'lsa mos xabarni ko'rsatish
                                  }
                                  return Text(
                                    "1 ${dataProvider.alldata[selectedChipProvider.selectedChipIndex].Ccy}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingLayout() {
    return Center(
      child: Container(
        color: Color.fromARGB(255, 11, 12, 21),
        child: Column(
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            SizedBox(height: 16),
            Text(
              "Ma'lumotlar yuklanmoqda...",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        height: 400,
        width: double.infinity,
        color: Colors.white,
      ),
    );
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../controller/data_store.dart';
import '../../service/scrapper/a101_scrapper.dart';
import '../navigatescreen.dart';

class MilkandBreakfast extends StatefulWidget {
  const MilkandBreakfast({Key? key}) : super(key: key);

  @override
  _MilkandBreakfast createState() => _MilkandBreakfast();
}

class _MilkandBreakfast extends State<MilkandBreakfast>
    with SingleTickerProviderStateMixin {
  Color _color = const Color(0xFF1D92B1);
  TabController? _tabController;
  final a101product = A101Scrapper();

  @override
  void initState() {
    a101product.fetchProduct();
    _tabController = TabController(length: 3, vsync: this);

    _tabController?.addListener(() {
      setState(() {
        changeColor(_tabController!.index);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 15.0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              NavigateScreen.navigationController.jumpToTab(0);

              NavigateScreen.navigationController.index = 0;
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30,
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.elliptical(50, 50),
            ),
          ),
          backgroundColor: const Color(0xFFF6FAFB),
          title: const Text(
            'Milk And Breakfast',
            style: TextStyle(
              color: Color(0xFF403537),
              fontSize: 23,
              fontFamily: 'Gilroy',
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: TabBar(
                    controller: _tabController,
                    labelColor: Colors.green,
                    isScrollable: true,
                    onTap: (value) {
                      /*  setState(() {
                        changeColor(value);
                      }); */
                    },
                    automaticIndicatorColorAdjustment: true,
                    indicatorColor: _color,
                    unselectedLabelColor: Colors.grey,
                    unselectedLabelStyle: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w700,
                    ),
                    labelStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    tabs: <Widget>[
                      Row(
                        children: [
                          Image.asset(
                            'assets/a101.jpg',
                            height: 30,
                            width: 70,
                          ),
                        ],
                      ),
                      Image.asset(
                        'assets/sok.png',
                        height: 40,
                        width: 70,
                      ),
                      Image.asset(
                        'assets/migros.png',
                        height: 30,
                        width: 100,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      FutureBuilder(
                          future: DataStore().singletonFetch(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 2 / 2,
                                          crossAxisSpacing: 20,
                                          mainAxisSpacing: 2),
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color:
                                                Colors.grey.withOpacity(0.3)),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      borderOnForeground: true,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: Column(
                                          children: [
                                            Image.network(
                                              '${snapshot.data[index].productImage}',
                                              height: 80,
                                              width: 80,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0),
                                              child: AutoSizeText(
                                                '${snapshot.data[index].productName}',
                                                maxLines: 2,
                                                style: const TextStyle(
                                                  fontFamily: 'Gilroy',
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                AutoSizeText(
                                                    '${snapshot.data[index].productPrice}',
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                        fontFamily: 'Gilroy')),
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                      Icons.add,
                                                      size: 30,
                                                      color: Color(0xFF1D92B1),
                                                    )),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                      const Center(
                        child: Text(
                          'Şok',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w600),
                        ),
                      ),
                      const Center(
                        child: Text(
                          'Migros',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Color changeColor(int index) {
    if (index == 0) {
      return _color = const Color(0xFF1D92B1);
    } else if (index == 1) {
      return _color = const Color(0xFF0B4190);
    } else {
      return _color = Colors.orange;
    }
  }
}

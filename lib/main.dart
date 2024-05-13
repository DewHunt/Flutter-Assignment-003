import 'package:assignment_003/product_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ProductData allProductsData = ProductData();
  int grandTotalAmount = 0;

  int calculateItemTotalAmount(int index) {
    int price = allProductsData.allProducts[index]['price'];
    int quantity = allProductsData.allProducts[index]['quantity'];
    int amount = price * quantity;
    allProductsData.allProducts[index]['totalAmount'] = amount;
    return amount;
  }

  void calculateTotalAmount() {
    grandTotalAmount = allProductsData.allProducts
        .map((item) => item['totalAmount'] as int)
        .reduce((a, b) => a + b);
  }

  int calculateTotalQuantity() {
    int totalQuantity = allProductsData.allProducts
        .map((item) => item['quantity'] as int)
        .reduce((a, b) => a + b);
    return totalQuantity;
  }

  @override
  Widget build(BuildContext context) {
    calculateTotalAmount();
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: Search(),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            height: MediaQuery.of(context).size.height - kToolbarHeight,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      'My Bag',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          scrollDirection: Axis.vertical,
                          itemCount: allProductsData.allProducts.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 20,
                              shadowColor: Colors.black,
                              color: Colors.white,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 110,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      ),
                                      child: Image.asset(
                                        allProductsData.allProducts[index]['image'],
                                        width: 110,
                                        height: 150,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    allProductsData.allProducts[index]
                                                        ['productName'],
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                  const Icon(Icons.more_vert),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    "Color: ",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  Text(
                                                    allProductsData.allProducts[index]
                                                        ['color'],
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  const Text(
                                                    "Size: ",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  Text(
                                                    allProductsData.allProducts[index]
                                                        ['size'],
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  IconButton(
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: Colors.white,
                                                    ),
                                                    onPressed: () {
                                                      if (allProductsData
                                                                  .allProducts[index]
                                                              ["quantity"] >
                                                          1) {
                                                        setState(() {
                                                          allProductsData
                                                                  .allProducts[index]
                                                              ["quantity"]--;
                                                          calculateItemTotalAmount(
                                                              index);
                                                          calculateTotalAmount();
                                                        });
                                                      }
                                                    },
                                                    icon: const Icon(
                                                      Icons.remove,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(10),
                                                    child: Text(
                                                      '${allProductsData.allProducts[index]["quantity"]}',
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                  IconButton(
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: Colors.white,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        allProductsData
                                                                .allProducts[index]
                                                            ["quantity"]++;
                                                        calculateItemTotalAmount(
                                                            index);
                                                        calculateTotalAmount();
                                                        if (allProductsData
                                                                    .allProducts[
                                                                index]['quantity'] >=
                                                            5) {
                                                          showDialog(
                                                            context: context,
                                                            builder: (ctx) =>
                                                                AlertDialog(
                                                              title: const Text(
                                                                "Congratulations!",
                                                                textAlign:
                                                                    TextAlign.center,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                              ),
                                                              content: Text(
                                                                "You have added\n${allProductsData.allProducts[index]['quantity']}\n${allProductsData.allProducts[index]['productName']} on your bag!",
                                                                textAlign:
                                                                    TextAlign.center,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight.w700,
                                                                ),
                                                              ),
                                                              actions: [
                                                                SizedBox(
                                                                  width:
                                                                      double.infinity,
                                                                  child:
                                                                      ElevatedButton(
                                                                    style:
                                                                        ElevatedButton
                                                                            .styleFrom(
                                                                      backgroundColor:
                                                                          Colors.red,
                                                                      foregroundColor:
                                                                          Colors
                                                                              .white,
                                                                      textStyle:
                                                                          const TextStyle(
                                                                        fontSize: 20,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                      ),
                                                                    ),
                                                                    onPressed: () {
                                                                      Navigator.of(
                                                                              ctx)
                                                                          .pop();
                                                                    },
                                                                    child: const Text(
                                                                        "Okay"),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        }
                                                      });
                                                    },
                                                    icon: const Icon(
                                                      Icons.add,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(10),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment.end,
                                                        children: [
                                                          Text(
                                                            '৳${allProductsData.allProducts[index]["totalAmount"]}',
                                                            style: const TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight.w500,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              margin: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total Amount:",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          '৳$grandTotalAmount',
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text(
                              "Congratulations!",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            content: Text(
                              "You have added total\n${calculateTotalQuantity()} items on your bag!\nTotal Amount ৳$grandTotalAmount",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            actions: [
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    textStyle: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: const Text("Okay"),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      child: const Text("Check Out"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Search extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    // Actions for the search bar (e.g., clear query button)
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Leading icon on the left of the search bar (e.g., back button)
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, 'null');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Build the results based on the query
    return Center(
      child: Text('Search Results for: $query'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Suggestions based on the query
    final List<String> suggestions = [
      'Pullover',
      'T-Shirt',
      'Sport Dress',
    ];

    final List<String> suggestionList = query.isEmpty
        ? suggestions
        : suggestions
            .where((suggestion) => suggestion.startsWith(query))
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestionList[index]),
          onTap: () {
            query = suggestionList[index];
            // You can also close the search page and navigate to a new screen
            // Navigator.push(context, MaterialPageRoute(builder: (context) => SearchResultPage(query)));
          },
        );
      },
    );
  }
}

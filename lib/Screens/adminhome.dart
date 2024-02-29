// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:progamingadminapp/Screens/category_view/category.dart';
import 'package:progamingadminapp/Screens/notifications.dart';
import 'package:progamingadminapp/Screens/product_view/product.dart';
import 'package:progamingadminapp/Screens/singledashitem.dart';
import 'package:progamingadminapp/Screens/user_view.dart/userview.dart';
import 'package:progamingadminapp/provider/app_provider.dart';
import 'package:provider/provider.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  // Add your data loading logic here
  Future<void> _refreshData() async {
    getData();
    await Future.delayed(const Duration(seconds: 2)); 
    // Update your data
  }

  bool isLoading = false;

  void getData() {
    setState(() {
      isLoading = true;
    });
     AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
     appProvider.callBackFunction();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Dashboard",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refreshData,
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage("lib/asset/photo_2024-02-29_15-01-17.jpg"),
                        radius: 30,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text(
                        "Farhan ps",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text("Admin panel",
                          style: TextStyle(fontSize: 18)),
                      const SizedBox(
                        height: 12,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const NotificationPage(),
                          ));
                        },
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.purple,
                          ),
                          child: const Center(
                            child: Text(
                              "Send notification to All users",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        ),
                      const SizedBox(
                        height: 12,
                      ),
                      GridView.count(
                        shrinkWrap: true,
                        primary: false,
                        padding: const EdgeInsets.only(top: 12),
                        crossAxisCount: 2,
                        children: [
                          SingleDashItem(
                            title: appProvider.getUserList.length.toString(),
                            subtitle: "Users",
                            onpressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const UserView(),
                              ));
                            },
                          ),
                          SingleDashItem(
                            title:
                                appProvider.getCategoriesList.length.toString(),
                            subtitle: "Categories",
                            onpressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const CategoryView(),
                              ));
                            },
                          ),
                          SingleDashItem(
                            title: appProvider.getproductList.length.toString(),
                            subtitle: "Products",
                            onpressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ProductView(),
                              ));
                            },
                          ),
                          // SingleDashItem(
                          //   title: "\$${appProvider.getTotalEarning}",
                          //   subtitle: "Earnings",
                          //   onpressed: () {
                          //     // Handle earnings tap
                          //   },
                          // ),
                          // SingleDashItem(
                          //   title:
                          //       appProvider.getPendingOrdersList.length.toString(),
                          //   subtitle: "Pending Order",
                          //   onpressed: () {
                          //     Navigator.of(context).push(MaterialPageRoute(
                          //       builder: (context) => const OrderList(
                          //         title: "pending",
                          //       ),
                          //     ));
                          //   },
                          // ),
                          // SingleDashItem(
                          //   title: appProvider
                          //       .getCompletedOrdersList.length
                          //       .toString(),
                          //   subtitle: "Completed Order",
                          //   onpressed: () {
                          //     Navigator.of(context).push(MaterialPageRoute(
                          //       builder: (context) => const OrderList(
                          //         title: "completed",
                          //       ),
                          //     ));
                          //   },
                          // ),
                          // SingleDashItem(
                          //   title:
                          //       appProvider.getCanceledOrdersList.length.toString(),
                          //   subtitle: "Canceled Order",
                          //   onpressed: () {
                          //     Navigator.of(context).push(MaterialPageRoute(
                          //       builder: (context) => const OrderList(
                          //         title: "cancel",
                          //       ),
                          //     ));
                          //   },
                          // ),
                          // SingleDashItem(
                          //   title: appProvider
                          //       .getDeliveryOrdersList.length
                          //       .toString(),
                          //   subtitle: "Delivery Order",
                          //   onpressed: () {
                          //     Navigator.of(context).push(MaterialPageRoute(
                          //       builder: (context) => const OrderList(
                          //         title: "Delivery",
                          //       ),
                          //     ));
                          //   },
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
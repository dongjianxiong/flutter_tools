//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'base_list_data_provider.dart';
//
// mixin CustomRefresh<T extends BaseListDataProvider> {
//   final RefreshController refreshController =
//   RefreshController(initialRefresh: false);
//
//   Widget smartRefresh(BuildContext context,
//       {required Widget child, required T provider}) {
//     return SmartRefresher(
//       controller: refreshController,
//       onRefresh: () {
//         provider.refreshData().then((value) {
//           if(provider.isFailed) {
//             refreshController.refreshFailed();
//           } else {
//             refreshController.refreshCompleted();
//           }
//         });
//       },
//       onLoading: () {
//         provider.loadMoreData().then((value) {
//           if(provider.isFailed) {
//             refreshController.loadFailed();
//           } else {
//             refreshController.loadComplete();
//           }
//         });
//       },
//       enablePullUp: provider.hasMore,
//       child: child,
//     );
//   }
// }
//
// // class CustomListViewRefresh<T extends BaseListDataProvider> {
// //   final RefreshController refreshController =
// //   RefreshController(initialRefresh: false);
// //   Widget smartRefresh(BuildContext context,
// //       {required Widget child, required T provider}) {
// //     return Consumer<T>(
// //       builder: (context, provider, child1){
// //         return smartRefresh(
// //           context,
// //           provider: provider,
// //           child: ListView.builder(
// //             itemBuilder: (BuildContext context, int index){
// //               return Text(provider.dataList[index]);
// //             },
// //             itemCount: provider.dataList.length,
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }
//
// // /// demo1 ----- 不使用自定义刷新控价
// // class HomeListDataProvider<String> extends ChangeNotifier with ListDataRequest<String> {
// //   @override
// //   void reloadData() {
// //     if(hasListeners) {
// //       notifyListeners();
// //     }
// //   }
// //
// //   @override
// //   @protected
// //   Future<BaseModel?> loadData(int page) async {
// //     List<String> data = [];
// //     return BaseModel(code: 200, msg: 'succeed', data:data);
// //   }
// //
// // }
//
// // class ListView1 extends StatelessWidget {
// //   final RefreshController refreshController =
// //   RefreshController(initialRefresh: false);
// //   @override
// //   Widget build(BuildContext context) {
// //     return ChangeNotifierProvider<HomeListDataProvider>(
// //       create: (BuildContext context){
// //         return HomeListDataProvider();
// //       },
// //       child: Consumer<HomeListDataProvider>(
// //         builder: (context, provider, child){
// //           return SmartRefresher(
// //             controller: refreshController,
// //             onRefresh: () {
// //               provider?.refreshData().then((value) {
// //                 if (provider?.isFailed ?? false) {
// //                   refreshController.refreshFailed();
// //                 } else {
// //                   refreshController.refreshCompleted();
// //                 }
// //               });
// //             },
// //             onLoading: () {
// //               provider?.loadMoreData().then((value) {
// //                 if (provider?.isFailed ?? false) {
// //                   refreshController.refreshFailed();
// //                 } else {
// //                   refreshController.refreshCompleted();
// //                 }
// //               });
// //             },
// //             enablePullUp: provider?.noMore ?? false,
// //             child: ListView.builder(
// //               itemBuilder: (BuildContext context, int index){},
// //               itemCount: provider.dataList.length,
// //             ),
// //           );
// //         }
// //       ),
// //     );
// //   }
// // }
//
//
// /// demo2 ---- 使用刷新控件
// // class HomeListDataProvider<String> extends BaseListDataProvider {
// //
// //   void reloadData() {
// //     if(hasListeners) {
// //       notifyListeners();
// //     }
// //   }
// //
// //   Future<BaseModel?> loadData(int page) async {
// //     List<String> data = [];
// //     return BaseModel(code: 200, msg: 'succeed', data:data);
// //   }
// //
// // }
// // class ListView1 extends StatelessWidget with CustomRefresh {
// //   @override
// //   Widget build(BuildContext context) {
// //     return ChangeNotifierProvider<HomeListDataProvider>(
// //       create: (BuildContext context){
// //         return HomeListDataProvider();
// //       },
// //       child: Consumer<HomeListDataProvider>(
// //         builder: (context, provider, child){
// //           return smartRefresh(
// //             context,
// //             child: ListView.builder(
// //               itemBuilder: (BuildContext context, int index){},
// //               itemCount: provider.dataList.length,
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }

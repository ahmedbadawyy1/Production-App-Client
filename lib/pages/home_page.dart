import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:footwareclient/controller/home_controller.dart';
import 'package:footwareclient/pages/login_page.dart';
import 'package:footwareclient/pages/product_description_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../widgets/dropdown_btn.dart';
import '../widgets/multi_select_drop_down.dart';
import '../widgets/product_card.dart';




class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return RefreshIndicator(
        onRefresh: () async {
          ctrl.fetchProducts();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Footware Store',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  GetStorage box = GetStorage();
                  box.erase();
                  Get.offAll(LoginPage());
                },
                icon: Icon(Icons.logout),
              )
            ],
          ),
          body: Column(
            children: [
              SizedBox(
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: ctrl.productCategory.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          ctrl.filterByCategory(
                              ctrl.productCategory[index].name ?? "");
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Chip(
                              label: Text(ctrl.productCategory[index].name ??
                                  'No name')),
                        ),
                      );
                    }),
              ),
              Row(
                children: [
                  Flexible(
                    child: DropDownBtn(
                      items: ['Low to High', " High to Low"],
                      SelectedItem: 'sort',
                      onSelected: (Selected) {
                        ctrl.sortByPrice(
                            ascending:
                                Selected == "Low to High" ? true : false);
                      },
                    ),
                  ),
                  Flexible(
                      child: MultiSelectDropDown(
                    items: ['Adidas', 'Puma', 'Clarks', 'Sketchers'],
                    onSelectionChanged: (selectedItems) {
                      ctrl.filterByBrand(selectedItems);
                    },
                  ))
                ],
              ),
              Expanded(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: ctrl.productShowInUi.length,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          name: ctrl.productShowInUi[index].name ?? 'No name',
                          imageurl: ctrl.productShowInUi[index].image ?? 'url',
                          price: ctrl.productShowInUi[index].price ?? 00,
                          offerTag: '30 % off',
                          onTap: () {
                            Get.to(ProductDescriptionPage(), arguments: {
                              'data': ctrl.productShowInUi[index]
                            });
                          },
                        );
                      })),
            ],
          ),
        ),
      );
    });
  }
}

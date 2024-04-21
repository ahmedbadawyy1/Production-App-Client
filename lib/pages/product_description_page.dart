import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/products/product.dart';


class ProductDescriptionPage extends StatelessWidget {
  const ProductDescriptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Product product  = Get.arguments['data'];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Product Details",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                 product.image ?? "",
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: 200,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                product.name ?? "",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                product.description ?? "",
                style: TextStyle(fontSize: 15, height: 1.5),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "RS: ${product.price ?? ''}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.green,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                maxLines: 4,
                decoration: InputDecoration(
                    labelText: 'Enter your Billing address',
                    hintText: 'Enter your Billing address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  onPressed: () {  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepPurple
                  ),
                  child: Text(
                    'Buy Now'
                  ) ,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

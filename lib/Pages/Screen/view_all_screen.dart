import 'package:flutter/material.dart';
import 'package:food_delivery_app/Core/models/product_model.dart';
import 'package:food_delivery_app/Widgets/products_items_display.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ViewAllProductScreen extends StatefulWidget {
  const ViewAllProductScreen({super.key});

  @override
  State<ViewAllProductScreen> createState() => _ViewAllProductScreenState();
}

class _ViewAllProductScreenState extends State<ViewAllProductScreen> {
  final supabase = Supabase.instance.client;
  List<FoodModel> products = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchFoodProduct();
  }

  // to fetch product data from supabase
  Future<void> fetchFoodProduct() async {
    try {
      final response = await Supabase.instance.client
          .from("food_product")
          .select();
      final data = response as List;

      setState(() {
        products = data.map((json) => FoodModel.fromJson(json)).toList();
        isLoading = false;
      });
    } catch (error) {
      print("Error fetching Product: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text("All Products"),
        backgroundColor: Colors.blue[50],
        forceMaterialTransparency: true,
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              itemCount: products.length,
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // two items per row
                childAspectRatio: 0.59,
                crossAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                return ProductsItemsDisplay(foodModel: products[index]);
              },
            ),
    );
  }
}

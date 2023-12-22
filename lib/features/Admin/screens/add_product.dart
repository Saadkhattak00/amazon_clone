import 'dart:io';

import 'package:amazon_clone/common/widgets/Custom_TextFeild.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/Custom_button.dart';
import '../Services/admin_services.dart';

class AddProduct extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final AdminServices adminServices = AdminServices();


  String category = 'Mobiles';
  List<File> images = [];
  final _addProductFormKey = GlobalKey<FormState>();

  @override

  void dispose(){
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion',
  ];


  void sellProduct(){
    if(_addProductFormKey.currentState!.validate() && images.isNotEmpty){
      adminServices.sellProduct(
          context: context,
          name: productNameController.text,
          description: descriptionController.text,
          price: double.parse(priceController.text),
          quantity: double.parse(quantityController.text),
          category: category,
          images: images
      );
    }
  }

  void selectImages() async{
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }


  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()
      {FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
    }
    },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appbarGradient,
              ),
            ),
            title: const Text('Add Product',
            style: TextStyle(
              color: Colors.black,
            ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _addProductFormKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  images.isNotEmpty
                      ? CarouselSlider(
                    options: CarouselOptions(
                      height: 200,
                      viewportFraction: 1,
                    ),
                    items: images.map((i){
                      return Builder(builder: (BuildContext context) => Image.file(
                        i,
                        fit: BoxFit.cover,
                        height: 200,
                      ),);
                    },).toList(),
                  ) :
                  GestureDetector(
                    onTap: selectImages,
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(10),
                      dashPattern: const [10,4],
                      strokeCap: StrokeCap.round,
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.folder_open,
                            size: 40,
                            ),
                            const SizedBox(height: 15,),
                            Text("Select Product Images",style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade400,
                            ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Custom_TextField(
                      controller: productNameController,
                      hint: 'Product Name',
                  ),
                  const SizedBox(height: 10,),
                  Custom_TextField(
                    controller: descriptionController,
                    hint: 'Description',
                    maxLines: 7,
                  ),
                  const SizedBox(height: 10,),
                  Custom_TextField(
                    controller: priceController,
                    hint: 'Price',
                  ),
                  const SizedBox(height: 10,),
                  Custom_TextField(
                    controller: quantityController,
                    hint: 'Quantity',
                  ),
                  const SizedBox(height: 10,),
                  SizedBox(
                    width: double.infinity,
                    child: DropdownButton(
                      value: category,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items:productCategories.map((String item) {
                        return DropdownMenuItem(
                          value: item,
                            child: Text(item),);
                      }).toList(),
                      onChanged: (String? new_value) {
                        setState(() {
                          category = new_value!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 10,),
                  CustomButton(
                    onTap: sellProduct,
                    text: 'Sell',
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ) ;
  }
}

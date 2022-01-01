import 'package:flutter/material.dart';
import 'package:ono_frontend/models/product.dart';
import 'package:ono_frontend/service/api_gateway.dart';

import 'admin_app_bar.dart';

class AdminPage extends StatefulWidget {
  AdminPage({Key? key}) : super(key: key);

  static const String adminPageRoute = '/admin';

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final TextEditingController _newItemProductID = TextEditingController();
  final TextEditingController _newItemTitle = TextEditingController();
  final TextEditingController _newItemDescription = TextEditingController();
  final TextEditingController _newItemPrice = TextEditingController();
  final TextEditingController _newItemQuantity = TextEditingController();
  final TextEditingController _newItemTags = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const AdminAppBar(title: 'Overnight Office'),
      body: Center(
        child: Container(
          alignment: Alignment.topCenter,
          width: screenSize.width * .7,
          height: screenSize.height,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.topCenter,
                  child: const Text('Product Management')),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CreateProductField(
                              title: 'Product ID',
                              controller: _newItemProductID),
                        ),
                        IconButton(
                            onPressed: () {
                              if (_newItemProductID.text == '') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    margin: EdgeInsets.all(10),
                                    content: Text('Please enter a product ID'),
                                  ),
                                );
                              } else {
                                ApiGateway.getProduct(_newItemProductID.text)
                                    .then((item) {
                                  if (item.productID == '') {
                                    //if no item exists show snackbar
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        behavior: SnackBarBehavior.floating,
                                        margin: EdgeInsets.all(10),
                                        content: Text('No item found'),
                                      ),
                                    );
                                  }
                                  _newItemTitle.text = item.title;
                                  _newItemDescription.text =
                                      item.description ?? '';
                                  _newItemPrice.text = item.price;
                                  _newItemQuantity.text = item.quantity ?? '';
                                  _newItemTags.text = item.tags ?? '';
                                });
                              }
                            },
                            icon: const Icon(Icons.search))
                      ],
                    ),
                    CreateProductField(
                        title: 'Title', controller: _newItemTitle),
                    CreateProductField(
                        title: 'Price', controller: _newItemPrice),
                    CreateProductField(
                        title: 'Description', controller: _newItemDescription),
                    CreateProductField(
                        title: 'Quantity', controller: _newItemQuantity),
                    CreateProductField(title: 'Tags', controller: _newItemTags),
                    //FileUploadInputElement(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: () {
                                String message = '';
                                if (_formKey.currentState!.validate()) {
                                  ApiGateway.createProduct(Product(
                                          productID: _newItemProductID.text,
                                          title: _newItemTitle.text,
                                          price: _newItemPrice.text,
                                          description: _newItemDescription.text,
                                          quantity: _newItemQuantity.text,
                                          tags: _newItemTags.text))
                                      .then((status) {
                                    if (status) {
                                      message = 'Product created/updated';
                                    } else {
                                      message = 'Operation failed';
                                    }
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        behavior: SnackBarBehavior.floating,
                                        margin: const EdgeInsets.all(10),
                                        content: Text(message),
                                      ),
                                    );
                                  });
                                }
                              },
                              child: const Text('Create/Update Product')),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              style:
                                  ElevatedButton.styleFrom(primary: Colors.red),
                              onPressed: () {
                                String message = '';
                                ApiGateway.deleteProduct(_newItemProductID.text)
                                    .then((status) {
                                  if (status) {
                                    message = 'Product deleted';
                                  } else {
                                    message = 'Operation failed';
                                  }
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      margin: const EdgeInsets.all(10),
                                      content: Text(message),
                                    ),
                                  );
                                  _newItemProductID.text = '';
                                  _newItemTitle.text = '';
                                  _newItemDescription.text = '';
                                  _newItemPrice.text = '';
                                  _newItemQuantity.text = '';
                                  _newItemTags.text = '';
                                });
                              },
                              child: const Text('Delete Product')),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CreateProductField extends StatelessWidget {
  const CreateProductField(
      {Key? key,
      required TextEditingController controller,
      required String title})
      : _controller = controller,
        _title = title,
        super(key: key);

  final TextEditingController _controller;
  final String _title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 100, child: Text(_title)),
        Expanded(
          child: TextFormField(
            controller: _controller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '$_title is required';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}

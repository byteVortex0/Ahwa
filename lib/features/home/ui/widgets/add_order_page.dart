import 'package:ahwa/features/home/logic/get_top_selling_drinks/get_top_selling_drinks_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/order_model.dart';
import '../../logic/add_orders/add_orders_cubit.dart';
import '../../logic/get_all_orders/get_all_orders_cubit.dart';

class AddOrderPage extends StatefulWidget {
  const AddOrderPage({super.key});

  @override
  State<AddOrderPage> createState() => _AddOrderPageState();
}

class _AddOrderPageState extends State<AddOrderPage> {
  TextEditingController customerNameController = TextEditingController();
  TextEditingController instructionsController = TextEditingController();

  String? selectedDrink;

  @override
  void dispose() {
    customerNameController.dispose();
    instructionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Customer Name"),
          TextField(
            controller: customerNameController,
            decoration: InputDecoration(
              hintText: "Enter customer name",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text("Drink Type"),
          DropdownButtonFormField<String>(
            hint: const Text("Select drink type"),
            items: const [
              DropdownMenuItem(value: "shai", child: Text("Shai")),
              DropdownMenuItem(value: "turkish", child: Text("Turkish Coffee")),
              DropdownMenuItem(value: "hibiscus", child: Text("Hibiscus Tea")),
            ],
            value: selectedDrink,
            onChanged: (value) {
              setState(() {
                selectedDrink = value;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text("Special Instructions"),
          TextField(
            controller: instructionsController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: "Add special instructions",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 20),
          BlocConsumer<AddOrdersCubit, AddOrdersState>(
            listener: (context, state) {
              if (state is AddOrdersSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Order added successfully')),
                );

                customerNameController.clear();
                instructionsController.clear();
                setState(() {
                  selectedDrink = null;
                });
              }
              if (state is AddOrdersError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
              }
            },
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  if (customerNameController.text.isEmpty ||
                      selectedDrink == null ||
                      instructionsController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill all the fields')),
                    );
                    return;
                  }
                  context.read<AddOrdersCubit>().addOrder(
                    OrderModel(
                      customerName: customerNameController.text,
                      drinkType: selectedDrink!,
                      instructions: instructionsController.text,
                      isCompleted: false,
                    ),
                  );
                  context.read<GetAllOrdersCubit>().getAllOrders();
                  context
                      .read<GetTopSellingDrinksCubit>()
                      .getTopSellingDrinks();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Add Order",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

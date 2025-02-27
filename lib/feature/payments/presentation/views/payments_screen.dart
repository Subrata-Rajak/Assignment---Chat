import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../../../core/common/widgets/custom/reusable_text_field.dart';
import '../../static/payment_services.dart';

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  TextEditingController amountController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  final formKey4 = GlobalKey<FormState>();
  final formKey5 = GlobalKey<FormState>();
  final formKey6 = GlobalKey<FormState>();

  List<String> currencyList = <String>[
    'USD',
    'INR',
    'EUR',
    'JPY',
    'GBP',
    'AED'
  ];
  String selectedCurrency = 'USD';

  bool hasDonated = false;

  Future<void> initPaymentSheet() async {
    try {
      // 1. create payment intent on the client side by calling stripe api
      final data = await createPaymentIntent(
          // convert string to double
          amount: (int.parse(amountController.text) * 100).toString(),
          currency: selectedCurrency,
          name: nameController.text,
          address: addressController.text,
          pin: pincodeController.text,
          city: cityController.text,
          state: stateController.text,
          country: countryController.text);

      // 2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Set to true for custom flow
          customFlow: false,
          // Main params
          merchantDisplayName: 'Test Merchant',
          paymentIntentClientSecret: data['client_secret'],
          // Customer keys
          customerEphemeralKeySecret: data['ephemeralKey'],
          customerId: data['id'],

          style: ThemeMode.dark,
        ),
      );
    } catch (e) {
      mounted
          ? ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: $e')),
            )
          : null;
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Image(
              image: NetworkImage(
                  "https://img.freepik.com/free-vector/global-recognised-credit-card-concept-background_1017-36206.jpg"),
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            hasDonated
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Thanks for your ${amountController.text} $selectedCurrency donation",
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        const Text(
                          "We appreciate your support",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent.shade400),
                            child: const Text(
                              "Donate again",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                hasDonated = false;
                                amountController.clear();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Support us with your donations",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: ReusableTextField(
                                formKey: formKey,
                                controller: amountController,
                                isNumber: true,
                                title: "Donation Amount",
                                hint: "Any amount you like",
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            DropdownMenu<String>(
                              inputDecorationTheme: InputDecorationTheme(
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ),
                              initialSelection: currencyList.first,
                              onSelected: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  selectedCurrency = value!;
                                });
                              },
                              dropdownMenuEntries: currencyList
                                  .map<DropdownMenuEntry<String>>(
                                      (String value) {
                                return DropdownMenuEntry<String>(
                                    value: value, label: value);
                              }).toList(),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ReusableTextField(
                          formKey: formKey1,
                          title: "Name",
                          hint: "Ex. John Doe",
                          controller: nameController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ReusableTextField(
                          formKey: formKey2,
                          title: "Address Line",
                          hint: "Ex. 123 Main St",
                          controller: addressController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 5,
                                child: ReusableTextField(
                                  formKey: formKey3,
                                  title: "City",
                                  hint: "Ex. New Delhi",
                                  controller: cityController,
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 5,
                              child: ReusableTextField(
                                formKey: formKey4,
                                title: "State (Short code)",
                                hint: "Ex. DL for Delhi",
                                controller: stateController,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: ReusableTextField(
                                formKey: formKey5,
                                title: "Country (Short Code)",
                                hint: "Ex. IN for India",
                                controller: countryController,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 5,
                              child: ReusableTextField(
                                formKey: formKey6,
                                title: "Pincode",
                                hint: "Ex. 123456",
                                controller: pincodeController,
                                isNumber: true,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent.shade400),
                            child: const Text(
                              "Proceed to Pay",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            onPressed: () async {
                              if (formKey.currentState!.validate() &&
                                  formKey1.currentState!.validate() &&
                                  formKey2.currentState!.validate() &&
                                  formKey3.currentState!.validate() &&
                                  formKey4.currentState!.validate() &&
                                  formKey5.currentState!.validate() &&
                                  formKey6.currentState!.validate()) {
                                await initPaymentSheet();

                                try {
                                  await Stripe.instance.presentPaymentSheet();

                                  context.mounted
                                      ? ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              "Payment Done",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            backgroundColor: Colors.green,
                                          ),
                                        )
                                      : null;

                                  setState(() {
                                    hasDonated = true;
                                  });
                                  nameController.clear();
                                  addressController.clear();
                                  cityController.clear();
                                  stateController.clear();
                                  countryController.clear();
                                  pincodeController.clear();
                                } catch (e) {
                                  debugPrint("payment sheet failed");
                                  context.mounted
                                      ? ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              "Payment Failed",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            backgroundColor: Colors.redAccent,
                                          ),
                                        )
                                      : null;
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

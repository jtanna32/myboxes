import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myboxes/feature/home/home_view.dart';

class EnterNumberView extends StatefulWidget {
  const EnterNumberView({Key? key}) : super(key: key);

  @override
  _EnterNumberViewState createState() => _EnterNumberViewState();
}

class _EnterNumberViewState extends State<EnterNumberView> {
  TextEditingController numberController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text("Screen 1"),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// enter number texfield
                TextFormField(
                  controller: numberController,
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: false, signed: false),
                  decoration: InputDecoration(hintText: "Please Enter"),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "number cannot be empty";
                    }
                    if (int.parse(value) > 25) {
                      return "Number should be less than 25";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  color: Colors.blue,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeView(
                                    number: int.parse(numberController.text),
                                  )));
                    }
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

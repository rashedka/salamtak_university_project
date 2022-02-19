import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salamtak_university_project/SignUp/SignUp.dart';
import 'package:salamtak_university_project/Api/auth.dart';
import 'package:salamtak_university_project/utilities/SalamtakButton.dart';
import 'package:salamtak_university_project/utilities/textFieldSalamtak.dart';

class SigninForm extends StatefulWidget {
  const SigninForm({Key? key}) : super(key: key);

  @override
  _SigninFormState createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String error = '';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthServices>(context);
    return LayoutBuilder(
      builder: (context, size) => SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Card(
            color: Color(0xff232323),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.maxHeight * 0.08,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: SalamtakTextField(
                    label: 'id_number',
                    iconData: Icon(Icons.perm_identity),
                    textEditingController: _usernameController,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SalamtakTextField(
                    label: 'password',
                    iconData: Icon(Icons.lock),
                    textEditingController: _passwordController,
                    isPassword: true,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter password';
                      }
                      if (value.length <= 7) {
                        return 'password length too short';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: size.maxWidth,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: TextButton(
                      onPressed: () {},
                      child: Text('Forget_Password?'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'don\'t have account',
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Signup()));
                          },
                          child: const Text('Create_Account'))
                    ],
                  ),
                ),
                loading ? const CircularProgressIndicator() :
                SalamtakButton(
                  buttonText: 'sign in',
                  onpressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() => loading = true);
                      dynamic result = await user.signIn(
                          _usernameController.text, _passwordController.text);
                      if (result == null) {
                        setState(() {
                          loading = false;
                          error = 'Could not sign in with those credentials';
                        });
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

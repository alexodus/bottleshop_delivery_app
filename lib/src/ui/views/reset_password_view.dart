import 'package:bottleshopdeliveryapp/src/ui/widgets/form_input_field_with_icon.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/loader_widget.dart';
import 'package:bottleshopdeliveryapp/src/utils/validator.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/sign_up_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

final formKeyProvider = Provider((_) => GlobalKey<FormState>());

class ResetPasswordView extends HookWidget {
  static const routeName = '/resetPassword';

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context).settings.arguments ?? '';
    final emailController = useTextEditingController(text: email);
    final formKey = useProvider(formKeyProvider);
    final signInState = useProvider(signUpViewModelProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Loader(
        inAsyncCall: signInState.isLoading,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    buildFormContainerTop(context: context),
                    buildFormContainer(
                      context: context,
                      child: buildFormFields(
                        context: context,
                        onResetClicked: () async {
                          if (formKey.currentState.validate()) {
                            await signInState
                                .sendResetPasswordEmail(emailController.text);
                            emailController.clear();
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Check your email and follow the instructions to reset your password'),
                            ));
                          }
                        },
                      ),
                    ),
                  ],
                ),
                buildPrimaryButton(
                  context,
                  'Got your new password?',
                  ' Sign In',
                  () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFormFields(
      {BuildContext context,
      VoidCallback onResetClicked,
      TextEditingController email}) {
    return Column(
      children: <Widget>[
        SizedBox(height: 25),
        Text('Reset password', style: Theme.of(context).textTheme.headline2),
        SizedBox(height: 20),
        FormInputFieldWithIcon(
          style: TextStyle(color: Theme.of(context).accentColor),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              hintText: 'Email Address',
              hintStyle: Theme.of(context).textTheme.bodyText2.merge(
                    TextStyle(color: Theme.of(context).accentColor),
                  ),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).accentColor.withOpacity(0.2))),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).accentColor),
              ),
              prefixIcon: Icon(
                Icons.mail_outline,
                color: Theme.of(context).accentColor,
              )),
          controller: email,
          validator: Validator().email,
          onChanged: (value) => null,
          onSaved: (value) => email.text = value,
          maxLines: 1,
        ),
        SizedBox(height: 70),
        FlatButton(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 70),
          onPressed: onResetClicked,
          child: Text(
            'Reset ',
            style: Theme.of(context).textTheme.headline6.merge(
                  TextStyle(color: Theme.of(context).primaryColor),
                ),
          ),
          color: Theme.of(context).accentColor,
          shape: StadiumBorder(),
        ),
        SizedBox(height: 70),
      ],
    );
  }

  Widget buildPrimaryButton(
      BuildContext context, String label, String title, Function onPress) {
    return FlatButton(
      onPressed: onPress,
      child: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.headline6.merge(
                TextStyle(color: Theme.of(context).primaryColor),
              ),
          children: [
            TextSpan(text: label),
            TextSpan(
                text: title, style: TextStyle(fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }

  Widget buildFormContainerTop({BuildContext context}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      margin: EdgeInsets.symmetric(vertical: 65, horizontal: 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).primaryColor.withOpacity(0.6),
      ),
    );
  }

  Widget buildFormContainer({BuildContext context, Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
      margin: EdgeInsets.symmetric(vertical: 85, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).hintColor.withOpacity(0.2),
              offset: Offset(0, 10),
              blurRadius: 20)
        ],
      ),
      child: child,
    );
  }
}

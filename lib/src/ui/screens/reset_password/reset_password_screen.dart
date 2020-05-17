import 'package:bottleshopdeliveryapp/src/core/utils/validator.dart';
import 'package:bottleshopdeliveryapp/src/core/viewmodels/screens/reset_password_view_model.dart';
import 'package:bottleshopdeliveryapp/src/ui/screens/sign_in/sign_in_screen.dart';
import 'package:bottleshopdeliveryapp/src/ui/shared/form_input_field_with_icon.dart';
import 'package:bottleshopdeliveryapp/src/ui/shared/loader_widget.dart';
import 'package:bottleshopdeliveryapp/src/ui/view_model_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ResetPasswordScreen extends StatefulWidget {
  static final routeName = '/reset-password';

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isButtonDisabled = false;
  String email = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    email = ModalRoute.of(context).settings.arguments;
    _email.text = email;
    return ViewModelProvider<ResetPasswordViewModel>(
      model: ResetPasswordViewModel(context: context),
      builder: (model) {
        return Scaffold(
          backgroundColor: Theme.of(context).accentColor,
          key: _scaffoldKey,
          body: Loader(
            inAsyncCall: model.isBusy,
            child: Form(
              key: _formKey,
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
                              if (_formKey.currentState.validate()) {
                                await model.sendResetPasswordEmail(_email.text);
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
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
      },
    );
  }

  Widget buildFormFields({BuildContext context, Function onResetClicked}) {
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
              prefixIcon: FaIcon(
                FontAwesomeIcons.envelope,
                color: Theme.of(context).accentColor,
              )),
          controller: _email,
          validator: Validator().email,
          onChanged: (value) => null,
          onSaved: (value) => _email.text = value,
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

  signInLink() {
    if ((email == '') || (email == null)) {
      return FlatButton(
        onPressed: () =>
            Navigator.pushReplacementNamed(context, SignInScreen.routeName),
        child: Text('Sign in'),
      );
    }
    return Container(width: 0, height: 0);
  }
}

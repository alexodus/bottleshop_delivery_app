import 'package:bottleshopdeliveryapp/src/core/utils/validator.dart';
import 'package:bottleshopdeliveryapp/src/core/viewmodels/screens/sign_in_view_model.dart';
import 'package:bottleshopdeliveryapp/src/ui/screens/reset_password/reset_password_screen.dart';
import 'package:bottleshopdeliveryapp/src/ui/screens/sign_up/sign_up_screen.dart';
import 'package:bottleshopdeliveryapp/src/ui/shared/form_input_field_with_icon.dart';
import 'package:bottleshopdeliveryapp/src/ui/shared/loader_widget.dart';
import 'package:bottleshopdeliveryapp/src/ui/shared/social_media.dart';
import 'package:bottleshopdeliveryapp/src/ui/view_model_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInScreen extends StatefulWidget {
  static const String routeName = '/sign-in';
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _showPassword = false;
  bool _formAutoValidOn = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<SignInViewModel>(
      model: SignInViewModel(context: context),
      builder: (model) {
        return Scaffold(
          backgroundColor: Theme.of(context).accentColor,
          key: _scaffoldKey,
          body: Loader(
            inAsyncCall: model.isBusy,
            child: Form(
              key: _formKey,
              autovalidate: _formAutoValidOn,
              onChanged: () {
                setState(() {
                  _formAutoValidOn = true;
                });
              },
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
                            onFacebookClicked: () async {
                              var status = await model.signInWithFacebook();
                              if (!status) {
                                model.loading = false;
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content:
                                      Text('Sing in failed, please try again'),
                                ));
                              }
                            },
                            onGoogleClicked: () async {
                              var status = await model.signInWithGoogle();
                              if (!status) {
                                model.loading = false;
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content:
                                      Text('Sing in failed, please try again'),
                                ));
                              }
                            },
                            onLoginClicked: () async {
                              _formKey.currentState.reset();
                              if (_formKey.currentState.validate()) {
                                var status =
                                    await model.signInWithEmailAndPassword(
                                        _email.text, _password.text);
                                if (!status) {
                                  model.loading = false;
                                  _scaffoldKey.currentState
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                        'Sing in failed, please try again'),
                                  ));
                                }
                              }
                            },
                            onResetClicked: () => Navigator.pushNamed(
                                context, ResetPasswordScreen.routeName),
                          ),
                        ),
                      ],
                    ),
                    buildPrimaryButton(
                        context,
                        'Don\'t have an account ?',
                        ' Sign Up',
                        () => Navigator.pushReplacementNamed(
                            context, SignUpScreen.routeName)),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildFormFields(
      {BuildContext context,
      Function onResetClicked,
      Function onLoginClicked,
      Function onFacebookClicked,
      Function onGoogleClicked}) {
    return Column(
      children: <Widget>[
        SizedBox(height: 25),
        Text('Sign In', style: Theme.of(context).textTheme.headline2),
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
        SizedBox(height: 20),
        FormInputFieldWithIcon(
          style: TextStyle(color: Theme.of(context).accentColor),
          decoration: InputDecoration(
            hintText: 'Password',
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
              FontAwesomeIcons.lock,
              color: Theme.of(context).accentColor,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _showPassword = !_showPassword;
                });
              },
              color: Theme.of(context).accentColor.withOpacity(0.4),
              icon:
                  Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
            ),
          ),
          controller: _password,
          validator: Validator().password,
          obscureText: !_showPassword,
          maxLines: 1,
          onChanged: (value) => null,
          onSaved: (value) => _password.text = value,
        ),
        SizedBox(height: 20),
        FlatButton(
          onPressed: onResetClicked,
          child: Text(
            'Forgot your password ?',
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
        SizedBox(height: 30),
        FlatButton(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 70),
          onPressed: onLoginClicked,
          child: Text(
            'Login',
            style: Theme.of(context).textTheme.headline6.merge(
                  TextStyle(color: Theme.of(context).primaryColor),
                ),
          ),
          color: Theme.of(context).accentColor,
          shape: StadiumBorder(),
        ),
        SizedBox(height: 50),
        Text(
          'Or using social media',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        SizedBox(height: 20),
        SocialMediaWidget(
            signInWithFacebook: onFacebookClicked,
            signInWithGoogle: onGoogleClicked)
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

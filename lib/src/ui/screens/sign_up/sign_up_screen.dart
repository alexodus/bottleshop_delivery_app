import 'package:bottleshopdeliveryapp/src/core/utils/validator.dart';
import 'package:bottleshopdeliveryapp/src/core/viewmodels/screens/sign_up_view_model.dart';
import 'package:bottleshopdeliveryapp/src/ui/screens/sign_in/sign_in_screen.dart';
import 'package:bottleshopdeliveryapp/src/ui/screens/tabs/tabs_screen.dart';
import 'package:bottleshopdeliveryapp/src/ui/shared/form_input_field_with_icon.dart';
import 'package:bottleshopdeliveryapp/src/ui/shared/loader_widget.dart';
import 'package:bottleshopdeliveryapp/src/ui/shared/social_media.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/signUp';
  SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _showPassword = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordRepeat = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _formAutoValidOn = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _passwordRepeat.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignUpViewModel>(
      create: (_) => SignUpViewModel(context.read),
      builder: (context, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).accentColor,
          key: _scaffoldKey,
          body: Loader(
            inAsyncCall: context.watch<SignUpViewModel>().isLoading,
            child: Form(
              key: _formKey,
              autovalidate: _formAutoValidOn,
              onChanged: () {
                print('form changed');
                setState(() {
                  _formAutoValidOn = true;
                });
              },
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                          margin: EdgeInsets.symmetric(vertical: 65, horizontal: 50),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Theme.of(context).primaryColor.withOpacity(0.6),
                          ),
                        ),
                        Container(
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
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 25),
                              Text('Sign Up', style: Theme.of(context).textTheme.headline2),
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
                                        borderSide: BorderSide(color: Theme.of(context).accentColor.withOpacity(0.2))),
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
                                      borderSide: BorderSide(color: Theme.of(context).accentColor.withOpacity(0.2))),
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
                                    icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
                                  ),
                                ),
                                controller: _password,
                                validator: (val) {
                                  var pwdVal = Validator().password(val);
                                  if (pwdVal == null) {
                                    if (val == _passwordRepeat.text) {
                                      return null;
                                    }
                                    return "Passwords don't match";
                                  }
                                  return pwdVal;
                                },
                                obscureText: !_showPassword,
                                maxLines: 1,
                                onChanged: (value) => null,
                                onSaved: (value) => _password.text = value,
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
                                      borderSide: BorderSide(color: Theme.of(context).accentColor.withOpacity(0.2))),
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
                                    icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
                                  ),
                                ),
                                controller: _passwordRepeat,
                                validator: (val) {
                                  var pwdVal = Validator().password(val);
                                  if (pwdVal == null) {
                                    if (val == _password.text) {
                                      return null;
                                    }
                                    return "Passwords don't match";
                                  }
                                  return pwdVal;
                                },
                                obscureText: !_showPassword,
                                maxLines: 1,
                                onChanged: (value) => null,
                                onSaved: (value) => _password.text = value,
                              ),
                              SizedBox(height: 40),
                              FlatButton(
                                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 70),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    await context
                                        .read<SignUpViewModel>()
                                        .signUpWithEmailAndPassword(_email.text, _password.text);
                                    Navigator.pushReplacementNamed(context, TabsScreen.routeName);
                                  }
                                },
                                child: Text(
                                  'Sign Up',
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
                                signInWithGoogle: () async {
                                  await context.read<SignUpViewModel>().signUpWithGoogle();
                                  Navigator.pushReplacementNamed(context, TabsScreen.routeName);
                                },
                                signInWithFacebook: () async {
                                  await context.read<SignUpViewModel>().signUpWithFacebook();
                                  Navigator.pushReplacementNamed(context, TabsScreen.routeName);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, SignInScreen.routeName);
                      },
                      child: RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.headline6.merge(
                                TextStyle(color: Theme.of(context).primaryColor),
                              ),
                          children: [
                            TextSpan(text: 'Already have an account ?'),
                            TextSpan(text: ' Sign In', style: TextStyle(fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
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
}

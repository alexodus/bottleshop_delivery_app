import 'package:bottleshopdeliveryapp/src/ui/tabs/tabs_view.dart';
import 'package:bottleshopdeliveryapp/src/ui/views/sign_in_view.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/form_input_field_with_icon.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/loader_widget.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/social_media.dart';
import 'package:bottleshopdeliveryapp/src/utils/validator.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/sign_up_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final formKeyProvider = Provider((_) => GlobalKey<FormState>());

class SignUpView extends HookWidget {
  static const String routeName = '/signUp';
  const SignUpView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signUpProvider = useProvider(signUpViewModelProvider);
    final formKey = useProvider(formKeyProvider);
    final formAutoValidOn = useState(false);
    final showPassword = useState(false);
    final email = useTextEditingController();
    final password = useTextEditingController();
    final passwordRepeat = useTextEditingController();
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Loader(
        inAsyncCall: signUpProvider.isLoading,
        child: Form(
          key: formKey,
          autovalidate: formAutoValidOn.value,
          onChanged: () => formAutoValidOn.value = true,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                      margin:
                          EdgeInsets.symmetric(vertical: 65, horizontal: 50),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).primaryColor.withOpacity(0.6),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                      margin:
                          EdgeInsets.symmetric(vertical: 85, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).primaryColor,
                        boxShadow: [
                          BoxShadow(
                              color:
                                  Theme.of(context).hintColor.withOpacity(0.2),
                              offset: Offset(0, 10),
                              blurRadius: 20)
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 25),
                          Text('Sign Up',
                              style: Theme.of(context).textTheme.headline2),
                          SizedBox(height: 20),
                          FormInputFieldWithIcon(
                            style:
                                TextStyle(color: Theme.of(context).accentColor),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                hintText: 'Email Address',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .merge(
                                      TextStyle(
                                          color: Theme.of(context).accentColor),
                                    ),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .accentColor
                                            .withOpacity(0.2))),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).accentColor),
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
                          SizedBox(height: 20),
                          FormInputFieldWithIcon(
                            style:
                                TextStyle(color: Theme.of(context).accentColor),
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .merge(
                                    TextStyle(
                                        color: Theme.of(context).accentColor),
                                  ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .accentColor
                                          .withOpacity(0.2))),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor),
                              ),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Theme.of(context).accentColor,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () =>
                                    showPassword.value = !showPassword.value,
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.4),
                                icon: Icon(showPassword.value
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                            ),
                            controller: password,
                            validator: (val) {
                              var pwdVal = Validator().password(val);
                              if (pwdVal == null) {
                                if (val == passwordRepeat.text) {
                                  return null;
                                }
                                return "Passwords don't match";
                              }
                              return pwdVal;
                            },
                            obscureText: !showPassword.value,
                            maxLines: 1,
                            onChanged: (value) => null,
                            onSaved: (value) => password.text = value,
                          ),
                          SizedBox(height: 20),
                          FormInputFieldWithIcon(
                            style:
                                TextStyle(color: Theme.of(context).accentColor),
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .merge(
                                    TextStyle(
                                        color: Theme.of(context).accentColor),
                                  ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .accentColor
                                          .withOpacity(0.2))),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor),
                              ),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Theme.of(context).accentColor,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () =>
                                    showPassword.value = !showPassword.value,
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.4),
                                icon: Icon(showPassword.value
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                            ),
                            controller: passwordRepeat,
                            validator: (val) {
                              var pwdVal = Validator().password(val);
                              if (pwdVal == null) {
                                if (val == password.text) {
                                  return null;
                                }
                                return "Passwords don't match";
                              }
                              return pwdVal;
                            },
                            obscureText: !showPassword.value,
                            maxLines: 1,
                            onChanged: (value) => null,
                            onSaved: (value) => password.text = value,
                          ),
                          SizedBox(height: 40),
                          FlatButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 70),
                            onPressed: () async {
                              if (formKey.currentState.validate()) {
                                await signUpProvider.signUpWithEmailAndPassword(
                                    email.text, password.text);
                                return Navigator.pushReplacementNamed(
                                    context, TabsView.routeName);
                              }
                            },
                            child: Text(
                              'Sign Up',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .merge(
                                    TextStyle(
                                        color: Theme.of(context).primaryColor),
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
                              try {
                                await signUpProvider.signUpWithGoogle();
                                return Navigator.pushReplacementNamed(
                                    context, TabsView.routeName);
                              } catch (e) {
                                signUpProvider.isLoading = false;
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Sing in failed, please try again',
                                    ),
                                  ),
                                );
                              }
                            },
                            signInWithFacebook: () async {
                              try {
                                await signUpProvider.signUpWithFacebook();
                                return Navigator.pushReplacementNamed(
                                    context, TabsView.routeName);
                              } catch (e) {
                                signUpProvider.isLoading = false;
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Sing in failed,'
                                      'please try again',
                                    ),
                                  ),
                                );
                              }
                            },
                            signInAnonymously: () async {
                              await signUpProvider.signUpAnonymously();
                              return Navigator.pushReplacementNamed(
                                  context, TabsView.routeName);
                            },
                            signInWithApple: () async {
                              await signUpProvider.signUpWithApple();
                              return Navigator.pushReplacementNamed(
                                  context, TabsView.routeName);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, SignInView.routeName);
                  },
                  child: RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.headline6.merge(
                            TextStyle(color: Theme.of(context).primaryColor),
                          ),
                      children: [
                        TextSpan(text: 'Already have an account ?'),
                        TextSpan(
                          text: ' Sign In',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
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
  }
}

import 'package:bottleshopdeliveryapp/src/core/presentation/res/validator.dart';
import 'package:bottleshopdeliveryapp/src/core/presentation/widgets/form_input_field_with_icon.dart';
import 'package:bottleshopdeliveryapp/src/core/presentation/widgets/loader_widget.dart';
import 'package:bottleshopdeliveryapp/src/features/auth/presentation/providers/auth_providers.dart';
import 'package:bottleshopdeliveryapp/src/features/auth/presentation/widgets/social_media.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignUpPage extends HookWidget {
  static const String routeName = '/signUp';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  SignUpPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final showPassword = useState<bool>(false);
    final email = useTextEditingController();
    final password = useTextEditingController();
    final passwordRepeat = useTextEditingController();
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).accentColor,
      body: Loader(
        inAsyncCall: useProvider(
            userRepositoryProvider.select((value) => value.isLoading)),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                              if (_formKey.currentState.validate()) {
                                if (!await context
                                    .read(userRepositoryProvider)
                                    .signUpWithEmailAndPassword(
                                        email.text, password.text)) {
                                  _scaffoldKey.currentState.showSnackBar(
                                    SnackBar(
                                      content: Text('Sign up failed'),
                                    ),
                                  );
                                }
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
                          useProvider(appleSignInAvailableProvider).when(
                            data: (isAppleSupported) => SocialMediaWidget(
                                isAppleSupported: isAppleSupported),
                            loading: () => Container(
                              height: 45,
                              width: double.infinity,
                              child: CircularProgressIndicator(),
                            ),
                            error: (_, __) => SocialMediaWidget(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
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

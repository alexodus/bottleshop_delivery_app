import 'package:bottleshopdeliveryapp/src/core/presentation/res/validator.dart';
import 'package:bottleshopdeliveryapp/src/core/presentation/widgets/form_input_field_with_icon.dart';
import 'package:bottleshopdeliveryapp/src/core/presentation/widgets/loader_widget.dart';
import 'package:bottleshopdeliveryapp/src/features/auth/presentation/pages/reset_password_page.dart';
import 'package:bottleshopdeliveryapp/src/features/auth/presentation/pages/sign_up_page.dart';
import 'package:bottleshopdeliveryapp/src/features/auth/presentation/providers/auth_providers.dart';
import 'package:bottleshopdeliveryapp/src/features/auth/presentation/widgets/social_media.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

class SignInPage extends HookWidget {
  static const String routeName = '/signIn';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  SignInPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final showPassword = useState<bool>(false);
    final email = useTextEditingController();
    final password = useTextEditingController();
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
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    buildFormContainerTop(context: context),
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
                          Text('Sign In',
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
                                    showPassword.value = showPassword.value,
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.4),
                                icon: Icon(showPassword.value
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                            ),
                            controller: password,
                            validator: Validator().password,
                            obscureText: !showPassword.value,
                            maxLines: 1,
                            onChanged: (value) => null,
                            onSaved: (value) => password.text = value,
                          ),
                          SizedBox(height: 20),
                          FlatButton(
                            onPressed: () => Navigator.pushNamed(
                                context, ResetPasswordPage.routeName),
                            child: Text(
                              'Forgot your password ?',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                          SizedBox(height: 30),
                          FlatButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 70),
                            onPressed: () async {
                              FormState form = _formKey.currentState;
                              if (form.validate()) {
                                await context
                                    .read(userRepositoryProvider)
                                    .signInWithEmailAndPassword(
                                        email.text, password.text);
                              }
                            },
                            child: Text(
                              'Login',
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
                buildPrimaryButton(
                    context,
                    'Don\'t have an account ?',
                    ' Sign Up',
                    () => Navigator.pushNamed(context, SignUpPage.routeName)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildPrimaryButton(
    BuildContext context, String label, String title, VoidCallback onPress) {
  return FlatButton(
    onPressed: onPress,
    child: RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.headline6.merge(
              TextStyle(color: Theme.of(context).primaryColor),
            ),
        children: [
          TextSpan(text: label),
          TextSpan(text: title, style: TextStyle(fontWeight: FontWeight.w700)),
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

import 'package:bottleshopdeliveryapp/generated/l10n.dart';
import 'package:bottleshopdeliveryapp/src/core/data/services/logger.dart';
import 'package:bottleshopdeliveryapp/src/core/presentation/res/validator.dart';
import 'package:bottleshopdeliveryapp/src/core/presentation/widgets/form_input_field_with_icon.dart';
import 'package:bottleshopdeliveryapp/src/core/presentation/widgets/loader_widget.dart';
import 'package:bottleshopdeliveryapp/src/features/auth/presentation/pages/reset_password_page.dart';
import 'package:bottleshopdeliveryapp/src/features/auth/presentation/providers/auth_providers.dart';
import 'package:bottleshopdeliveryapp/src/features/auth/presentation/widgets/social_media.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

class SignInPage extends HookWidget {
  static const String routeName = '/sign-in';
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final logger = createLogger('SignInPage');
  SignInPage({Key key}) : super(key: key);

  void authCallback(bool result) {
    logger.v('auth result: $result');
  }

  @override
  Widget build(BuildContext context) {
    final signIn = useState<bool>(true);
    final showPassword = useState<bool>(false);
    final email = useTextEditingController();
    final password = useTextEditingController();
    final passwordRepeat = useTextEditingController();
    final loading =
        useProvider(userRepositoryProvider.select((value) => value.isLoading));
    final isAppleAvailable = useProvider(appleSignInAvailableProvider);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).accentColor,
      body: Loader(
        inAsyncCall: loading,
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  child: signIn.value
                      ? Stack(
                          key: UniqueKey(),
                          children: <Widget>[
                            buildFormContainerTop(context: context),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  vertical: 30, horizontal: 30),
                              margin: EdgeInsets.symmetric(
                                  vertical: 85, horizontal: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Theme.of(context).primaryColor,
                                boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context)
                                          .hintColor
                                          .withOpacity(0.2),
                                      offset: Offset(0, 10),
                                      blurRadius: 20)
                                ],
                              ),
                              child: SignInWidget(
                                email: email,
                                showPassword: showPassword,
                                password: password,
                                formKey: _formKey,
                                isAppleAvailable: isAppleAvailable,
                                authCallback: authCallback,
                              ),
                            ),
                          ],
                        )
                      : Stack(
                          key: UniqueKey(),
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  vertical: 30, horizontal: 20),
                              margin: EdgeInsets.symmetric(
                                  vertical: 65, horizontal: 50),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.6),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  vertical: 30, horizontal: 30),
                              margin: EdgeInsets.symmetric(
                                  vertical: 85, horizontal: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Theme.of(context).primaryColor,
                                boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context)
                                          .hintColor
                                          .withOpacity(0.2),
                                      offset: Offset(0, 10),
                                      blurRadius: 20)
                                ],
                              ),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 25),
                                  Text(S.of(context).sign_up,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2),
                                  SizedBox(height: 20),
                                  FormInputFieldWithIcon(
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor),
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                        hintText: 'Email Address',
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .merge(
                                              TextStyle(
                                                  color: Theme.of(context)
                                                      .accentColor),
                                            ),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .accentColor
                                                    .withOpacity(0.2))),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .accentColor),
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
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor),
                                    decoration: InputDecoration(
                                      hintText: 'Password',
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .merge(
                                            TextStyle(
                                                color: Theme.of(context)
                                                    .accentColor),
                                          ),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .accentColor
                                                  .withOpacity(0.2))),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                Theme.of(context).accentColor),
                                      ),
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Theme.of(context).accentColor,
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: () => showPassword.value =
                                            !showPassword.value,
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
                                  FormInputFieldWithIcon(
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor),
                                    decoration: InputDecoration(
                                      hintText: 'Password',
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .merge(
                                            TextStyle(
                                                color: Theme.of(context)
                                                    .accentColor),
                                          ),
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .accentColor
                                                  .withOpacity(0.2))),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                Theme.of(context).accentColor),
                                      ),
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Theme.of(context).accentColor,
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: () => showPassword.value =
                                            !showPassword.value,
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
                                        final authResult = await context
                                            .read(userRepositoryProvider)
                                            .signUpWithEmailAndPassword(
                                                email.text, password.text);
                                        logger.v('signUp result: $authResult');
                                      }
                                    },
                                    child: Text(
                                      S.of(context).sign_up,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .merge(
                                            TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                    ),
                                    color: Theme.of(context).accentColor,
                                    shape: StadiumBorder(),
                                  ),
                                  SizedBox(height: 50),
                                  Text(
                                    S.of(context).or_social_media,
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  SizedBox(height: 20),
                                  isAppleAvailable.when(
                                    data: (isAppleSupported) =>
                                        SocialMediaWidget(
                                            isAppleSupported: isAppleSupported,
                                            authResultCallback: (res) =>
                                                logger.v('result: $res')),
                                    loading: () => Container(
                                      height: 45,
                                      width: double.infinity,
                                      child: CircularProgressIndicator(),
                                    ),
                                    error: (_, __) => SocialMediaWidget(
                                        authResultCallback: (res) =>
                                            logger.v('result: $res')),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                  transitionBuilder: (widget, animation) => ScaleTransition(
                    scale: animation,
                    child: widget,
                  ),
                ),
                buildPrimaryButton(
                  context,
                  S.of(context).dontHaveAnAccount,
                  S.of(context).sign_up,
                  () => signIn.value = !signIn.value,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignInWidget extends StatelessWidget {
  final TextEditingController email;
  final ValueNotifier<bool> showPassword;
  final TextEditingController password;
  final GlobalKey<FormState> formKey;
  final AsyncValue<bool> isAppleAvailable;
  final ValueChanged<bool> authCallback;
  const SignInWidget({
    Key key,
    @required this.email,
    @required this.showPassword,
    @required this.password,
    @required this.formKey,
    @required this.isAppleAvailable,
    @required this.authCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 25),
        Text(S.of(context).sign_in,
            style: Theme.of(context).textTheme.headline2),
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
            prefixIcon: Icon(
              Icons.lock,
              color: Theme.of(context).accentColor,
            ),
            suffixIcon: IconButton(
              onPressed: () => showPassword.value = !showPassword.value,
              color: Theme.of(context).accentColor.withOpacity(0.4),
              icon: Icon(
                  showPassword.value ? Icons.visibility : Icons.visibility_off),
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
          onPressed: () =>
              Navigator.pushNamed(context, ResetPasswordPage.routeName),
          child: Text(
            S.of(context).password_forgotten,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
        SizedBox(height: 30),
        FlatButton(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 70),
          onPressed: () async {
            FormState form = formKey.currentState;
            if (form.validate()) {
              await context
                  .read(userRepositoryProvider)
                  .signInWithEmailAndPassword(email.text, password.text);
            }
          },
          child: Text(
            S.of(context).login,
            style: Theme.of(context).textTheme.headline6.merge(
                  TextStyle(color: Theme.of(context).primaryColor),
                ),
          ),
          color: Theme.of(context).accentColor,
          shape: StadiumBorder(),
        ),
        SizedBox(height: 50),
        Text(
          S.of(context).or_social_media,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        SizedBox(height: 20),
        isAppleAvailable.when(
          data: (data) {
            return SocialMediaWidget(
              isAppleSupported: data,
              authResultCallback: authCallback,
            );
          },
          loading: () => Row(
            children: [
              Center(
                child: CircularProgressIndicator(),
              ),
            ],
          ),
          error: (_, __) => SocialMediaWidget(authResultCallback: authCallback),
        ),
      ],
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

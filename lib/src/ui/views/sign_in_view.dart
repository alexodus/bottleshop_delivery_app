import 'package:bottleshopdeliveryapp/src/ui/tabs/tabs_view.dart';
import 'package:bottleshopdeliveryapp/src/ui/views/reset_password_view.dart';
import 'package:bottleshopdeliveryapp/src/ui/views/sign_up_view.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/form_input_field_with_icon.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/loader_widget.dart';
import 'package:bottleshopdeliveryapp/src/ui/widgets/social_media.dart';
import 'package:bottleshopdeliveryapp/src/utils/validator.dart';
import 'package:bottleshopdeliveryapp/src/viewmodels/sign_up_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

final formKeyProvider = Provider((_) => GlobalKey<FormState>());

class SignInView extends HookWidget {
  static const String routeName = '/signIn';

  const SignInView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signUpViewModel = useProvider(signUpViewModelProvider);
    final formKey = useProvider(formKeyProvider);
    final formAutoValidOn = useState(false);
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Loader(
        inAsyncCall: signUpViewModel.isLoading,
        child: Form(
          key: formKey,
          autovalidate: formAutoValidOn.value,
          onChanged: () => formAutoValidOn.value = true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    buildFormContainerTop(context: context),
                    buildFormContainer(
                      context: context,
                      child: FormFields(),
                    ),
                  ],
                ),
                buildPrimaryButton(
                    context,
                    'Don\'t have an account ?',
                    ' Sign Up',
                    () => Navigator.pushReplacementNamed(
                        context, SignUpView.routeName)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FormFields extends HookWidget {
  const FormFields({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signInViewModel = useProvider(signUpViewModelProvider);
    final formKey = useProvider(formKeyProvider);
    final showPassword = useState(false);
    final email = useTextEditingController();
    final password = useTextEditingController();
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
              () => Navigator.pushNamed(context, ResetPasswordView.routeName),
          child: Text(
            'Forgot your password ?',
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
        SizedBox(height: 30),
        FlatButton(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 70),
          onPressed: () async {
            formKey.currentState.reset();
            if (formKey.currentState.validate()) {
              await signInViewModel.signInWithEmailAndPassword(
                  email.text, password.text);
              return Navigator.pushReplacementNamed(
                  context, TabsView.routeName);
            }
          },
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
          signInWithFacebook: signInViewModel.signUpWithFacebook,
          signInWithGoogle: signInViewModel.signUpWithGoogle,
          signInWithApple: signInViewModel.signUpWithApple,
          signInAnonymously: signInViewModel.signUpAnonymously,
        )
      ],
    );
  }
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

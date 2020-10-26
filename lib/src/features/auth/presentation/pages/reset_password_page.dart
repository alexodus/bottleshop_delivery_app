import 'package:bottleshopdeliveryapp/generated/l10n.dart';
import 'package:bottleshopdeliveryapp/src/core/presentation/res/validator.dart';
import 'package:bottleshopdeliveryapp/src/core/presentation/widgets/form_input_field_with_icon.dart';
import 'package:bottleshopdeliveryapp/src/core/presentation/widgets/loader_widget.dart';
import 'package:bottleshopdeliveryapp/src/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

class ResetPasswordPage extends HookWidget {
  static const routeName = '/reset-password';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context).settings.arguments ?? '';
    final emailController = useTextEditingController(text: email);
    final userRepoState = useProvider(userRepositoryProvider);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).accentColor,
      body: Loader(
        inAsyncCall: userRepoState.isLoading,
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    _buildFormContainerTop(context: context),
                    _buildFormContainer(
                      context: context,
                      child: _buildFormFields(
                        context: context,
                        onResetClicked: () async {
                          if (_formKey.currentState.validate()) {
                            await userRepoState
                                .sendResetPasswordEmail(emailController.text);
                            emailController.clear();
                            _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text(S
                                    .of(context)
                                    .checkYourEmailAndFollowTheInstructionsToResetYour),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
                _buildPrimaryButton(
                  context,
                  S.of(context).gotNewPassword,
                  S.of(context).sign_in,
                  () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormFields(
      {BuildContext context,
      VoidCallback onResetClicked,
      TextEditingController email}) {
    return Column(
      children: <Widget>[
        SizedBox(height: 25),
        Text(S.of(context).resetPassword,
            style: Theme.of(context).textTheme.headline2),
        SizedBox(height: 20),
        FormInputFieldWithIcon(
          style: TextStyle(color: Theme.of(context).accentColor),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              hintText: S.of(context).email,
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
            S.of(context).reset,
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

  Widget _buildPrimaryButton(
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

  Widget _buildFormContainerTop({BuildContext context}) {
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

  Widget _buildFormContainer({BuildContext context, Widget child}) {
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

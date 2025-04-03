import 'package:school_survey/utils/exports.dart';

class SignInView extends ConsumerWidget {
  SignInView({super.key});

  final GlobalKey<FormState> signInForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const ScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  context.keyBoardVisibility == false
                      ? EdgeInsets.symmetric(
                        horizontal: context.width * 0.05,
                        vertical: context.width * 0.1,
                      )
                      : EdgeInsets.symmetric(horizontal: context.width * 0.05),
              child: Form(
                key: signInForm,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: SizedBox(
                        height: context.height * 0.2,
                        child: Image.asset(
                          Assets.images.signinPNG,
                          width: context.width * 0.4,
                        ),
                      ),
                    ),
                    SizedBox(height: context.height * 0.01),
                    Text(
                      'Sign In',
                      style: context.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: context.width * 0.08,
                      ),
                    ),
                    SizedBox(height: context.height * 0.02),
                    LabeledTextField(
                      label: "Email",
                      isRequired: true,
                      textfield: CustomFormField(
                        keyboardType: TextInputType.emailAddress,
                        hintText: "qwerty@gmail.com",
                        onChanged: (p0) {
                          ref.watch(userProvider.notifier).state = UserModel(
                            email: p0,
                          );
                        },
                        validator: (value) {
                          if (value?.isEmpty == true) {
                            return "Email can't be empty";
                          } else if (value?.isValidEmail() == false) {
                            return "Enter Valid Email";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: context.height * 0.02),
                    LabeledTextField(
                      label: "Password",
                      isRequired: true,
                      textfield: CustomFormField(
                        keyboardType: TextInputType.visiblePassword,
                        hintText: "******a",
                        obscuringText: true,

                        validator: (value) {
                          if (value?.isEmpty == true) {
                            return "Password can't be empty";
                          } else if (value?.isValidPassword() == false) {
                            return validatePassword(value!);
                          }
                          return null;
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        style: ButtonStyle(
                          padding: WidgetStatePropertyAll(EdgeInsets.zero),
                          alignment: AlignmentDirectional.topEnd,
                          splashFactory: NoSplash.splashFactory,
                          overlayColor: WidgetStatePropertyAll(
                            Colors.transparent,
                          ),
                        ),

                        onPressed: () {},
                        child: Text("Forgot Password?"),
                      ),
                    ),
                    SizedBox(height: context.height * 0.03),
                    SubmitButton(
                      onPressed: () {
                        if (signInForm.currentState?.validate() == true) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRouter.HOME,
                            (route) => false,
                          );
                        }
                      },
                      text: 'Sign In',
                    ),
                    SizedBox(height: context.height * 0.03),
                    Row(
                      children: [
                        Spacer(),
                        Text(
                          "OR",
                          style: context.bodySmall?.copyWith(
                            color: AppColors.kGrey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(height: context.height * 0.03),
                    Align(
                      child: RichText(
                        text: TextSpan(
                          text: "Didn't have an Account? ",
                          style: context.bodyMedium,
                          children: [
                            TextSpan(
                              text: "Sign Up",
                              style: context.bodyMedium?.copyWith(
                                color: AppColors.kGreen,
                              ),
                              recognizer:
                                  TapGestureRecognizer()
                                    ..onTap =
                                        () => Navigator.of(
                                          context,
                                        ).pushNamed(AppRouter.SIGNUP),
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
        ],
      ),
    );
  }
}

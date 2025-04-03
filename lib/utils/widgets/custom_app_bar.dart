import 'package:school_survey/utils/exports.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.bottom,
    required this.title,
    this.automaticallyImplyLeading = false,
    this.height,
  });

  final PreferredSizeWidget? bottom;
  final String title;
  final bool? automaticallyImplyLeading;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: automaticallyImplyLeading ?? false,
      leading:
          automaticallyImplyLeading == false
              ? Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: CircleAvatar(
                  radius: 16,
                  backgroundImage: AssetImage(Assets.images.profilePNG),
                ),
              )
              : null,
      title: Text(title),
      titleSpacing: context.width * 0.04,
      bottom: bottom,
      actions: [
        PopupMenuButton(
          position: PopupMenuPosition.under,
          itemBuilder: (context) {
            return <PopupMenuItem>[
              if (context.currentRoute != AppRouter.HOME)
                PopupMenuItem(
                  child: Text("Home"),
                  onTap: () => Navigator.pushNamed(context, AppRouter.HOME),
                ),
              PopupMenuItem(child: Text("Settings")),
              PopupMenuItem(
                child: Text("Sign Out"),
                onTap: () async {
                  SharedPrefs.instance.remove("surveys");
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRouter.SIGNIN,
                    (r) => false,
                  );
                },
              ),
            ];
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? 120);
}

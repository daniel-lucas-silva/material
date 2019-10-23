import '../material.dart';
import 'button.dart';

class OutlineButton extends RawButton {
  OutlineButton({
    Widget leading,
    Widget trailing,
    Widget child,
    bool loading,
    @required VoidCallback onPressed,
    EdgeInsets padding,
    Color color,
    Color textColor,
    Color iconColor,
    double iconSize,
    ShapeBorder shape,
    Clip clipBehavior,
  }) : super(
          leading: leading,
          trailing: trailing,
          child: child,
          loading: loading ?? false,
          onPressed: onPressed,
          padding: padding ??
              const EdgeInsets.symmetric(vertical: 17, horizontal: 13),
          color: color,
          textColor: textColor,
          iconColor: iconColor,
          iconSize: iconSize ?? 20,
          shape: shape,
          clipBehavior: clipBehavior ?? Clip.antiAlias,
        );

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return RawButton(
      leading: leading,
      trailing: trailing,
      child: child,
      loading: loading,
      onPressed: onPressed,
      padding: padding,
      color: const Color(0x00000000),
      textColor: textColor,
      iconColor: iconColor,
      iconSize: iconSize,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: BorderSide(
          color: color ?? theme.buttonOutlineColor,
        ),
      ),
      clipBehavior: clipBehavior,
    );
  }
}
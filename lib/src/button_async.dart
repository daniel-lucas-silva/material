import '../material.dart';

enum AsyncButtonType {
  filled,
  outline,
}

class AsyncButton<T> extends StatefulWidget {
  final AsyncButtonType type;
  final Widget leading;
  final Widget trailing;
  final Widget child;
  final EdgeInsets padding;
  final Color color;
  final Color textColor;
  final Color iconColor;
  final double iconSize;
  final ShapeBorder shape;
  final Clip clipBehavior;
  final Future<T> Function(BuildContext context) builder;
  final void Function(T) onSuccess;
  final void Function(dynamic) onError;

  const AsyncButton({
    Key key,
    this.type = AsyncButtonType.filled,
    this.leading,
    this.trailing,
    this.padding = const EdgeInsets.symmetric(vertical: 14, horizontal: 13),
    this.color,
    this.textColor,
    this.iconColor,
    this.iconSize = 20,
    this.shape,
    this.clipBehavior = Clip.antiAlias,
    this.child,
    @required this.builder,
    @required this.onSuccess,
    @required this.onError,
  }) : super(key: key);

  @override
  _AsyncButtonState createState() => _AsyncButtonState();
}

class _AsyncButtonState extends State<AsyncButton> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    if (widget.type == AsyncButtonType.outline)
      return OutlineButton(
        leading: widget.leading,
        trailing: widget.trailing,
        child: widget.child,
        loading: _loading,
        onPressed: () async {
          setState(() {
            _loading = true;
          });
          try {
            await widget.builder(context).then(widget.onSuccess);
          } catch (e) {
            widget.onError(e);
          } finally {
            setState(() {
              _loading = false;
            });
          }
        },
        padding: widget.padding,
        color: widget.color ?? theme.buttonColor,
        textColor: widget.textColor,
        iconColor: widget.iconColor,
        iconSize: widget.iconSize,
        shape: widget.shape,
        clipBehavior: widget.clipBehavior,
      );

    return Button(
      leading: widget.leading,
      trailing: widget.trailing,
      child: widget.child,
      loading: _loading,
      onPressed: () async {
        setState(() {
          _loading = true;
        });
        try {
          await widget.builder(context).then(widget.onSuccess);
        } catch (e) {
          widget.onError(e);
        } finally {
          setState(() {
            _loading = false;
          });
        }
      },
      padding: widget.padding,
      color: widget.color ?? theme.buttonColor,
      textColor: widget.textColor,
      iconColor: widget.iconColor,
      iconSize: widget.iconSize,
      shape: widget.shape,
      clipBehavior: widget.clipBehavior,
    );
  }
}

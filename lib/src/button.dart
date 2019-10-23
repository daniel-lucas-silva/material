import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:material/src/ink_decoration.dart';

import 'constants.dart';
import 'ink_well.dart';
import 'material.dart';
import 'material_state.dart';
import 'progress_indicator.dart';
import 'theme.dart';
import 'theme_data.dart';

class Button extends RawButton {
  Button({
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
          padding:
              padding ?? EdgeInsets.symmetric(vertical: 17, horizontal: 13),
          color: color,
          textColor: textColor,
          iconColor: iconColor,
          iconSize: iconSize ?? 20,
          shape: shape ??
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
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
      color: color ?? theme.buttonColor,
      textColor: textColor,
      iconColor: iconColor,
      iconSize: iconSize,
      shape: shape,
      clipBehavior: clipBehavior,
    );
  }
}

class RawButton extends StatelessWidget {
  RawButton({
    this.loading = false,
    this.decoration = const BoxDecoration(),
    this.leading,
    this.child,
    this.trailing,
    @required this.onPressed,
    this.margin = const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
    this.padding = const EdgeInsets.symmetric(vertical: 17, horizontal: 13),
    this.color = const Color(0x00000000),
    this.splashColor,
    this.textColor,
    this.iconColor,
    this.iconSize = 20.0,
    this.shape = const RoundedRectangleBorder(),
    this.clipBehavior = Clip.none,
  });

  final BoxDecoration decoration;
  final bool loading;
  final Widget leading;
  final Widget child;
  final Widget trailing;
  final VoidCallback onPressed;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Color color;
  final Color splashColor;
  final Color textColor;
  final Color iconColor;
  final double iconSize;
  final ShapeBorder shape;
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;

    return Container(
      margin: margin,
      child: Material(
        color: color,
        shape: shape,
        type: MaterialType.button,
        clipBehavior: clipBehavior,
        borderOnForeground: false,
        child: Ink(
          decoration: decoration,
          child: InkWell(
            customBorder: shape,
            onTap: onPressed,
            splashColor: splashColor,
            child: Padding(
              padding: padding,
              child: IconTheme(
                data: IconTheme.of(context).copyWith(
                  size: iconSize,
                  color: iconColor ?? getContrastColor(color, brightness),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    getLeading(),
                    DefaultTextStyle(
                      style: TextStyle(
                        color: textColor ?? getContrastColor(color, brightness),
                        fontSize: 13,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: child,
                      ),
                    ),
                    getTrailing(brightness),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color getContrastColor(Color color, Brightness brightness) {
    double luminance =
        (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;

    if (brightness != Brightness.light && color.opacity < 0.5)
      return Color.fromRGBO(255, 255, 255, 1);
    else if (color.opacity < 0.5 || luminance > 0.5)
      return Color.fromRGBO(10, 10, 10, 1);
    else
      return Color.fromRGBO(255, 255, 255, 1);
  }

  getLeading() {
    if (leading != null)
      return Align(
        alignment: Alignment.centerLeft,
        child: leading,
      );
    else
      return Offstage();
  }

  getTrailing(brightness) {
    if (loading)
      return Align(
        alignment: Alignment.centerRight,
        child: ButtonSpinner(
          color: iconColor ?? getContrastColor(color, brightness),
          size: iconSize,
        ),
      );
    else if (trailing != null)
      return Align(
        alignment: Alignment.centerRight,
        child: trailing,
      );
    else
      return Offstage();
  }
}

class ButtonSpinner extends StatelessWidget {
  final Color color;
  final double size;

  ButtonSpinner({
    this.size = 24.0,
    @required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: Stack(
        children: <Widget>[
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(color),
            strokeWidth: 2.1,
          )
        ],
      ),
    );
  }
}

class RawMaterialButton extends StatefulWidget {
  const RawMaterialButton({
    Key key,
    @required this.onPressed,
    this.onHighlightChanged,
    this.textStyle,
    this.fillColor,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.elevation = 2.0,
    this.focusElevation = 4.0,
    this.hoverElevation = 4.0,
    this.highlightElevation = 8.0,
    this.disabledElevation = 0.0,
    this.padding = EdgeInsets.zero,
    this.constraints = const BoxConstraints(minWidth: 88.0, minHeight: 36.0),
    this.shape = const RoundedRectangleBorder(),
    this.clipBehavior = Clip.none,
    this.animationDuration = kThemeChangeDuration,
    this.focusNode,
    this.autofocus = false,
    MaterialTapTargetSize materialTapTargetSize,
    this.child,
  })  : materialTapTargetSize =
            materialTapTargetSize ?? MaterialTapTargetSize.padded,
        assert(shape != null),
        assert(elevation != null && elevation >= 0.0),
        assert(focusElevation != null && focusElevation >= 0.0),
        assert(hoverElevation != null && hoverElevation >= 0.0),
        assert(highlightElevation != null && highlightElevation >= 0.0),
        assert(disabledElevation != null && disabledElevation >= 0.0),
        assert(padding != null),
        assert(constraints != null),
        assert(animationDuration != null),
        assert(clipBehavior != null),
        assert(autofocus != null),
        super(key: key);

  final VoidCallback onPressed;

  final ValueChanged<bool> onHighlightChanged;

  final TextStyle textStyle;

  final Color fillColor;

  final Color focusColor;

  final Color hoverColor;

  final Color highlightColor;

  final Color splashColor;

  final double elevation;

  final double hoverElevation;

  final double focusElevation;

  final double highlightElevation;

  final double disabledElevation;

  final EdgeInsetsGeometry padding;

  final BoxConstraints constraints;

  final ShapeBorder shape;

  final Duration animationDuration;

  final Widget child;

  bool get enabled => onPressed != null;

  final MaterialTapTargetSize materialTapTargetSize;

  final FocusNode focusNode;

  final bool autofocus;

  final Clip clipBehavior;

  @override
  _RawMaterialButtonState createState() => _RawMaterialButtonState();
}

class _RawMaterialButtonState extends State<RawMaterialButton> {
  final Set<MaterialState> _states = <MaterialState>{};

  bool get _hovered => _states.contains(MaterialState.hovered);
  bool get _focused => _states.contains(MaterialState.focused);
  bool get _pressed => _states.contains(MaterialState.pressed);
  bool get _disabled => _states.contains(MaterialState.disabled);

  void _updateState(MaterialState state, bool value) {
    value ? _states.add(state) : _states.remove(state);
  }

  void _handleHighlightChanged(bool value) {
    if (_pressed != value) {
      setState(() {
        _updateState(MaterialState.pressed, value);
        if (widget.onHighlightChanged != null) {
          widget.onHighlightChanged(value);
        }
      });
    }
  }

  void _handleHoveredChanged(bool value) {
    if (_hovered != value) {
      setState(() {
        _updateState(MaterialState.hovered, value);
      });
    }
  }

  void _handleFocusedChanged(bool value) {
    if (_focused != value) {
      setState(() {
        _updateState(MaterialState.focused, value);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _updateState(MaterialState.disabled, !widget.enabled);
  }

  @override
  void didUpdateWidget(RawMaterialButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateState(MaterialState.disabled, !widget.enabled);
    if (_disabled && _pressed) {
      _handleHighlightChanged(false);
    }
  }

  double get _effectiveElevation {
    if (_disabled) {
      return widget.disabledElevation;
    }
    if (_pressed) {
      return widget.highlightElevation;
    }
    if (_hovered) {
      return widget.hoverElevation;
    }
    if (_focused) {
      return widget.focusElevation;
    }
    return widget.elevation;
  }

  @override
  Widget build(BuildContext context) {
    final Color effectiveTextColor = MaterialStateProperty.resolveAs<Color>(
        widget.textStyle?.color, _states);
    final ShapeBorder effectiveShape =
        MaterialStateProperty.resolveAs<ShapeBorder>(widget.shape, _states);

    final Widget result = ConstrainedBox(
      constraints: widget.constraints,
      child: Material(
        elevation: _effectiveElevation,
        textStyle: widget.textStyle?.copyWith(color: effectiveTextColor),
        shape: effectiveShape,
        color: widget.fillColor,
        type: widget.fillColor == null
            ? MaterialType.transparency
            : MaterialType.button,
        animationDuration: widget.animationDuration,
        clipBehavior: widget.clipBehavior,
        child: InkWell(
          focusNode: widget.focusNode,
          canRequestFocus: widget.enabled,
          onFocusChange: _handleFocusedChanged,
          autofocus: widget.autofocus,
          onHighlightChanged: _handleHighlightChanged,
          splashColor: widget.splashColor,
          highlightColor: widget.highlightColor,
          focusColor: widget.focusColor,
          hoverColor: widget.hoverColor,
          onHover: _handleHoveredChanged,
          onTap: widget.onPressed,
          customBorder: effectiveShape,
          child: IconTheme.merge(
            data: IconThemeData(color: effectiveTextColor),
            child: Container(
              padding: widget.padding,
              child: Center(
                widthFactor: 1.0,
                heightFactor: 1.0,
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
    Size minSize;
    switch (widget.materialTapTargetSize) {
      case MaterialTapTargetSize.padded:
        minSize = const Size(48.0, 48.0);
        break;
      case MaterialTapTargetSize.shrinkWrap:
        minSize = Size.zero;
        break;
    }

    return Semantics(
      container: true,
      button: true,
      enabled: widget.enabled,
      child: _InputPadding(
        minSize: minSize,
        child: result,
      ),
    );
  }
}

class _InputPadding extends SingleChildRenderObjectWidget {
  const _InputPadding({
    Key key,
    Widget child,
    this.minSize,
  }) : super(key: key, child: child);

  final Size minSize;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderInputPadding(minSize);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant _RenderInputPadding renderObject) {
    renderObject.minSize = minSize;
  }
}

class _RenderInputPadding extends RenderShiftedBox {
  _RenderInputPadding(this._minSize, [RenderBox child]) : super(child);

  Size get minSize => _minSize;
  Size _minSize;
  set minSize(Size value) {
    if (_minSize == value) return;
    _minSize = value;
    markNeedsLayout();
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    if (child != null)
      return math.max(child.getMinIntrinsicWidth(height), minSize.width);
    return 0.0;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    if (child != null)
      return math.max(child.getMinIntrinsicHeight(width), minSize.height);
    return 0.0;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    if (child != null)
      return math.max(child.getMaxIntrinsicWidth(height), minSize.width);
    return 0.0;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    if (child != null)
      return math.max(child.getMaxIntrinsicHeight(width), minSize.height);
    return 0.0;
  }

  @override
  void performLayout() {
    if (child != null) {
      child.layout(constraints, parentUsesSize: true);
      final double height = math.max(child.size.width, minSize.width);
      final double width = math.max(child.size.height, minSize.height);
      size = constraints.constrain(Size(height, width));
      final BoxParentData childParentData = child.parentData;
      childParentData.offset = Alignment.center.alongOffset(size - child.size);
    } else {
      size = Size.zero;
    }
  }

  @override
  bool hitTest(BoxHitTestResult result, {Offset position}) {
    if (super.hitTest(result, position: position)) {
      return true;
    }
    final Offset center = child.size.center(Offset.zero);
    return result.addWithRawTransform(
      transform: MatrixUtils.forceToPoint(center),
      position: center,
      hitTest: (BoxHitTestResult result, Offset position) {
        assert(position == center);
        return child.hitTest(result, position: center);
      },
    );
  }
}

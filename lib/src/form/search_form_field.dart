
import 'package:flutter/widgets.dart';

import '../colors.dart';
import '../icons.dart';
import '../ink_well.dart';
import '../input_decorator.dart';
import '../search.dart';
import '../theme.dart';

class SearchFormField<T> extends FormField<T> {
  SearchFormField({
    Key key,
    T value,
    SearchDelegate delegate,
    this.onChanged,
    InputDecoration decoration = const InputDecoration(),
    FormFieldSetter<T> onSaved,
    FormFieldValidator<T> validator,
    @required String Function(T) labelBuilder,
    Widget hint,
  })  : assert(decoration != null),
        assert(labelBuilder != null),
        super(
            key: key,
            onSaved: onSaved,
            initialValue: value,
            validator: validator,
            builder: (FormFieldState<T> field) {
              final InputDecoration effectiveDecoration = decoration
                  .applyDefaults(Theme.of(field.context).inputDecorationTheme);

              void onChangedHandler(T value) {
                if (onChanged != null) {
                  onChanged(value);
                }
                field.didChange(value);
              }

              return InkWell(
                onTap: () async {
                  T picked = await showSearch<T>(
                    context: field.context,
                    delegate: delegate,
                  );
                  onChangedHandler(picked);
                },
                child: InputDecorator(
                  decoration: effectiveDecoration.copyWith(errorText: field.errorText),
                  isEmpty: (field.value ?? value) == null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text((field.value ?? value) != null ? labelBuilder(field.value ?? value) : ""),
                      Icon(
                        Icons.arrow_drop_down,
                        color: Colors.grey.shade700,
                      ),
                    ],
                  ),
                ),
              );
            },
          );

  final ValueChanged<T> onChanged;

  @override
  _SearchFormFieldState<T> createState() => _SearchFormFieldState();
}

class _SearchFormFieldState<T> extends FormFieldState<T> {
  
  T value;

 @override
  void initState() {
    super.initState();
    setState(() {
      value = widget.initialValue;
    });
  }

  @override
  SearchFormField<T> get widget => super.widget;

  @override
  void reset() {
    super.reset();
    setState(() {
      value = widget.initialValue;
    });
  }

  @override
  void didChange(newValue) {
    super.didChange(newValue);
    setState(() {
      value = newValue;
    });
    if (widget.onChanged != null) {
      widget.onChanged(newValue);
    }
  }
}
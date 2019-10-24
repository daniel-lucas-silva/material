import 'package:flutter/widgets.dart';

import '../dropdown.dart';
import '../input_decorator.dart';
import '../theme.dart';

class DropdownFormField<T> extends FormField<T> {
  DropdownFormField({
    Key key,
    T value,
    @required List<DropdownMenuItem<T>> items,
    this.onChanged,
    InputDecoration decoration = const InputDecoration(),
    FormFieldSetter<T> onSaved,
    FormFieldValidator<T> validator,
    Widget hint,
  })  : assert(decoration != null),
        assert(items != null),
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

            return InputDecorator(
              decoration: effectiveDecoration.copyWith(errorText: field.errorText),
              isEmpty: (field.value ?? value) == null,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<T>(
                  isDense: true,
                  value: field.value ?? value,
                  items: items,
                  hint: hint,
                  onChanged: onChangedHandler,
                ),
              ),
            );
          },
        );

  final ValueChanged<T> onChanged;

  @override
  _DropdownFormFieldState<T> createState() => _DropdownFormFieldState();
}

class _DropdownFormFieldState<T> extends FormFieldState<T> {
  T value;

  @override
  void initState() {
    super.initState();
    setState(() {
      value = widget.initialValue;
    });
  }

  @override
  DropdownFormField<T> get widget => super.widget;


  @override
  void reset() {
    super.reset();
    setState(() {
      value = widget.initialValue;
    });
  }

  @override
  void didChange(T newValue) {
    super.didChange(newValue);
    setState(() {
      value = newValue;
    });
    if (widget.onChanged != null) {
      widget.onChanged(newValue);
    }
  }
}
import 'package:flutter/widgets.dart';

import '../colors.dart';
import '../date_picker.dart';
import '../icons.dart';
import '../ink_well.dart';
import '../input_decorator.dart';
import '../theme.dart';

/// ```dart
/// DateFormField(
///   decoration: const InputDecoration(
///     icon: Icon(Icons.person),
///     hintText: 'What do people call you?',
///     labelText: 'Name *',
///   ),
///   onSaved: (DateTime value) {
///     // This optional block of code can be used to run
///     // code when the user saves the form.
///   },
///   validator: (DateTime value) {
///     return value.isAfter(DateTime.now()) ? 'Forbidden' : null;
///   },
/// )
/// ```
class DateFormField extends FormField<DateTime> {
  DateFormField({
    Key key,
    @required String Function(DateTime date) parse,
    DateTime initialValue,
    DateTime firstDate,
    DateTime lastDate,
    @required Locale locale,
    this.onChanged,
    InputDecoration decoration = const InputDecoration(),
    FormFieldSetter<DateTime> onSaved,
    FormFieldValidator<DateTime> validator,
    bool enabled = true,
    bool autovalidate = false,
    Widget hint,
  })  : assert(decoration != null),
        assert(locale != null),
        super(
          key: key,
          initialValue: initialValue ?? DateTime.now(),
          onSaved: onSaved,
          validator: validator,
          autovalidate: autovalidate,
          enabled: enabled,
          builder: (FormFieldState<DateTime> field) {
            final InputDecoration effectiveDecoration = decoration
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            void onChangedHandler(DateTime value) {
              if (onChanged != null) {
                onChanged(value);
              }
              field.didChange(value);
            }

            var currentDate = field.value ?? initialValue ?? DateTime.now();

            return InkWell(
              onTap: () async {
                final DateTime picked = await showDatePicker(
                    context: field.context,
                    initialDate: currentDate,
                    firstDate: firstDate ?? DateTime(1970),
                    lastDate: lastDate ?? DateTime(2099),
                    locale: Locale("pt"),
                    builder: (context, widget) {
                      return Theme(
                        data: Theme.of(field.context)
                            .copyWith(brightness: Brightness.light),
                        child: widget,
                      );
                    });
                if (picked != null && picked != initialValue) {
                  onChangedHandler(picked);
                }
              },
              child: InputDecorator(
                decoration:
                    effectiveDecoration.copyWith(errorText: field.errorText),
                isEmpty: initialValue == null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(parse(currentDate)),
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

  final ValueChanged<DateTime> onChanged;

  @override
  _DateFormFieldState createState() => _DateFormFieldState();
}

class _DateFormFieldState extends FormFieldState<DateTime> {
  DateTime value;

  @override
  void initState() {
    super.initState();
    setState(() {
      value = widget.initialValue;
    });
  }

  @override
  DateFormField get widget => super.widget;

  @override
  void reset() {
    super.reset();
    setState(() {
      value = widget.initialValue;
    });
  }

  @override
  void didChange(DateTime newValue) {
    super.didChange(newValue);
    setState(() {
      value = newValue;
    });
    if (widget.onChanged != null) {
      widget.onChanged(newValue);
    }
  }
}
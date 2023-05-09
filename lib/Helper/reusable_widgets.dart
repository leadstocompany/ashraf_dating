import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CupertinoSwitchListTile extends StatelessWidget {
  /// This has been shamelessly copied from Material/SwitchListTile.
  /// The applicable license applies.
  const CupertinoSwitchListTile({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.activeColor,
    required this.title,
    this.subtitle,
    this.isThreeLine: false,
    this.dense:false,
    this.secondary,
    this.selected: false,
  })  : assert(value != null),
        assert(isThreeLine != null),
        assert(!isThreeLine || subtitle != null),
        assert(selected != null),
        super(key: key);

  /// Whether this switch is checked.
  ///
  /// This property must not be null.
  final bool value;

  /// Called when the user toggles the switch on or off.
  ///
  /// The switch passes the new value to the callback but does not actually
  /// change state until the parent widget rebuilds the switch tile with the
  /// new value.
  ///
  /// If null, the switch will be displayed as disabled.
  ///
  /// The callback provided to [onChanged] should update the state of the parent
  /// [StatefulWidget] using the [State.setState] method, so that the parent
  /// gets rebuilt; for example:
  ///
  /// ```dart
  /// new SwitchListTile(
  ///   value: _lights,
  ///   onChanged: (bool newValue) {
  ///     setState(() {
  ///       _lights = newValue;
  ///     });
  ///   },
  ///   title: new Text('Lights'),
  /// )
  /// ```
  final ValueChanged<bool> onChanged;

  /// The color to use when this switch is on.
  ///
  /// Defaults to accent color of the current [Theme].
  final Color activeColor;

  /// The primary content of the list tile.
  ///
  /// Typically a [Text] widget.
  final Widget title;

  /// Additional content displayed below the title.
  ///
  /// Typically a [Text] widget.
  final Widget? subtitle;

  /// A widget to display on the opposite side of the tile from the switch.
  ///
  /// Typically an [Icon] widget.
  final Widget? secondary;

  /// Whether this list tile is intended to display three lines of text.
  ///
  /// If false, the list tile is treated as having one line if the subtitle is
  /// null and treated as having two lines if the subtitle is non-null.
  final bool isThreeLine;

  /// Whether this list tile is part of a vertically dense list.
  ///
  /// If this property is null then its value is based on [ListTileTheme.dense].
  final bool dense;

  /// Whether to render icons and text in the [activeColor].
  ///
  /// No effort is made to automatically coordinate the [selected] state and the
  /// [value] state. To have the list tile appear selected when the switch is
  /// on, pass the same value to both.
  ///
  /// Normally, this property is left to its default value, false.
  final bool selected;

  @override
  Widget build(BuildContext context) {
    var color =  activeColor ?? Theme.of(context).accentColor;
    print("Active color: ${color.red} ${color.green} ${color.blue}");
    final Widget control = new CupertinoSwitch(
      value: value,
      onChanged: onChanged,
      activeColor: activeColor ?? CupertinoColors.activeGreen,
    );
    return new MergeSemantics(
      child: ListTileTheme.merge(
        selectedColor: activeColor ?? CupertinoColors.activeGreen,
        child: new ListTile(
          leading: secondary,
          title: title,
          subtitle: subtitle,
          trailing: control,
          isThreeLine: isThreeLine,
          dense: dense,
          enabled: onChanged != null,
          onTap: onChanged != null
              ? () {
            onChanged(!value);
          }
              : null,
          selected: selected,
        ),
      ),
    );
  }
}


class ReusableWidgets{

  Widget FluidTextField(
      String label,
      String hintText,
      BuildContext myContext,
      TextEditingController textEditingController,
      bool? obscureText,
      bool isMandatory,
      Function()? onSuffixIconTap,
      bool disabled,
      [Icon? prefixIcon,int? maxLines]
      ){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label),
            Text(isMandatory?"*":"",style: TextStyle(color: Colors.red),),
          ],
        ),
        SizedBox(height: label==""?0:8,),
        TextField(
          enabled: !disabled,
          obscureText: obscureText!,
          controller: textEditingController,
          cursorColor: Theme.of(myContext).primaryColor,
          maxLines: maxLines??1,
          decoration: InputDecoration(
              fillColor: Theme.of(myContext).primaryColor,
              prefixIconColor: Theme.of(myContext).primaryColor,
              prefixIcon: prefixIcon,

            suffixIconColor: Theme.of(myContext).primaryColor,
              suffixIcon: (obscureText)?IconButton(onPressed: onSuffixIconTap,
                  icon: Icon(obscureText?Icons.remove_red_eye:Icons.remove_red_eye_outlined)):null,
              enabledBorder: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderSide:  BorderSide(color: Colors.grey, width: 0.5),
                borderRadius: BorderRadius.circular(15)
              ),
              disabledBorder: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                  borderSide:  BorderSide(color: Colors.grey, width: 0.5),
                  borderRadius: BorderRadius.circular(15)
              ),
              focusedBorder: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                  borderSide:  BorderSide(color: Theme.of(myContext).primaryColor, width: 1),
                  borderRadius: BorderRadius.circular(15)
              ),
              border: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                  borderSide:  BorderSide(color: Colors.black, width: 0.5),
                  borderRadius: BorderRadius.circular(15)
              ),
          ),
        ),
      ],
    );
  }

  Widget FluidButton(
      String label,
      Function() onTap,
      BuildContext context,
      ){
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical:size.height*0.02 ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).primaryColor,  
        ),
        child: Center(
          child: Text(label,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
        ),
      ),
    );
  }

  FluidHeaderText(String s,BuildContext context) {
    return Text(s,style: Theme.of(context).textTheme.headlineLarge,);
  }

  FluidNoteText(String s,BuildContext context) {
    return Text(s,style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),);
  }

  FluidParagraphText(String s,BuildContext context) {
    return Text(s,style: Theme.of(context).textTheme.bodyMedium,);
  }

  FluidBoldHeaderText(String s,BuildContext context,bool isAlignedCenter) {
    return Text(s,style: Theme.of(context).textTheme.headlineLarge?.copyWith(
      fontWeight: FontWeight.w900
    ),textAlign:isAlignedCenter? TextAlign.center:TextAlign.left,);
  }
  FluidBoldSubHeaderText(String s,BuildContext context,bool isAlignedCenter) {
    return Text(s,style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.w900
    ),textAlign:isAlignedCenter? TextAlign.center:TextAlign.left,);
  }

  Widget FluidButtonColor(
      String label,
      Function() onTap,
      Color backgroundColor,
      BuildContext context,
      Widget? icon,
      ){
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical:size.height*0.02 ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: backgroundColor,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(label,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
              icon!=null?SizedBox(width: 20,):Container(),
              icon??Container(),
            ],
          ),
        ),
      ),
    );
  }

  FluidDropDown(BuildContext context,String label,String hintText,List<String> _dropdownValues,Function(dynamic?)? onChanged,String? val) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label,style:Theme.of(context).textTheme.titleMedium,),
            Text(false?"*":"",style: TextStyle(color: Colors.red),),
          ],
        ),
        SizedBox(height: label==""?0:8,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
                color: Theme.of(context).primaryColor, style: BorderStyle.solid, width: 0.80),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              hint: Text(hintText),
              items: _dropdownValues
                  .map((value) => DropdownMenuItem(
                child: Text(value),
                value: value,
              ))
                  .toList(),
              onChanged: onChanged,
              isExpanded: false,
              value: val,
            ),
          ),
        ),
      ],
    );
  }

}
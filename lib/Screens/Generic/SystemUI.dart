import 'package:flutter/material.dart';
import 'package:my_barber/Utils/size_config.dart';
import 'package:my_barber/Utils/styling.dart';

class SystemUI {
  RawMaterialButton cancelButton(Function onPressed,
      {Color backgroundColor = AppTheme.selectedTabBackgroundColor,
      Color textColor = Colors.white,
      String text = "Cancel"}) {
    return RawMaterialButton(
      onPressed: onPressed,
      fillColor: backgroundColor,
      child: Container(
        width: 100 * SizeConfig.widthMultiplier,
        child: Text(
          text,
          style: TextStyle(color: textColor),
          textAlign: TextAlign.center,
        ),
      ),
      padding: EdgeInsets.all(2 * SizeConfig.heightMultiplier),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(1 * SizeConfig.heightMultiplier)),
    );
  }
}

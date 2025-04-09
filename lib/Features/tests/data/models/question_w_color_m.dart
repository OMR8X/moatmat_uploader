import 'package:flutter/material.dart';

import '../../domain/entities/question/question_word_color.dart';

class QuestionWordColorModel extends QuestionWordColor {
  QuestionWordColorModel({
    required super.index,
    required super.color,
  });

  factory QuestionWordColorModel.fromJson(Map json) {
    return QuestionWordColorModel(
      index: json["index"],
      color: stringToColor(json["color"]),
    );
  }

  factory QuestionWordColorModel.fromClass(QuestionWordColor wordColor) {
    return QuestionWordColorModel(
      index: wordColor.index,
      color: wordColor.color,
    );
  }

  toJson() {
    return {
      "index": index,
      "color": colorToString(color),
    };
  }

  // Function to convert Color to String
  static String? colorToString(Color? color) {
    return color?.value.toRadixString(16).padLeft(8, '0');
  }

// Function to convert String to Color
  static Color stringToColor(String colorString) {
    return Color(int.parse(colorString, radix: 16));
  }
}

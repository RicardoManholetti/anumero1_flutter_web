import 'package:anumero1_flutter_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AppColors should have correct values', () {
    expect(AppColors.primary, const Color(0xFF1EA9C4));
    expect(AppColors.accent, const Color(0xFF08313A));
    expect(AppColors.background, const Color(0xFFFFFFFF));
  });
}

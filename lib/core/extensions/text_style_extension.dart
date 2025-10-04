// Flutter imports:
import 'package:flutter/material.dart';

extension TextStyleExtension on TextStyle {
  // Colors
  TextStyle colorPrimary(BuildContext context) => copyWith(
    color: ColorScheme.of(context).primary,
  );
  TextStyle colorOnPrimary(BuildContext context) => copyWith(
    color: ColorScheme.of(context).onPrimary,
  );
  TextStyle colorPrimaryContainer(BuildContext context) => copyWith(
    color: ColorScheme.of(context).primaryContainer,
  );
  TextStyle colorOnPrimaryContainer(BuildContext context) => copyWith(
    color: ColorScheme.of(context).onPrimaryContainer,
  );
  TextStyle colorSecondary(BuildContext context) => copyWith(
    color: ColorScheme.of(context).secondary,
  );
  TextStyle colorOnSecondary(BuildContext context) => copyWith(
    color: ColorScheme.of(context).onSecondary,
  );
  TextStyle colorSecondaryContainer(BuildContext context) => copyWith(
    color: ColorScheme.of(context).secondaryContainer,
  );
  TextStyle colorOnSecondaryContainer(BuildContext context) => copyWith(
    color: ColorScheme.of(context).onSecondaryContainer,
  );
  TextStyle colorTertiary(BuildContext context) => copyWith(
    color: ColorScheme.of(context).tertiary,
  );
  TextStyle colorOnTertiary(BuildContext context) => copyWith(
    color: ColorScheme.of(context).onTertiary,
  );
  TextStyle colorTertiaryContainer(BuildContext context) => copyWith(
    color: ColorScheme.of(context).tertiaryContainer,
  );
  TextStyle colorOnTertiaryContainer(BuildContext context) => copyWith(
    color: ColorScheme.of(context).onTertiaryContainer,
  );
  TextStyle colorError(BuildContext context) => copyWith(
    color: ColorScheme.of(context).error,
  );
  TextStyle colorOnError(BuildContext context) => copyWith(
    color: ColorScheme.of(context).onError,
  );
  TextStyle colorErrorContainer(BuildContext context) => copyWith(
    color: ColorScheme.of(context).errorContainer,
  );
  TextStyle colorOnErrorContainer(BuildContext context) => copyWith(
    color: ColorScheme.of(context).onErrorContainer,
  );
  TextStyle colorSurface(BuildContext context) => copyWith(
    color: ColorScheme.of(context).surface,
  );
  TextStyle colorOnSurface(BuildContext context) => copyWith(
    color: ColorScheme.of(context).onSurface,
  );
  TextStyle colorOnSurfaceVariant(BuildContext context) => copyWith(
    color: ColorScheme.of(context).onSurfaceVariant,
  );
  TextStyle colorOutline(BuildContext context) => copyWith(
    color: ColorScheme.of(context).outline,
  );
  TextStyle colorOutlineVariant(BuildContext context) => copyWith(
    color: ColorScheme.of(context).outlineVariant,
  );

  // Weights
  TextStyle get light => copyWith(
    fontWeight: FontWeight.w300,
  );
  TextStyle get regular => copyWith(
    fontWeight: FontWeight.w400,
  );
  TextStyle get medium => copyWith(
    fontWeight: FontWeight.w500,
  );
  TextStyle get semiBold => copyWith(
    fontWeight: FontWeight.w600,
  );
  TextStyle get bold => copyWith(
    fontWeight: FontWeight.w700,
  );
}

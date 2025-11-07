import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff3c6939),
      surfaceTint: Color(0xff3c6939),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffbcf0b4),
      onPrimaryContainer: Color(0xff245024),
      secondary: Color(0xff505b92),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffdde1ff),
      onSecondaryContainer: Color(0xff384379),
      tertiary: Color(0xff016b5d),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff9ff2e0),
      onTertiaryContainer: Color(0xff005046),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfff7fbf1),
      onSurface: Color(0xff191d17),
      onSurfaceVariant: Color(0xff424940),
      outline: Color(0xff72796f),
      outlineVariant: Color(0xffc2c9bd),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d322c),
      inversePrimary: Color(0xffa1d39a),
      primaryFixed: Color(0xffbcf0b4),
      onPrimaryFixed: Color(0xff002204),
      primaryFixedDim: Color(0xffa1d39a),
      onPrimaryFixedVariant: Color(0xff245024),
      secondaryFixed: Color(0xffdde1ff),
      onSecondaryFixed: Color(0xff09164b),
      secondaryFixedDim: Color(0xffb9c3ff),
      onSecondaryFixedVariant: Color(0xff384379),
      tertiaryFixed: Color(0xff9ff2e0),
      onTertiaryFixed: Color(0xff00201b),
      tertiaryFixedDim: Color(0xff83d5c5),
      onTertiaryFixedVariant: Color(0xff005046),
      surfaceDim: Color(0xffd8dbd2),
      surfaceBright: Color(0xfff7fbf1),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff1f5eb),
      surfaceContainer: Color(0xffecefe6),
      surfaceContainerHigh: Color(0xffe6e9e0),
      surfaceContainerHighest: Color(0xffe0e4db),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff123f14),
      surfaceTint: Color(0xff3c6939),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff4a7847),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff273267),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff5f6aa2),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff003e35),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff207a6c),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff7fbf1),
      onSurface: Color(0xff0e120d),
      onSurfaceVariant: Color(0xff32382f),
      outline: Color(0xff4e544b),
      outlineVariant: Color(0xff686f65),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d322c),
      inversePrimary: Color(0xffa1d39a),
      primaryFixed: Color(0xff4a7847),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff325f30),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff5f6aa2),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff465188),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff207a6c),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff006054),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc4c8bf),
      surfaceBright: Color(0xfff7fbf1),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff1f5eb),
      surfaceContainer: Color(0xffe6e9e0),
      surfaceContainerHigh: Color(0xffdaded5),
      surfaceContainerHighest: Color(0xffcfd3ca),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff05340b),
      surfaceTint: Color(0xff3c6939),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff265326),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff1c285c),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff3b457b),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff00332b),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff005348),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff7fbf1),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff282e26),
      outlineVariant: Color(0xff454b42),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d322c),
      inversePrimary: Color(0xffa1d39a),
      primaryFixed: Color(0xff265326),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff0d3b11),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff3b457b),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff232e63),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff005348),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff003a32),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffb6bab1),
      surfaceBright: Color(0xfff7fbf1),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff2e9),
      surfaceContainer: Color(0xffe0e4db),
      surfaceContainerHigh: Color(0xffd2d6cd),
      surfaceContainerHighest: Color(0xffc4c8bf),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffa1d39a),
      surfaceTint: Color(0xffa1d39a),
      onPrimary: Color(0xff0a390f),
      primaryContainer: Color(0xff245024),
      onPrimaryContainer: Color(0xffbcf0b4),
      secondary: Color(0xffb9c3ff),
      onSecondary: Color(0xff212c61),
      secondaryContainer: Color(0xff384379),
      onSecondaryContainer: Color(0xffdde1ff),
      tertiary: Color(0xff83d5c5),
      onTertiary: Color(0xff003730),
      tertiaryContainer: Color(0xff005046),
      onTertiaryContainer: Color(0xff9ff2e0),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff10140f),
      onSurface: Color(0xffe0e4db),
      onSurfaceVariant: Color(0xffc2c9bd),
      outline: Color(0xff8c9388),
      outlineVariant: Color(0xff424940),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e4db),
      inversePrimary: Color(0xff3c6939),
      primaryFixed: Color(0xffbcf0b4),
      onPrimaryFixed: Color(0xff002204),
      primaryFixedDim: Color(0xffa1d39a),
      onPrimaryFixedVariant: Color(0xff245024),
      secondaryFixed: Color(0xffdde1ff),
      onSecondaryFixed: Color(0xff09164b),
      secondaryFixedDim: Color(0xffb9c3ff),
      onSecondaryFixedVariant: Color(0xff384379),
      tertiaryFixed: Color(0xff9ff2e0),
      onTertiaryFixed: Color(0xff00201b),
      tertiaryFixedDim: Color(0xff83d5c5),
      onTertiaryFixedVariant: Color(0xff005046),
      surfaceDim: Color(0xff10140f),
      surfaceBright: Color(0xff363a34),
      surfaceContainerLowest: Color(0xff0b0f0a),
      surfaceContainerLow: Color(0xff191d17),
      surfaceContainer: Color(0xff1d211b),
      surfaceContainerHigh: Color(0xff272b25),
      surfaceContainerHighest: Color(0xff323630),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffb6eaae),
      surfaceTint: Color(0xffa1d39a),
      onPrimary: Color(0xff002d06),
      primaryContainer: Color(0xff6d9c67),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffd6daff),
      onSecondary: Color(0xff152155),
      secondaryContainer: Color(0xff828dc8),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xff99ecda),
      onTertiary: Color(0xff002b25),
      tertiaryContainer: Color(0xff4c9e8f),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff10140f),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffd8ded2),
      outline: Color(0xffadb4a8),
      outlineVariant: Color(0xff8c9288),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e4db),
      inversePrimary: Color(0xff255125),
      primaryFixed: Color(0xffbcf0b4),
      onPrimaryFixed: Color(0xff001602),
      primaryFixedDim: Color(0xffa1d39a),
      onPrimaryFixedVariant: Color(0xff123f14),
      secondaryFixed: Color(0xffdde1ff),
      onSecondaryFixed: Color(0xff000a3e),
      secondaryFixedDim: Color(0xffb9c3ff),
      onSecondaryFixedVariant: Color(0xff273267),
      tertiaryFixed: Color(0xff9ff2e0),
      onTertiaryFixed: Color(0xff001511),
      tertiaryFixedDim: Color(0xff83d5c5),
      onTertiaryFixedVariant: Color(0xff003e35),
      surfaceDim: Color(0xff10140f),
      surfaceBright: Color(0xff41463f),
      surfaceContainerLowest: Color(0xff050805),
      surfaceContainerLow: Color(0xff1b1f19),
      surfaceContainer: Color(0xff252923),
      surfaceContainerHigh: Color(0xff30342e),
      surfaceContainerHighest: Color(0xff3b3f38),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffcafec0),
      surfaceTint: Color(0xffa1d39a),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff9dcf96),
      onPrimaryContainer: Color(0xff000f01),
      secondary: Color(0xffefefff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffb4bffd),
      onSecondaryContainer: Color(0xff00062f),
      tertiary: Color(0xffb1ffee),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xff7fd2c1),
      onTertiaryContainer: Color(0xff000e0b),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff10140f),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffecf2e6),
      outlineVariant: Color(0xffbec5b9),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e4db),
      inversePrimary: Color(0xff255125),
      primaryFixed: Color(0xffbcf0b4),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffa1d39a),
      onPrimaryFixedVariant: Color(0xff001602),
      secondaryFixed: Color(0xffdde1ff),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffb9c3ff),
      onSecondaryFixedVariant: Color(0xff000a3e),
      tertiaryFixed: Color(0xff9ff2e0),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xff83d5c5),
      onTertiaryFixedVariant: Color(0xff001511),
      surfaceDim: Color(0xff10140f),
      surfaceBright: Color(0xff4d514b),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1d211b),
      surfaceContainer: Color(0xff2d322c),
      surfaceContainerHigh: Color(0xff383d36),
      surfaceContainerHighest: Color(0xff444841),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
  );

  /// Custom Color 1
  static const customColor1 = ExtendedColor(
    seed: Color(0xff358661),
    value: Color(0xff358661),
    light: ColorFamily(
      color: Color(0xff246a4b),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffabf2ca),
      onColorContainer: Color(0xff005235),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff246a4b),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffabf2ca),
      onColorContainer: Color(0xff005235),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff246a4b),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffabf2ca),
      onColorContainer: Color(0xff005235),
    ),
    dark: ColorFamily(
      color: Color(0xff8fd5af),
      onColor: Color(0xff003823),
      colorContainer: Color(0xff005235),
      onColorContainer: Color(0xffabf2ca),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xff8fd5af),
      onColor: Color(0xff003823),
      colorContainer: Color(0xff005235),
      onColorContainer: Color(0xffabf2ca),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xff8fd5af),
      onColor: Color(0xff003823),
      colorContainer: Color(0xff005235),
      onColorContainer: Color(0xffabf2ca),
    ),
  );

  /// Custom Color 2
  static const customColor2 = ExtendedColor(
    seed: Color(0xff339c5b),
    value: Color(0xff339c5b),
    light: ColorFamily(
      color: Color(0xff306a42),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffb3f1bf),
      onColorContainer: Color(0xff15512c),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff306a42),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffb3f1bf),
      onColorContainer: Color(0xff15512c),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff306a42),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffb3f1bf),
      onColorContainer: Color(0xff15512c),
    ),
    dark: ColorFamily(
      color: Color(0xff98d5a4),
      onColor: Color(0xff00391a),
      colorContainer: Color(0xff15512c),
      onColorContainer: Color(0xffb3f1bf),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xff98d5a4),
      onColor: Color(0xff00391a),
      colorContainer: Color(0xff15512c),
      onColorContainer: Color(0xffb3f1bf),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xff98d5a4),
      onColor: Color(0xff00391a),
      colorContainer: Color(0xff15512c),
      onColorContainer: Color(0xffb3f1bf),
    ),
  );

  List<ExtendedColor> get extendedColors => [customColor1, customColor2];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}

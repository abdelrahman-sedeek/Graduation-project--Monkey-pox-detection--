// part of 'theme_cubit.dart';
//
// @immutable
// abstract class ThemeState {}
//
// class ThemeInitial extends ThemeState {}


class ThemeState {
  final bool isDark;

  const ThemeState(this.isDark);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ThemeState && other.isDark == isDark;
  }

  @override
  int get hashCode => isDark.hashCode;
}
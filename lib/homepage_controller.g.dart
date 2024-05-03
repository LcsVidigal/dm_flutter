// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homepage_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomepageController on HomepageControllerBase, Store {
  late final _$testeAtom =
      Atom(name: 'HomepageControllerBase.teste', context: context);

  @override
  String get teste {
    _$testeAtom.reportRead();
    return super.teste;
  }

  @override
  set teste(String value) {
    _$testeAtom.reportWrite(value, super.teste, () {
      super.teste = value;
    });
  }

  @override
  String toString() {
    return '''
teste: ${teste}
    ''';
  }
}

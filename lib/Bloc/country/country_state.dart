part of 'country_bloc.dart';

@immutable
abstract class CountryState {}

class InitialCountryState extends CountryState {
  @override
  String toString() {
    print("InitialCountryState");
  }
}

class LoadingCountryState extends CountryState {
  @override
  String toString() {
    print("LoadingCountryState");
  }
}

class LoadedCountryState extends CountryState {

  List<CountryModel> list;

  LoadedCountryState(this.list);

  @override
  String toString() {
    print("LoadedCountryState");
  }
}

class ErrorCountryState extends CountryState {
  @override
  String toString() {
    print("ErrorCountryState");
  }
}



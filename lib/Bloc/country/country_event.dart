part of 'country_bloc.dart';

@immutable
abstract class CountryEvent {}

abstract class CountryEventDelegate  {
  void onSuccess();
  void onError();
}

class InitialEvent extends CountryEvent {

}

class GetDataFromHttpEvent extends CountryEvent {
}

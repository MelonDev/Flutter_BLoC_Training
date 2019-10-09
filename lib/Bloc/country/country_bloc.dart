import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;

import '../../country_model.dart';

part 'country_event.dart';

part 'country_state.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  @override
  CountryState get initialState => InitialCountryState();

  @override
  Stream<CountryState> mapEventToState(CountryEvent event) async* {
    if (event is GetDataFromHttpEvent) {
      yield* getdataFromHttpEventToState(event);
    }
  }

  @override
  Stream<CountryState> getdataFromHttpEventToState(CountryEvent event) async* {
    yield LoadingCountryState();

    //await Future.delayed(new Duration(seconds: 3));

    try {
      http.Response response = await http
          .get(
              'https://melondev-frailty-project.herokuapp.com/api/training/loadExampleData')
          .then((onValue) {

        return onValue;
      });
      if(response.body != null){
        List responseJson = json.decode(response.body);
        List<CountryModel> snapshot = responseJson.map((m) => new CountryModel.fromJson(m)).toList();


        yield LoadedCountryState(snapshot);
      }else {
        yield ErrorCountryState();
      }
    } catch (error) {
      yield ErrorCountryState();
    }
  }
}

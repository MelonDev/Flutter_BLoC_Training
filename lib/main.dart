import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_se_project/Bloc/country/country_bloc.dart';
import 'package:flutter_se_project/country_model.dart';
import 'package:flutter_se_project/flow_bloc_delegate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  BlocSupervisor.delegate = FlowBlocDelegate();
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CountryBloc>(
          builder: (BuildContext context) =>
          CountryBloc()
            ..dispatch(GetDataFromHttpEvent()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.cyan,
        ),
        home: MyHomePage(title: 'Flutter BLoC Example'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CountryBloc _countryBloc;

  @override
  Widget build(BuildContext context) {
    _countryBloc = BlocProvider.of<CountryBloc>(context);

    //_countryBloc.dispatch(GetDataFromHttpEvent());

    return BlocBuilder<CountryBloc, CountryState>(
      builder: (BuildContext context, CountryState _state) {
        if (_state is InitialCountryState) {
          _countryBloc.dispatch(GetDataFromHttpEvent());
          return _loadingWidget(context, _state);
        } else if (_state is LoadingCountryState) {
          return _loadingWidget(context, _state);
        } else if (_state is LoadedCountryState) {
          return _loadedWidget(context, _state);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _loadingWidget(BuildContext context, CountryState _state) {
    return Container(
      color: Colors.red,
      child: SpinKitHourGlass(
        color: Colors.white,
        size: 80,
        duration: Duration(seconds: 1),
      ),
    );
  }

  Widget _loadedWidget(BuildContext context, LoadedCountryState _state) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: FlatButton(
            onPressed: () {
              _countryBloc.dispatch(GetDataFromHttpEvent());
            },
            child: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,
          title: Text(
            widget.title,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        body: Container(
            child: ListView.builder(
              itemBuilder: (context, position) {
                return _cardListWidget(_state.list[position]);
              },
              itemCount: _state.list != null ? _state.list.length : 0,
            ))
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _mainWidget(BuildContext context, CountryState _state) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        body: Container()
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _cardListWidget(CountryModel _countryModel) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(14))),
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: 230,
      margin: EdgeInsets.fromLTRB(10, 16, 10, 0),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(14)),
            child: Image.network(
              _countryModel.imageUrl,
              fit: BoxFit.fill,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: 230,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(14),
                          bottomRight: Radius.circular(14))),
                  height: 80,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _countryModel.title,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'SukhumvitSet',
                              fontSize: 25),
                          textAlign: TextAlign.left,
                        ),
                        Text(_countryModel.description,
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontFamily: 'SukhumvitSet',
                                fontSize: 16),
                            textAlign: TextAlign.left)
                      ],
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }
}

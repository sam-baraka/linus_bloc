import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linus_bloc/bloc/linus_cubit.dart';

import 'bloc/http_cubit/cubit/http_cubit.dart';

/// Custom [BlocObserver] which observes all bloc and cubit instances.
class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LinusCubit>(
          create: (context) => LinusCubit(""),
        ),
        BlocProvider<HttpCubit>(create: (context) => HttpCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // LinusCubit linusBloc = BlocProvider.of<LinusCubit>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(context.watch<LinusCubit>().state),
          TextFormField(
            onChanged: (value) {
              context.read<LinusCubit>().changeState(value: value);
            },
          ),
          CupertinoButton(
              child: Text("Change"),
              color: Colors.blue,
              onPressed: () {
                print("Value ${context.read<LinusCubit>().state}");
              }),
          CupertinoButton(
              child: Text("Page 2"),
              color: Colors.blue,
              onPressed: () {
                Navigator.of(context)
                    .push(CupertinoPageRoute(builder: (context) => Page2()));
              }),
        ],
      ),
    );
  }
}

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HttpCubit, HttpState>(
      listener: (context, state) {
        if (state is HttpStateFailed) {
          showCupertinoDialog(
              context: context,
              builder: (builder) => CupertinoActionSheet(
                    title: Text("Error"),
                    message: Text("state.errrorMessage"),
                  ));
        }
      },
      builder: (context, state) {
        if (state is HttpStateLoading) {
          return Scaffold(
              body: Center(
            child: CircularProgressIndicator(),
          ));
        }
        return Scaffold(
            body: Center(
                child: CupertinoButton(
          child: Text("GEt"),
          color: Colors.black,
          onPressed: () {
            context.read<HttpCubit>().getData();
          },
        )));
      },
    );
  }
}

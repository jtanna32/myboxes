import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myboxes/blocs/box_bloc/box_bloc.dart';

class HomeView extends StatefulWidget {
  final int number;

  const HomeView({Key? key, required this.number}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController numberController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<BoxBloc>(context)
        .add(InitializeListEvent(number: widget.number));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        BlocProvider.of<BoxBloc>(context).add(InitialBlocEvent());
        return Future.value(true);
      },
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _buildBody(context),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text("Screen 2"),
      leading: InkWell(
          onTap: () {
            BlocProvider.of<BoxBloc>(context).add(InitialBlocEvent());
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back)),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: BlocBuilder<BoxBloc, BoxState>(
          builder: (context, state) {
            if (state is BoxInitial) {
              return Container();
            }
            if (state is BoxInitializeSuccess) {
              return Wrap(
                children: [
                  for (int i = 0; i < widget.number; i++)
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: InkWell(
                          onTap: () {
                            if (state.boxes[i].isSelected! == false) {
                              if (state.boxes[i].isRandomlySelected!) {
                                BlocProvider.of<BoxBloc>(context).add(
                                    SelectBoxEvent(
                                        index: i, length: widget.number));
                              }
                            }
                          },
                          child: Container(
                              height: 100,
                              width: 100,
                              color: state.boxes[i].isRandomlySelected!
                                  ? Colors.blue
                                  : Colors.red),
                        ))
                ],
              );
            } else if (state is BoxSelectSuccess) {
              return Wrap(
                children: [
                  for (int i = 0; i < widget.number; i++)
                    InkWell(
                      onTap: () {
                        if (state.boxes[i].isSelected! == false) {
                          if (state.boxes[i].isRandomlySelected!) {
                            BlocProvider.of<BoxBloc>(context).add(
                                SelectBoxEvent(
                                    index: i, length: widget.number));
                          }
                        }
                      },
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                              height: 100,
                              width: 100,
                              color: state.boxes[i].isSelected!
                                  ? Colors.green
                                  : state.boxes[i].isRandomlySelected!
                                      ? Colors.blue
                                      : Colors.red)),
                    )
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

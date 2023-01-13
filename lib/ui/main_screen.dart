import 'package:chisla_and_facts/bloc/fact_bloc.dart';
import 'package:chisla_and_facts/ui/theme/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _controller = TextEditingController();
  late final FactBloc _factBloc;
  bool themeState = false;

  @override
  void initState() {
    _factBloc = BlocProvider.of<FactBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Факты о числах'),
          centerTitle: true,
          actions: [
            Switch(
              value: themeState,
              onChanged: (value) {
                setState(() {
                  themeState = value;

                });
                BlocProvider.of<ThemeBloc>(context).add(ThemeChanged());
              },
            )
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onSubmitted: (String value){_factBloc.add(GetInfoEvent(value));},
                  decoration: InputDecoration(
                    hintText: 'Введите число',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _factBloc.add(GetInfoEvent(_controller.text));
                      },
                      child: const Text('Поиск'),
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                    ElevatedButton(
                        onPressed: (){
                          _controller.clear();
                          _factBloc.add(GetInfoEvent(_controller.text));
                        },
                        child: const Text('Очистить')
                    ),
                  ],
                ),
                BlocBuilder(
                  bloc: _factBloc,
                  builder: (_, FactState state) {
                    switch (state.status) {
                      case ScreenStatus.error:
                        return const Text('error');
                      case ScreenStatus.loading:
                        return const Text('loading');
                      case ScreenStatus.unknown:
                        return const Text('Введите число');
                      case ScreenStatus.success:
                        return Text(state.info!);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shinup/core/di/service_locator.dart';
import 'package:shinup/core/localization/app_localizations.dart';
import 'package:shinup/features/counter/domain/usecases/get_counter_usecase.dart';
import 'package:shinup/features/counter/domain/usecases/increment_counter_usecase.dart';
import 'package:shinup/features/counter/presentation/bloc/counter_bloc.dart';
import 'package:shinup/features/counter/presentation/widgets/counter_display.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBloc(
        sl<GetCounterUseCase>(),
        sl<IncrementCounterUseCase>(),
      )..add(const CounterStarted()),
      child: const _CounterView(),
    );
  }
}

class _CounterView extends StatelessWidget {
  const _CounterView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.counterTitle),
        backgroundColor: theme.colorScheme.inversePrimary,
      ),
      body: Center(
        child: BlocBuilder<CounterBloc, CounterState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(t.counterDescription),
                CounterDisplay(value: state.count),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CounterBloc>().add(const CounterIncrementPressed());
        },
        tooltip: t.increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}

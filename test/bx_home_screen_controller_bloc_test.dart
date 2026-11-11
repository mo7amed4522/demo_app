import 'package:demo_app/presentation/bloc/bx_home_screen_controller/bx_home_screen_controller_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BxHomeScreenControllerBloc', () {
    late BxHomeScreenControllerBloc bloc;

    setUp(() {
      bloc = BxHomeScreenControllerBloc();
    });

    tearDown(() async {
      await bloc.close();
    });

    test('selects the Profile tab at index 1', () async {
      bloc.add(const BxHomeScreenControllerTabChanged(1));
      await pumpEventQueue();

      expect(bloc.state.activeTabIndex, 1);
    });

    test('ignores tab indexes outside the two-tab range', () async {
      bloc
        ..add(const BxHomeScreenControllerTabChanged(-1))
        ..add(const BxHomeScreenControllerTabChanged(2));
      await pumpEventQueue();

      expect(bloc.state.activeTabIndex, 0);
    });
  });
}

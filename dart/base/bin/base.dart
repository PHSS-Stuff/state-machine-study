import 'package:base/base.dart';

void main(List<String> arguments) {
  final machine = Machine(initialState: LigthOnState());
  machine.transition('off').transition('on').transition('off');
}

class LigthOnState extends State<String> {
  LigthOnState()
      : super(
          actions: const LigthOnActions(),
          transitions: LigthOnTransactions(),
        );
}

class LigthOnActions extends Actions {
  const LigthOnActions();
  @override
  void onEnter() {
    print('light is on - from on enter light on');
  }

  @override
  void onExit() {
    print('light is off - from on exit light on');
  }
}

class LigthOnTransactions extends Transitions<String> {
  static State Function() get factoryLightOffState => () {
        print('transition light on to light off - from transaction funciton');
        return LigthOffState();
      };

  static Map<String, State Function()> get _switchs => {
        'off': factoryLightOffState,
      };

  LigthOnTransactions() : super(_switchs);
}

class LigthOffState extends State<String> {
  LigthOffState()
      : super(
          actions: const LigthOffActions(),
          transitions: LigthOffTransactions(),
        );
}

class LigthOffActions extends Actions {
  const LigthOffActions();
  @override
  void onEnter() {
    print('light is off - from on enter light off');
  }

  @override
  void onExit() {
    print('light is on - from on exit light off');
  }
}

class LigthOffTransactions extends Transitions<String> {
  static State Function() get factoryLightOnState => () {
        print('transition light on to light off - from transaction funciton');
        return LigthOnState();
      };

  static Map<String, State Function()> get _switchs => {
        'on': factoryLightOnState,
      };

  LigthOffTransactions() : super(_switchs);
}

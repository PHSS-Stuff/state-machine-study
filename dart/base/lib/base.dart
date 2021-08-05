class Machine<Event> {
  final State<Event> initialState;

  const Machine({required this.initialState});

  Machine transition(Event event) {
    final newState = initialState.transitions.transition(initialState, event);
    return Machine(initialState: newState);
  }
}

abstract class State<Event> {
  final Actions actions;
  final Transitions<Event> transitions;

  const State({
    required this.actions,
    required this.transitions,
  });
}

abstract class Actions {
  const Actions();
  void onEnter();
  void onExit();
}

abstract class Transitions<Event> {
  final Map<Event, State Function()> _switchs;

  const Transitions(this._switchs);

  State transition(State currentState, Event event) {
    final newStateFactory = _switchs[event];
    if (newStateFactory == null) {
      throw Exception('undefined event');
    }
    currentState.actions.onExit();
    final newState = newStateFactory();
    newState.actions.onEnter();
    return newState;
  }
}

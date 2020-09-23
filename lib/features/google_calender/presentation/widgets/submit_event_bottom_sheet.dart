import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calender/core/presentation/event_entity_convertor.dart';
import 'package:flutter_calender/features/google_calender/domain/entities/event_entity.dart';
import 'package:flutter_calender/features/google_calender/presentation/bloc/calender_bloc.dart';

typedef OnValueChanged<T> = void Function(T newValue);

class SubmitEventBottomSheet extends StatefulWidget {
  @override
  _SubmitEventBottomSheetState createState() => _SubmitEventBottomSheetState();
}

class _SubmitEventBottomSheetState extends State<SubmitEventBottomSheet> {
  String _name;
  String _description;
  DateTime _startDate = DateTime.now();
  DateTime _dueDate = DateTime.now();
  RepeatMode _repeatMode;

  int _currentStepIndex = 0;
  String _errMsg;
  bool _isCompleted = false;
  List<StepState> _stepStates = [
    StepState.editing,
    StepState.disabled,
    StepState.disabled
  ];

  void success() {
    setState(() {
      _stepStates[_currentStepIndex] = StepState.complete;
      _errMsg = null;
      _currentStepIndex++;
    });
  }

  void failure(String errMsg) {
    setState(() {
      _stepStates[_currentStepIndex] = StepState.error;
      _errMsg = errMsg;
    });
  }

  void onStepContinue() {
    var parsed = EventEntityConvertor().parseEvent(
      description: _description,
      dueDate: _dueDate,
      name: _name,
      recurrence: _repeatMode,
      startDate: _startDate,
    );
    parsed.fold((l) {
      if (l is InvalidInputFailure) {
        _errMsg = l.errMsg;
        if (_currentStepIndex == 0 &&
            _errMsg != invalidName &&
            _errMsg != invalidDescription) {
          success();
          return;
        }
        failure(l.errMsg);
      }
    }, (r) {
      if (_currentStepIndex == 1) {
        success();
        return;
      }
      setState(() {
        _isCompleted = true;
        _errMsg = null;
      });
      BlocProvider.of<CalenderBloc>(context).add(SubmitCalenderEvent(
        description: _description,
        dueDate: _dueDate,
        name: _name,
        recurrence: _repeatMode,
        startDate: _startDate,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mqd = MediaQuery.of(context);
    return Card(
      child: Container(
        height: mqd.size.width * 1.5,
        width: mqd.size.width,
        child: !_isCompleted
            ? Stepper(
                currentStep: _currentStepIndex,
                onStepContinue: onStepContinue,
                onStepCancel: () {
                  Navigator.of(context).pop();
                },
                steps: [
                  NameAndDescriptionStep(
                    isActive: _stepStates[0] == StepState.error ||
                        _stepStates[0] == StepState.editing,
                    onDescriptionChange: (descrip) => _description = descrip,
                    onNameChange: (name) => _name = name,
                    state: _stepStates[0],
                    subTitle:
                        _stepStates[0] == StepState.error ? _errMsg : null,
                    title: 'Give event name and description',
                  ).build(context),
                  StartAndDueDateStep(
                    isActive: _stepStates[1] == StepState.error ||
                        _stepStates[1] == StepState.editing,
                    onDueChanged: (due) => _dueDate = due,
                    onStartChanged: (start) => _startDate = start,
                    state: _stepStates[1],
                    subTitle:
                        _stepStates[1] == StepState.error ? _errMsg : null,
                    title: 'Choose start and sue date',
                  ).build(context),
                  RepeatModeStep(
                    isActive: _stepStates[2] == StepState.error ||
                        _stepStates[2] == StepState.editing,
                    onChanged: (rep) => _repeatMode = rep,
                    state: _stepStates[2],
                    title: 'Choose recurrence',
                  ).build(context),
                ],
              )
            : BlocConsumer<CalenderBloc, CalenderState>(
                listener: (ctx, state) {
                  if (state is CalenderEventSubmitSuccess) {
                    BlocProvider.of<CalenderBloc>(context)
                        .add(GetCalenderEvents());
                    Future.delayed(
                      Duration(milliseconds: 500),
                      () => Navigator.of(ctx).pop(),
                    );
                  }
                },
                builder: (ctx, state) {
                  if (state is CalenderEventSubmitInProgress)
                    return Container(
                      height: mqd.size.width * 0.1,
                      width: mqd.size.width * 0.1,
                      child: AspectRatio(
                        child: CircularProgressIndicator(),
                        aspectRatio: 1,
                      ),
                    );
                  if (state is CalenderError)
                    return FlatButton(
                      onPressed: onStepContinue,
                      child: Text(
                        '${state.errMsg}\nTap To Retry',
                        textAlign: TextAlign.center,
                      ),
                    );
                  return Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: mqd.size.width * 0.1,
                  );
                },
              ),
      ),
    );
  }
}

class NameAndDescriptionStep {
  final bool isActive;
  final String title;
  final String subTitle;
  final StepState state;
  final OnValueChanged<String> onNameChange;
  final OnValueChanged<String> onDescriptionChange;

  NameAndDescriptionStep(
      {this.onDescriptionChange,
      this.onNameChange,
      this.subTitle,
      this.isActive,
      this.state,
      this.title});
  Step build(BuildContext context) {
    return Step(
      title: Text(title),
      isActive: isActive,
      state: state,
      subtitle: (subTitle != null)
          ? Text(
              subTitle,
              style: Theme.of(context).primaryTextTheme.subtitle2,
            )
          : null,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextField(
            onChanged: onNameChange,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Tap to input a name',
            ),
          ),
          TextField(
            onChanged: onDescriptionChange,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Tap to input a decription',
            ),
          ),
        ],
      ),
    );
  }
}

class StartAndDueDateStep {
  final bool isActive;
  final String title;
  final String subTitle;
  final StepState state;
  final OnValueChanged<DateTime> onStartChanged;
  final OnValueChanged<DateTime> onDueChanged;

  StartAndDueDateStep(
      {this.onStartChanged,
      this.onDueChanged,
      this.subTitle,
      this.isActive,
      this.state,
      this.title});
  Step build(BuildContext context) {
    return Step(
      title: Text(title),
      isActive: isActive,
      state: state,
      subtitle: (subTitle != null)
          ? Text(
              subTitle,
              style: Theme.of(context).primaryTextTheme.subtitle2,
            )
          : null,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Start date : '),
              CalendarDatePicker(
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 1500)),
                onDateChanged: onStartChanged,
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('End date : '),
              CalendarDatePicker(
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 1500)),
                onDateChanged: onDueChanged,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class RepeatModeStep {
  final bool isActive;
  final String title;
  final StepState state;
  final OnValueChanged<RepeatMode> onChanged;

  RepeatModeStep({
    this.onChanged,
    this.isActive,
    this.state,
    this.title,
  });
  Step build(BuildContext context) {
    return Step(
        title: Text(title),
        isActive: isActive,
        state: state,
        content: Center(
          child: DropdownButton<RepeatMode>(
            items: RepeatMode.values
                .map<DropdownMenuItem<RepeatMode>>(
                  (e) => DropdownMenuItem<RepeatMode>(
                    child: Text(e.toString().replaceAll(
                          'RepeatMode.',
                          '',
                        )),
                    value: e,
                  ),
                )
                .toList(),
            onChanged: onChanged,
          ),
        ));
  }
}

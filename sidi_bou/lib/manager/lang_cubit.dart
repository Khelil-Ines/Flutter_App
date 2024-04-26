import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class LangState {}

class LangInitial extends LangState {}

class LangLoaded extends LangState {}

class LangCubit extends Cubit<LangState> {
  LangCubit() : super(LangInitial());
}

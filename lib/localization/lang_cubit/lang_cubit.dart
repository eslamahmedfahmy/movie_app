import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/localization/lang_cubit/lang_states.dart';
import 'package:movie_app/localization/lang_cubit/save_lang.dart';


class LanaguageCubit extends Cubit<LanguagesStates>{
  LanaguageCubit() : super(InitalLanguageState());

  static LanaguageCubit get(context)=>BlocProvider.of(context);

  Future<void>getSavedLanguage()async{
    final String cachedLanguageCode=await LanguagesCacheHelper().getCachedLanguageCode();
    emit(ChangeLanguageState(locale: Locale(cachedLanguageCode)));
  }

  Future<void>changeLanguage(String languageCode)async{
    await LanguagesCacheHelper().cacheLanguageCode(languageCode);
    emit(ChangeLanguageState(locale: Locale(languageCode)));
  }

}
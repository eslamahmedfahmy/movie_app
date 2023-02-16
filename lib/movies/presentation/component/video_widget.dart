import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/services/service_locator.dart';
import 'package:movie_app/movies/domain/useCase/get_movie_video_usecase.dart';
import 'package:movie_app/movies/presentation/controller/video_cubit/video_cubit.dart';
import 'package:movie_app/movies/presentation/controller/video_cubit/video_states.dart';

class VideoWidget extends StatelessWidget {
  final VideoParameters videoParameters;
  VideoWidget({Key? key,required this.videoParameters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>VideoCubit(sl(),)..getVideoData(videoParameters),

      child: BlocConsumer<VideoCubit,VideoStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit=VideoCubit.get(context);
          return Scaffold(
            body: TextButton(
              onPressed: (){
                cubit.getVideoData(videoParameters);
              },
              child: Text("Watch Trailer"),
            ),
          );
        },
      ),
    );
  }
}
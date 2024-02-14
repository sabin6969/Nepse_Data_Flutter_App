import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nepse_data_app/pages/home/bloc/home_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    context.read<HomeBloc>().add(HomeLoadDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Nepse Market",
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Colors.white,
              ),
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HomeLoadedState) {
            return RefreshIndicator(
              onRefresh: () {
                context.read<HomeBloc>().add(HomeLoadDataEvent());
                return Future(() => null);
              },
              child: Scrollbar(
                thickness: 5.sp,
                interactive: true,
                trackVisibility: true,
                child: ListView.builder(
                  itemCount: state.companiesModel.data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        state.companiesModel.data[index].company.name,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      subtitle: Text(
                        "Rs ${state.companiesModel.data[index].price.close.toString()}",
                      ),
                      tileColor:
                          state.companiesModel.data[index].price.diff! < 0
                              ? Colors.red
                              : Colors.green,
                    );
                  },
                ),
              ),
            );
          } else if (state is HomeErrorState) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const Center(
              child: Text("Khai k vayo"),
            );
          }
        },
      ),
    );
  }
}

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
    Size size = MediaQuery.sizeOf(context);
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
                    return _compayDetailWidget(
                      companyName:
                          state.companiesModel.data[index].company.name,
                      ltp: state.companiesModel.data[index].price.close ?? 0,
                      isNegativeClosing: true,
                      previousClose:
                          state.companiesModel.data[index].price.prevClose ?? 0,
                    );
                  },
                ),
              ),
            );
          } else if (state is HomeErrorState) {
            return SizedBox(
              height: size.height,
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<HomeBloc>().add(HomeLoadDataEvent());
                    },
                    child: const Text("Reload"),
                  )
                ],
              ),
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

  Widget _compayDetailWidget({
    required String companyName,
    required num ltp,
    required num previousClose,
    required bool isNegativeClosing,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
      child: InkWell(
        child: Ink(
          decoration: BoxDecoration(
            color: ltp < previousClose
                ? Colors.red
                : ltp == previousClose
                    ? Colors.grey
                    : Colors.green,
            borderRadius: BorderRadius.circular(
              8.sp,
            ),
          ),
          height: 80.h,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 10.h,
            ),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Text(
                  companyName,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  "Previous close Rs $previousClose",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Colors.white,
                      ),
                ),
                Text(
                  "Last traded price Rs $ltp",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

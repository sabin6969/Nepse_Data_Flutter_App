import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepse_data_app/constants/api_string.dart';
import 'package:nepse_data_app/models/companies.dart';
import 'package:nepse_data_app/repository/stocks_details_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final StockDetailsRepository _stockDetailsRepository =
      StockDetailsRepository();

  HomeBloc() : super(HomeInitial()) {
    on<HomeLoadDataEvent>(loadStockData);
  }

  loadStockData(HomeLoadDataEvent event, Emitter<HomeState> emit) async {
    try {
      emit(HomeLoadingState());
      CompaniesModel data = await _stockDetailsRepository.getAllStocksDetails(
          "${ApiString.baseUrl}${ApiString.companyWiseData}");
      emit(HomeLoadedState(companiesModel: data));
    } on TimeoutException catch (e) {
      emit(HomeErrorState(message: e.toString()));
    } on HandshakeException catch (e) {
      emit(HomeErrorState(message: e.toString()));
    } catch (e) {
      emit(HomeErrorState(message: e.toString()));
    }
  }
}

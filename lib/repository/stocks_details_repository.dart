import 'package:nepse_data_app/services/stock_details_service.dart';

class StockDetailsRepository {
  StockDetailsService stockDetailsService = StockDetailsService();
  dynamic getAllStocksDetails(String url) async {
    return await stockDetailsService.getAllStockDetails(url);
  }
}

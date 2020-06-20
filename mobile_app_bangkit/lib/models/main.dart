import 'package:scoped_model/scoped_model.dart';

import './connected_products.dart';
// import './user.dart';
// import './product.dart';

class MainModel extends Model with ConnectedProductsModel, ProductsModel, UserModel,UtilityModel {
}

import 'dart:convert';
import 'dart:async';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import './user.dart';
import './product.dart';

class ConnectedProductsModel extends Model {
  List<Product> _products = [];
  User _authenticatedUser;
  Product myProduct;
  bool isSaved;
  Map<String, String> hasilPrediksi;
}

mixin ProductsModel on ConnectedProductsModel {
  List<Product> get allProducts {
    return List.from(_products);
  }

  Future<Map<String, dynamic>> addProduct(
      String imagePath, String prediction) async {
    notifyListeners();
    String tempToken = _authenticatedUser.token;
    bool tempIsSaved = false;
    isSaved = tempIsSaved;
    String tempPrediction = null;
    String tempLabel = null;
    Map<String, dynamic> result = {'prediction': null, 'label': null};
    final Map<String, dynamic> productData = {
      "image_path": imagePath,
      "prediction": int.parse(prediction)
    };
    print(productData);
    try {
      print("masuk1");
      final http.Response response = await http.post(
        'https://padi-bangkit.herokuapp.com/prediction',
        body: utf8.encode(json.encode(productData)),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $tempToken',
          'Accept': '*/*',
          'Accept-Encoding': 'gzip, deflate, br',
        },
      );
      // print("masuk2");
      print(response.headers);
      if (response.statusCode != 200 && response.statusCode != 201) {
        print('masuk ke error');
        // _isLoading = false;
        print(response.statusCode);
        isSaved = tempIsSaved;
        notifyListeners();
        return result;
      }
      // print("masuk4");
      final Map<String, dynamic> responseData = json.decode(response.body);
      // print("masuk5");
      print(responseData);
      Product newProduct = new Product(
        prediction: responseData['data']['Prediction'],
        label: responseData['data']['Label'],
        imagePath: responseData['data']['ImagePath'],
        userID: responseData['data']['UserID'],
        updatedAt: responseData['data']['UpdatedAt'],
      );
      // print(responseData);
      _products.add(newProduct);

      isSaved = true;
      print(isSaved);
      result = {'prediction': tempPrediction, 'label': tempLabel};
      // _isLoading = false;
      notifyListeners();
      return result;
    } catch (error) {
      // _isLoading = false;
      notifyListeners();
      return result;
    }

    // notifyListeners();
    // .catchError((error) {
    //   _isLoading = false;
    //   notifyListeners();
    //   return false;
    // });
    // return result;
  }

  Future<Null> fetchProducts() {
    // _isLoading = true;

    notifyListeners();
    String tempToken = _authenticatedUser.token;

    return http.get(
      'https://padi-bangkit.herokuapp.com/prediction',
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer $tempToken',
        'Accept': '*/*',
        'Accept-Encoding': 'gzip, deflate, br',
      },
    ).then<Null>((http.Response response) {
      final List<Product> fetchedProductList = [];
      final Map<String, dynamic> productListData = json.decode(response.body);
      // print(productListData);
      if (productListData == null) {
        // _isLoading = false;
        notifyListeners();
        return;
      }
      // productListData['data'].forEach((String productId, dynamic productData) {
      //   final Product product = Product(
      //     prediction: productData['Prediction'],
      //     label: productData['Label'],
      //     imagePath: productData['ImagePath'],
      //     userID: productData['UserID'],
      //     updatedAt: productData['UpdatedAt'],
      //   );
      //   fetchedProductList.add(product);
      // });

      productListData['data'].asMap().forEach((index, value) {
        final Product product = Product(
          prediction: value['Prediction'],
          label: value['Label'],
          imagePath: value['ImagePath'],
          userID: value['UserID'],
          updatedAt: value['UpdatedAt'],
        );
        fetchedProductList.add(product);
      });

      _products = fetchedProductList;
      // print(_products.length);
      // _isLoading = false;
      notifyListeners();
      // _selProductId = null;
    }).catchError((error) {
      // _isLoading = false;
      notifyListeners();
      return;
    });
  }

  Future<Null> getPrediction(String label) {
    print('hahhahaa');
    // _isLoading = true;
    // Map<String,dynamic> result;
    label = (int.parse(label)+1).toString();
    notifyListeners();
    String tempToken = _authenticatedUser.token;
    // print('Bearer $tempToken');
    return http.get(
      'https://padi-bangkit.herokuapp.com/condition/${label}',
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer $tempToken',
        'Accept': "*/*",
        'Accept-Encoding': "gzip, deflate, br"
      },
    ).then<Null>((http.Response response) {
      final Map<String, dynamic> responData = json.decode(response.body);
      // print(responData);
      hasilPrediksi = {
        "label": responData['data']['label'],
        'description': responData['data']['description'],
        'effect': responData['data']['effect'],
        'solution': responData['data']['solution'],
        'prevention': responData['data']['prevention']
      };
      print('hayooo');
      print(hasilPrediksi);
      // _isLoading = false;
      notifyListeners();
      // return result;
      // _selProductId = null;
    }).catchError((error) {
      // _isLoading = false;
      notifyListeners();
      // return null;
    });
  }
}

mixin UserModel on ConnectedProductsModel {
  User get user {
    return _authenticatedUser;
  }

  Future<Map<String, dynamic>> authenticate(String email, String password,
      [String mode = "Login"]) async {
    notifyListeners();
    final Map<String, dynamic> authData = {
      'username': email,
      'password': password,
    };

    http.Response response;
    if (mode == "Login") {
      response = await http.post(
        'https://padi-bangkit.herokuapp.com/login',
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
      );
    } else {
      response = await http.post(
        'https://padi-bangkit.herokuapp.com/register',
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'},
      );
    }

    final Map<String, dynamic> responseData = json.decode(response.body);
    // print(responseData['message']);

    // User Existed! dan Success -- signup
    // User not found! dan Success -- login access_token

    bool hasError = true;
    String message = 'Something went wrong.';
    // print(responseData);
    if (responseData['message'] == 'Success' && mode == 'Login') {
      hasError = false;
      message = 'Authentication succeeded!';
      _authenticatedUser = User(
          id: email,
          password: password,
          token: responseData['data']['access_token']);
      print(_authenticatedUser.token);
      // setAuthTimeout(int.parse(responseData['expiresIn']));
      // _userSubject.add(true);
      // final DateTime now = DateTime.now();
      // final DateTime expiryTime =
      //     now.add(Duration(seconds: int.parse(responseData['expiresIn'])));
      // final SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString('token', responseData['idToken']);
      // prefs.setString('userEmail', email);
      // prefs.setString('userId', responseData['localId']);
      // prefs.setString('expiryTime', expiryTime.toIso8601String());
    } else if (responseData['message'] == 'User Existed!') {
      message = 'This user already exists.';
    } else if (responseData['message'] == 'User not found!') {
      message = 'This user was not found.';
    } else if (responseData['message'] == 'Success' && mode == 'Signup') {
      hasError = false;
      message = 'Authentication succeeded!';
    }
    // _isLoading = false;
    Map<String, dynamic> result = {'success': !hasError, 'message': message};
    // print(result)
    notifyListeners();
    return result;
    // return {'success': !hasError, 'message': message};
    // return null;
  }
}

class UtilityModel extends ConnectedProductsModel {
  Map<String, dynamic> get Prediction {
    return hasilPrediksi;
  }

  bool get getIsSaved {
    return isSaved;
  }
}

import 'package:flutter/material.dart';
import 'services/api_service.dart';
import 'models/product.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductListScreen(),
    );
  }
}

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = ApiService().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 118, 193, 255),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      body: FutureBuilder<List<Product>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No products found'));
          } else {
            final products = snapshot.data!;
            return ListView.separated(
              padding: EdgeInsets.all(10),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  tileColor: Color.fromARGB(255, 191, 217, 218),
                  leading: Image.network(
                    product.image,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(product.title),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailScreen(product: product),
                      ),
                    );
                  },
                );
              },
              separatorBuilder: (context, index) => const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
            );
          }
        },
      ),

      // NavigationBar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 255, 164, 210),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 15, 57, 121),
              ),
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 102, 196, 233),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                accountName: Text(
                  "Ali Saeedi",
                  style: TextStyle(fontSize: 18),
                ),
                accountEmail: Text("1380as1380@gmail.com"),
                currentAccountPictureSize: Size.square(40),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 165, 255, 137),
                  child: Text(
                    "A",
                    style: TextStyle(
                        fontSize: 30.0,
                        color: Color.fromARGB(255, 15, 57, 121)),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.person,
                color: Color.fromARGB(255, 17, 75, 122),
              ),
              title: const Text(' My Profile '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ProductDetailScreen
class ProductDetailScreen extends StatelessWidget {
  final Product product;

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 80, 223, 241),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(
              product.image,
              width: double.infinity,
              height: 200,
              fit: BoxFit.fill,
            ),
            SizedBox(height: 16.0),
            Text('Categori: '),
            Text(
              product.category,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text('Content: '),
            SizedBox(height: 8.0),
            Expanded(
                child: Text(
              product.content,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            )),
          ],
        ),
      ),
    );
  }
}

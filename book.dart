import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class Buku {
  String? kode;
  String? cover;
  String? judul;
  String? penulis;
  
  Buku(
    {
      this.kode,
      this.cover,
      this.judul,
      this.penulis,
    }
  );
}

class DataProvider with ChangeNotifier {
  final _data = Buku();
  final _list = <Buku>[];
  
  Buku get data => _data;
  List<Buku> get list => _list;
  
  void emptyData() {
    _data.kode = null;
    _data.cover = null;
    _data.judul = null;
    _data.penulis = null;
  }
  
  void addToList() {
    _list.add(Buku(
      kode: _data.kode,
      cover: _data.cover,
      judul: _data.judul,
      penulis: _data.penulis,
    ));
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataProvider(),
      child: MaterialApp(
        theme: ThemeData.light(),
        debugShowCheckedModeBanner: false,
        home: MyWidget(),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Buku'),
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(child: Text('Tambah Data'),),
              const PopupMenuItem(child: Text('Exit'),),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: provider.list.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(
              'https://corsproxy.io/?'
              '${provider.list[index].cover!}'
            ),
            title: Text(provider.list[index].judul!),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Kode: ${provider.list[index].kode!}'),
                Text('Penulis: ${provider.list[index].penulis!}')
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          showModalBottomSheet(
            context: context,
            isDismissible: true,
            builder: (context) => Center(
              child: Form(
                key: _formkey,
                child: SizedBox(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Kode',
                          hintText: 'Masukkan Kode Buku',
                        ),
                        keyboardType: TextInputType.text,
                        onSaved: (value){
                          provider.data.kode = value;
                        }
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Cover',
                          hintText: 'Masukkan Url Cover',
                        ),
                        onSaved: (value){
                          provider.data.cover = value;
                        }
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Judul',
                          hintText: 'Masukkan Judul Buku',
                        ),
                        onSaved: (value){
                          provider.data.judul = value;
                        }
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Penulis',
                          hintText: 'Masukkan Penulis Buku',
                        ),
                        onSaved: (value){
                          provider.data.penulis = value;
                        }
                      ),
                      ElevatedButton(
                        child: const Center(
                          child: Text('Tambah')
                        ),
                        onPressed: (){
                          if (_formkey.currentState!.validate()) {
                            _formkey.currentState?.save();
                            provider.addToList();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyWidget(),
                              )
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

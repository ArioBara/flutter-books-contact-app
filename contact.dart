import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Contact {
  String? name;
  String? photo;
  String? phone;
  String? email;
  
  Contact(
    {
      this.name,
      this.photo,
      this.phone,
      this.email,
    }
  );
}

class DataProvider with ChangeNotifier {
  final _data = Contact();
  final _list = <Contact>[];
  
  Contact get data => _data;
  List<Contact> get list => _list;
  
  void emptyData() {
    _data.name = null;
    _data.photo = null;
    _data.phone = null;
    _data.email = null;
  }
  
  void addToList() {
    _list.add(Contact(
      name: _data.name,
      photo: _data.photo,
      phone: _data.phone,
      email: _data.email,
    ));
  }
}

void main() => runApp(ContactApp());

class ContactApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataProvider(),
      child: MaterialApp(
        theme: ThemeData.light(),
        debugShowCheckedModeBanner: false,
        home: ContactPage(),
      ),
    );
  }
}


class ContactPage extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Kontak'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(value: 1, child: Text('Tambah Data')),
              const PopupMenuItem(value: 2, child: Text('About')),
              const PopupMenuItem(child: Text('Exit'),),
            ],
            onSelected: (value) {
              if (value == 1){
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  isDismissible: true,
                  builder: (context) => SizedBox(
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: Form(
                      key: _formkey,
                      child: Container(
                        padding: const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Nama',
                                labelStyle: const TextStyle(color: Colors.green, fontSize: 12),
                                hintText: 'Masukkan Nama',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green),
                                ),
                              ),
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Nama tidak boleh kosong';
                                }
                                return null;
                              },
                              onSaved: (value){
                                provider.data.name = value;
                              }
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Foto',
                                labelStyle: const TextStyle(color: Colors.green, fontSize: 12),
                                hintText: 'Masukkan Url Foto Profil',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green),
                                ),
                              ),
                              keyboardType: TextInputType.url,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Url tidak boleh kosong';
                                }
                                return null;
                              },
                              onSaved: (value){
                                provider.data.photo = value;
                              }
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'No. Hp',
                                labelStyle: const TextStyle(color: Colors.green, fontSize: 12),
                                hintText: 'Masukkan Nomer Handphone',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green),
                                ),
                              ),
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'No Handphone tidak boleh kosong';
                                }
                                return null;
                              },
                              onSaved: (value){
                                provider.data.phone = value;
                              }
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: const TextStyle(color: Colors.green, fontSize: 12),
                                hintText: 'Masukkan Email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green),
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Email tidak boleh kosong';
                                }
                                if (!value.contains(RegExp(r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$'))) {
                                  return 'Email harus mengandung @';
                                }
                                return null;
                              },
                              onSaved: (value){
                                provider.data.email = value;
                              }
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              width: 100,
                              child: ElevatedButton( 
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                ),
                                child: const Text('Tambah'),
                              onPressed: (){
                                if (_formkey.currentState!.validate()) {
                                  _formkey.currentState?.save();
                                  provider.addToList();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ContactPage(),
                                    )
                                  );
                                }
                              },),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
              if (value == 2){
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("Pembuat"),
                    content: const Text("Ario Bara Riski"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Container(
                          color: Colors.green,
                          padding: const EdgeInsets.all(14),
                          child: const Text("OK", style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: provider.list.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(
              'https://corsproxy.io/?'
              '${provider.list[index].photo!}'
            ),
            title: Text(provider.list[index].name!),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('No: ${provider.list[index].phone!}'),
                Text('Email: ${provider.list[index].email!}')
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
        onPressed: (){
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            isDismissible: true,
            builder: (context) => SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: Form(
                key: _formkey,
                child: Container(
                  padding: const EdgeInsets.all(22,),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Nama',
                          labelStyle: const TextStyle(color: Colors.green, fontSize: 12),
                          hintText: 'Masukkan Nama',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                        ),
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Nama tidak boleh kosong';
                          }
                          return null;
                        },
                        onSaved: (value){
                          provider.data.name = value;
                        }
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Foto',
                          labelStyle: const TextStyle(color: Colors.green, fontSize: 12),
                          hintText: 'Masukkan Url Foto Profil',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                        ),
                        keyboardType: TextInputType.url,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Url tidak boleh kosong';
                          }
                          return null;
                        },
                        onSaved: (value){
                          provider.data.photo = value;
                        }
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'No. Hp',
                          labelStyle: const TextStyle(color: Colors.green, fontSize: 12),
                          hintText: 'Masukkan Nomer Handphone',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'No Handphone tidak boleh kosong';
                          }
                          return null;
                        },
                        onSaved: (value){
                          provider.data.phone = value;
                        }
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: const TextStyle(color: Colors.green, fontSize: 12),
                          hintText: 'Masukkan Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Email tidak boleh kosong';
                          }
                          if (!value.contains(RegExp(r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$'))) {
                            return 'Email harus mengandung @';
                          }
                          return null;
                        },
                        onSaved: (value){
                          provider.data.email = value;
                        }
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        width: 100,
                        child: ElevatedButton( 
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: const Text('Tambah'),
                        onPressed: (){
                          if (_formkey.currentState!.validate()) {
                            _formkey.currentState?.save();
                            provider.addToList();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ContactPage(),
                              )
                            );
                          }
                        },),
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

import 'package:flutter/material.dart';
import 'package:flutter_the_rick_and_morty/src/models/personajes.dart';
import 'package:flutter_the_rick_and_morty/src/provider/personajes_provider.dart';
import 'package:flutter_the_rick_and_morty/src/router/routes.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Rick and Morty API',
      routerConfig: router,
    );
  }
}

class PersonajesScreen extends StatelessWidget {
  final personajesProvider = PersonajesProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D0D1A), 
      appBar: AppBar(
        backgroundColor: Color(0xFF1E1E2C),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/logo/imagen.png'),
              radius: 20,
            ),
            SizedBox(width: 10),
            Image.asset(
              'assets/logo/logo_r-a-m.png',
              height: 60,
              width: 120,
              fit: BoxFit.contain,
            ),
          ],
        ),
        centerTitle: false,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: FutureBuilder<List<Personajes>>(
        future: personajesProvider.obtenerPersonajes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/logo/cargapng.png',
                    height: 200,
                    width: 200,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 20),
                  Text('ERROR AL CARGAR DATOS',
                    style: TextStyle(color: Colors.redAccent, fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No se encontraron personajes.',
                  style: TextStyle(color: Colors.white)),
            );
          } else {
            final personajes = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.90,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: personajes.length,
                itemBuilder: (context, index) {
                  final personaje = personajes[index];
                  return GestureDetector(
                    onTap: () {
                      context.push('/personajes/detalle', extra: personaje);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF1E1E2C),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 6,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: Image.network(
                                personaje.image,
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              personaje.name,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.circle,
                                  color: personaje.status == "Alive"
                                      ? Colors.green
                                      : personaje.status == "Dead"
                                          ? Colors.red
                                          : Colors.grey,
                                  size: 10,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  personaje.species,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ); 
                },
              ),
            );
          }
        },
      ),
    );
  }
}

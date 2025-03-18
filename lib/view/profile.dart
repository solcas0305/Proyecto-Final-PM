import 'package:flutter/material.dart';
import 'home.dart';
import 'login.dart';

class PerfilScreen extends StatelessWidget{
  final String nombre; 
  final String apellido; 
  final String correo; 

PerfilScreen({required this.nombre, required this. apellido, required this.correo});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
        title: Text('Perfil'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'editar') {
                // Acción para editar perfil
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'editar',
                child: Text('Editar'),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[300],
              child: Icon(Icons.person, size: 50, color: Colors.grey[600]),
            ),
            SizedBox(height: 10),
            Text(
              '$nombre $apellido',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildInfoField('Primer Nombre:', nombre ),
            _buildInfoField('Apellido:', apellido),
            _buildInfoField('Correo Electrónico:', correo),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () {
                  _confirmarCerrarSesion(context);
                },
                child: Text(
                  'Cerrar Sesión',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoField(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 14, color: Colors.grey)),
          TextField(
            decoration: InputDecoration(
              hintText: value,
              border: UnderlineInputBorder(),
              enabled: false,
            ),
          ),
        ],
      ),
    );
  }
}

void _confirmarCerrarSesion(BuildContext context){
  showDialog(
    context: context, 
    builder: (context){
      return AlertDialog(
        title: Text('Confirmación de cerrado de sesión'),
        content: Text ('¿Está seguro de que desea cerrar sesión?'),
        actions: [
          TextButton(
            onPressed: ()=> Navigator.pop(context),
            child: Text ('Cancelar'),
          ),
          TextButton(
            onPressed: (){
              Navigator.pop(context);
              Navigator.pushReplacement(context, 
              MaterialPageRoute(builder: (context)=> LoginScreen()),
              );
            },
            child: Text ('Sí, cerrar sesión'),
            )
        ]
      );
    }
  );
}






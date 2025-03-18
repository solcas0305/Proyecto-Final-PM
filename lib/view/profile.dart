import 'package:flutter/material.dart';
import 'home.dart';
import 'login.dart';

class PerfilScreen extends StatefulWidget {
  final String nombre;
  final String apellido;
  final String correo;
  final String password;

  PerfilScreen({required this.nombre, required this.apellido, required this.correo, required this.password});

  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  late String nombre;
  late String apellido;
  late String correo;
  late String password;

  @override
  void initState() {
    super.initState();
    nombre = widget.nombre;
    apellido = widget.apellido;
    correo = widget.correo;
    password = widget.password;
  }

  void _editarPerfil() async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditarPerfilScreen(
          nombre: nombre,
          apellido: apellido,
          correo: correo,
          password: password,
        ),
      ),
    );
    if (resultado != null) {
      setState(() {
        nombre = resultado['nombre'];
        apellido = resultado['apellido'];
        correo = resultado['correo'];
        password = resultado['password'];
      });
    }
  }

  void _confirmarCerrarSesion(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirmación de cerrado de sesión'),
          content: Text('¿Está seguro de que desea cerrar sesión?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text('Sí, cerrar sesión'),
            ),
          ],
        );
      },
    );
  }

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
                _editarPerfil();
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
            SizedBox(height: 10),
            _buildInfoField('Primer Nombre:', nombre),
            _buildInfoField('Apellido:', apellido),
            _buildInfoField('Correo Electrónico:', correo),
            _buildInfoField("Password", password),
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
                  style: TextStyle(fontSize: 15, color: Colors.white),
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
          Text(label, style: TextStyle(fontSize: 14, color: Colors.black)),
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

class EditarPerfilScreen extends StatefulWidget {
  final String nombre;
  final String apellido;
  final String correo;
  final String password;

  EditarPerfilScreen({
    required this.nombre,
    required this.apellido,
    required this.correo,
    required this.password,
  });

  @override
  _EditarPerfilScreenState createState() => _EditarPerfilScreenState();
}

class _EditarPerfilScreenState extends State<EditarPerfilScreen> {
  late TextEditingController _nombreController;
  late TextEditingController _apellidoController;
  late TextEditingController _correoController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.nombre);
    _apellidoController = TextEditingController(text: widget.apellido);
    _correoController = TextEditingController(text: widget.correo);
    _passwordController = TextEditingController(text: widget.password);
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidoController.dispose();
    _correoController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Editar Perfil')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _apellidoController,
              decoration: InputDecoration(labelText: 'Apellido'),
            ),
            TextField(
              controller: _correoController,
              decoration: InputDecoration(labelText: 'Correo'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  'nombre': _nombreController.text,
                  'apellido': _apellidoController.text,
                  'correo': _correoController.text,
                  'password': _passwordController.text,
                });
              },
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}

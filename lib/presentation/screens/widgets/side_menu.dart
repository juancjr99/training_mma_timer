import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:training_mma_timer/config/menu/menu_items.dart';

class SideMenu extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const SideMenu({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;
    final theme = Theme.of(context);

    return Drawer(
      
      child: Column(
        children: [
          // Encabezado con la foto y el nombre del usuario
          _buildHeader(theme, hasNotch),

          // Lista de opciones del menú
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ...appMenuItems.sublist(0, 1).map((item) => ListTile(
                      leading: Icon(item.icon, color: theme.colorScheme.primary),
                      title: Text(
                        item.title,
                        style: theme.textTheme.titleSmall,
                      ),
                      onTap: () async{
                        // Espera 200ms antes de cambiar de pantalla
                        await Future.delayed(Duration(milliseconds: 250));
                        context.push(item.link);
                        Navigator.of(context).pop();
                      },
                    )),

                // Separador
                Divider(color: theme.colorScheme.primary),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Método para construir el encabezado con la foto y el nombre
  Widget _buildHeader(ThemeData theme, bool hasNotch) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, hasNotch ? 50 : 40, 20, 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary,
        borderRadius: BorderRadius.only(
          // bottomLeft: Radius.circular(20),
          // bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Foto de perfil
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/images/profile.jpg'), // Cambia por tu imagen
          ),
          const SizedBox(height: 15),
          
          // Nombre y correo
          Row(
            children: [ 
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Juan Carlos", // Cambiar por dato real
                    style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "+53 53061999", // Cambiar por dato real
                    style: theme.textTheme.bodySmall?.copyWith(color: Colors.white70),
                  ),
                ],
              ),

              
            ],
          ),
        ],
      ),
    );
  }
}

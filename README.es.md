<h1 align="center">AnyMove Forever</h1>

<p align="center">
  <b>Mueve y cambia de tamaño cualquier ventana o elemento de la interfaz en World of Warcraft: Forever</b>
</p>

<p align="center">
<a href="https://github.com/Pirson-s-Addons/AnyMoveForever/releases/latest">
<img src="https://img.shields.io/github/v/release/Pirson-s-Addons/AnyMoveForever?style=for-the-badge&color=A78BFA">
</a>
<img src="https://img.shields.io/badge/WoW_Forever-1.60.1-C4B5FD?style=for-the-badge">
<a href="LICENSE">
<img src="https://img.shields.io/badge/License-MIT-E9D5FF?style=for-the-badge">
</a>
</p>

<p align="center">
<a href="README.md">🇬🇧 English</a>
</p>

---

## Qué hace

**AnyMove Forever** te deja mover y cambiar de tamaño las ventanas y los elementos de la interfaz de WoW Forever, en tres categorías:

| Categoría | Qué | Por defecto | Cómo |
|---|---|---|---|
| **Ventanas** | Personaje, hechizos y talentos, profesiones, mapa, bolsas, banco, mercader, correo, subasta, comercio, misiones, amigos, logros, colecciones, calendario, ajustes... | Activadas | Arrástralas directamente |
| **Interfaz** | Widgets superiores, mensajes de error, textos de zona, alertas, botín en grupo, tótems, puntos de combo... | Desactivadas | Modo mover |
| **Modo Edición** | Barras de acción, marcos de unidad, minimapa, chat, barra de bolsas, beneficios, rastreador de misiones... | Desactivadas | Modo mover |

El Modo Edición ya mueve casi todo el HUD, pero no las ventanas: eso es lo que añade este addon. La categoría Modo Edición va desactivada por defecto porque mover esos elementos por fuera del Modo Edición puede chocar con él.

## Funciones

- **Arrastra cualquier ventana** y se queda ahí, aunque el juego la vuelva a abrir.
- **Modo mover**: un recuadro sobre cada elemento activado. Arrastra para mover, **rueda del ratón** para el tamaño (30–250 %), **clic derecho** para restablecer.
- Todo se guarda entre sesiones.
- Los marcos protegidos no se tocan en combate: los cambios esperan a que acabe.
- Una casilla por elemento en **Opciones → AddOns → AnyMove Forever**, y **Restablecer todo**.
- Traducido a todos los idiomas del cliente.

## Instalación

1. Descarga el zip de la [última release](https://github.com/Pirson-s-Addons/AnyMoveForever/releases/latest).
2. Extrae la carpeta `AnyMoveForever` en `World of Warcraft/_classic_beta_/Interface/AddOns/`.
3. Reinicia el juego y activa el addon.

Solo se carga en WoW Forever: su único `.toc` es `AnyMoveForever_Camelot.toc` (`Camelot` es el game type de Forever).

## Comandos

- `/amf` (o `/anymove`) — abre las opciones.
- `/amf move` — activa o desactiva el modo mover (`/amf unlock`, `/amf lock`).
- `/amf reset` — devuelve todo a su posición original.

## Créditos

Inspirado en [MoveAny](https://www.curseforge.com/wow/addons/moveany), de D4KiR. AnyMove Forever está escrito desde cero y no usa nada del código de MoveAny.

---

**Autor**: Pirson · [GitHub](https://github.com/Pirson-s-Addons) · [CurseForge](https://www.curseforge.com/members/pirson/projects) · Licencia MIT

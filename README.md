<h1 align="center">AnyMove Forever</h1>

<p align="center">
  <b>Move and resize any window or interface element in World of Warcraft: Forever</b>
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
<a href="#-español">🇪🇸 Español</a>
</p>

---

## What it does

**AnyMove Forever** lets you move and resize the windows and interface elements of WoW Forever, grouped in three categories:

| Category | What | Default | How |
|---|---|---|---|
| **Windows** | Character, spellbook & talents, professions, map, bags, bank, merchant, mail, auction house, trade, quests, friends, achievements, collections, calendar, settings... | On | Drag them directly |
| **Interface** | Top widgets, error messages, zone texts, alerts, group loot, totems, combo points... | Off | Move mode |
| **Edit Mode** | Action bars, unit frames, minimap, chat, bags bar, buffs, quest tracker... | Off | Move mode |

Edit Mode already moves most of the HUD, but not the windows: that is the part this addon adds. The Edit Mode category is off by default because moving those elements from outside Edit Mode can clash with it.

## Features

- **Drag any window** and it stays there, even when the game reopens it.
- **Move mode**: a box over every enabled element. Drag to move, **mouse wheel** to resize (30–250%), **right-click** to reset.
- Everything is saved between sessions.
- Protected frames are never touched in combat: changes wait until combat ends.
- A checkbox per element in **Options → AddOns → AnyMove Forever**, plus **Reset everything**.
- Translated to every client language.

## Installation

1. Download the zip from the [latest release](https://github.com/Pirson-s-Addons/AnyMoveForever/releases/latest).
2. Extract the `AnyMoveForever` folder into `World of Warcraft/_classic_beta_/Interface/AddOns/`.
3. Restart WoW and enable the addon.

It only loads on WoW Forever: the only TOC is `AnyMoveForever_Camelot.toc` (`Camelot` is Forever's game type).

## Commands

- `/amf` (or `/anymove`) — opens the options.
- `/amf move` — toggles move mode (`/amf unlock`, `/amf lock`).
- `/amf reset` — puts everything back in its default position.

## Credits

Inspired by [MoveAny](https://www.curseforge.com/wow/addons/moveany) by D4KiR. AnyMove Forever is written from scratch and does not use any of MoveAny's code.

---

## 🇪🇸 Español

**AnyMove Forever** te deja mover y cambiar de tamaño las ventanas y los elementos de la interfaz de WoW Forever, en tres categorías:

| Categoría | Qué | Por defecto | Cómo |
|---|---|---|---|
| **Ventanas** | Personaje, hechizos y talentos, profesiones, mapa, bolsas, banco, mercader, correo, subasta, comercio, misiones, amigos, logros, colecciones, calendario, ajustes... | Activadas | Arrástralas directamente |
| **Interfaz** | Widgets superiores, mensajes de error, textos de zona, alertas, botín en grupo, tótems, puntos de combo... | Desactivadas | Modo mover |
| **Modo Edición** | Barras de acción, marcos de unidad, minimapa, chat, barra de bolsas, beneficios, rastreador de misiones... | Desactivadas | Modo mover |

El Modo Edición ya mueve casi todo el HUD, pero no las ventanas: eso es lo que añade este addon. La categoría Modo Edición va desactivada por defecto porque mover esos elementos por fuera del Modo Edición puede chocar con él.

### Funciones

- **Arrastra cualquier ventana** y se queda ahí, aunque el juego la vuelva a abrir.
- **Modo mover**: un recuadro sobre cada elemento activado. Arrastra para mover, **rueda del ratón** para el tamaño (30–250 %), **clic derecho** para restablecer.
- Todo se guarda entre sesiones.
- Los marcos protegidos no se tocan en combate: los cambios esperan a que acabe.
- Una casilla por elemento en **Opciones → AddOns → AnyMove Forever**, y **Restablecer todo**.
- Traducido a todos los idiomas del cliente.

### Instalación

1. Descarga el zip de la [última release](https://github.com/Pirson-s-Addons/AnyMoveForever/releases/latest).
2. Extrae la carpeta `AnyMoveForever` en `World of Warcraft/_classic_beta_/Interface/AddOns/`.
3. Reinicia el juego y activa el addon.

Solo se carga en WoW Forever: su único `.toc` es `AnyMoveForever_Camelot.toc` (`Camelot` es el game type de Forever).

### Comandos

- `/amf` (o `/anymove`) — abre las opciones.
- `/amf move` — activa o desactiva el modo mover (`/amf unlock`, `/amf lock`).
- `/amf reset` — devuelve todo a su posición original.

### Créditos

Inspirado en [MoveAny](https://www.curseforge.com/wow/addons/moveany), de D4KiR. AnyMove Forever está escrito desde cero y no usa nada del código de MoveAny.

---

**Author**: Pirson · [GitHub](https://github.com/Pirson-s-Addons) · [CurseForge](https://www.curseforge.com/members/pirson/projects) · MIT License

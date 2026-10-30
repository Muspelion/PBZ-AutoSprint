# PBZ Auto Sprint

[🇬🇧 English](README.md) · [🇵🇱 Polski](README.pl.md) · [🇫🇷 Français](README.fr.md) · **🇪🇸 Español** · [🇺🇦 Українська](README.uk.md)

Un mod de accesibilidad para **Phantom Blade Zero** (PC) que **mantiene el sprint por ti** mientras corres, y se detiene
solo antes de los enemigos y en combate.

> ♿ **Este mod se creó pensando en las personas con discapacidad motora.** Explorar significa mantener un botón pulsado
> durante minutos. Si te resulta cansado, doloroso o imposible, el mod lo hace por ti: tú solo diriges.

> ⚠️ **Para que el mod funcione se necesita una versión oficial del juego, comprada legalmente.**

Funciona bien junto con [**PBZ Auto Parry & Dodge**](https://github.com/Muspelion/PBZ-AutoParryDodge) y
[**PBZ Auto Weapon Switch**](https://github.com/Muspelion/PBZ-AutoWeaponSwitch). Cada mod se puede instalar por separado.

---

## ✨ Qué hace

- **Esprinta cuando corres**: en el suelo, fuera de combate, salvo si vas en sigilo o caminando. La dirección la eliges tú.
- **Se detiene a 20 m de un enemigo** en tu nivel, para que no entres en un grupo a toda velocidad.
  El sprint vuelve a más de 23 m.
- **Nunca esprinta en combate.**
- Los enemigos en otro nivel (más de 3 m por encima o por debajo) se ignoran.
- **Mensajes en pantalla**: al cargar una partida, al pulsar la tecla y cuando un enemigo detiene el sprint
  (por ejemplo *«Auto Sprint: running - enemy 19 m»*).
- **Tu ajuste se guarda** entre sesiones.
- **El juego no se modifica**: el mod solo añade archivos junto al juego.

El sprint no usa Shachi ni ralentiza su recuperación (medido en el juego: 75 segundos de sprint con el Shachi lleno),
así que el mod no necesita gestionarlo.

### Resultados de las pruebas (versión de Steam)

| Situación | Resultado |
|---|---|
| Correr sin enemigos cerca | Velocidad de sprint completa (750) |
| Correr hacia enemigos | El sprint terminó 4 de 4 veces a 18,8–19,9 m |
| Alejarse de los enemigos | El sprint volvió desde 24 m, sin parpadeo en el límite |
| Combate | Sin sprint durante todo el combate |

## 📋 Requisitos

- Una **copia oficial** de Phantom Blade Zero para PC (Windows 10/11).
  - **Steam**: probado ✅
  - **Epic Games Store**: compatible con el instalador, aún sin probar
  - **GOG**: el juego no está en GOG por ahora; el instalador lo encontrará si aparece
- Conexión a Internet en la primera instalación (el instalador descarga
  [UE4SS](https://github.com/UE4SS-RE/RE-UE4SS), el cargador de mods gratuito, si aún no está instalado).
- El juego es **solo para un jugador** y no tiene antitrampas. Este mod no toca el DRM ni funciones en línea.

## 🚀 Instalación fácil (recomendada)

1. Descarga **`PBZ-AutoSprint-v1.0.0.zip`** desde la página [**Releases**](../../releases/latest).
2. Descomprime el zip en cualquier lugar (por ejemplo, en el Escritorio).
3. **Cierra el juego.**
4. Haz doble clic en **`install.bat`**.
   - Si Windows muestra *«Windows protegió su PC»*, haz clic en **Más información → Ejecutar de todas formas**
     (el instalador es un simple script de texto).
5. Cuando aparezca **Done!**, cierra la ventana.
6. Inicia el juego normalmente. Al cargar una partida verás: `Auto Sprint: ON`

Si el juego no se encuentra automáticamente, el instalador te pedirá la carpeta del juego:
Steam → clic derecho en Phantom Blade Zero → **Administrar → Ver archivos locales**;
Epic → Biblioteca → **⋯ → Administrar → Carpeta de instalación**.

Si ya hay otro mod de PBZ instalado, el instalador conserva su UE4SS y solo añade este mod.

## 🎮 Controles

| Tecla | Acción |
|---|---|
| **F5** | Sprint automático ON / OFF |

El cambio se muestra en pantalla y se guarda automáticamente. Tu propio botón de sprint sigue funcionando con normalidad.

## 🗑️ Desinstalar

Cierra el juego y haz doble clic en **`uninstall.bat`**. Se elimina el mod. UE4SS solo se elimina si lo instaló
este instalador **y** ningún otro mod de PBZ lo sigue usando (se te preguntará antes).

## 🔧 Instalación manual (avanzada)

1. Abre la carpeta del juego que contiene el `PBZ.exe` grande (Steam: `…\steamapps\common\PBZ\platform\steam\`).
2. Si UE4SS aún no está instalado: descarga el último `UE4SS_v…zip` (no `zDEV-…`) de
   [UE4SS experimental-latest](https://github.com/UE4SS-RE/RE-UE4SS/releases/tag/experimental-latest)
   y descomprímelo allí (`dwmapi.dll` y la carpeta `ue4ss` junto a `PBZ.exe`).
3. Copia el contenido de la carpeta `ue4ss-config` de este paquete en la carpeta `ue4ss`.
4. Copia la carpeta `mod\PBZAutoSprint` en `ue4ss\Mods\`.
5. Abre `ue4ss\Mods\mods.txt` y añade la línea `PBZAutoSprint : 1` encima de la línea `Keybinds`.

## ❓ Solución de problemas

- **No aparece ningún mensaje al cargar** → comprueba que `ue4ss\Mods\mods.txt` contiene `PBZAutoSprint : 1`
  y revisa `ue4ss\UE4SS.log`.
- **El personaje no esprinta** → comprueba el mensaje tras pulsar F5 (debe decir ON) y que no haya un enemigo cerca.
  El sprint también está desactivado en sigilo o caminando.
- **El juego no arranca o se cierra al iniciar** → ejecuta `uninstall.bat` (o borra `dwmapi.dll` junto a
  `PBZ.exe`). Una actualización del juego puede requerir una nueva versión del mod.
- **Otro problema** → en `ue4ss\Mods\PBZAutoSprint\Scripts\main.lua` cambia `log = false` por `log = true`,
  juega y adjunta `autosprint.log` en una [incidencia](../../issues).

## ⚙️ Cómo funciona (resumen)

El juego no tiene una función de «empezar a esprintar»: solo lo controla el botón de sprint. Cuando las reglas lo
permiten, el mod pulsa ese botón en cada fotograma mediante el sistema de entrada del juego, como una tecla mantenida.
Diez veces por segundo comprueba tu velocidad, tu estado y la distancia al enemigo más cercano.
El mod es un script Lua para [UE4SS](https://github.com/UE4SS-RE/RE-UE4SS); no incluye archivos del juego.

## 🙏 Créditos

- [UE4SS](https://github.com/UE4SS-RE/RE-UE4SS) (MIT).
- Configuración de UE4SS para Phantom Blade Zero – [KintaroModding](https://github.com/KintaroModding),
  [UE4SS-RE/RE-UE4SS#1484](https://github.com/UE4SS-RE/RE-UE4SS/pull/1484); patrones de firmas del equipo de UE4SS (MIT).
- Creado con ayuda de **Claude Code** (la IA Claude de Anthropic); todos los resultados se probaron en el juego.

## 📄 Licencia y aviso

Código: [licencia MIT](LICENSE). Proyecto no oficial de fans, sin relación con S-GAME.
Phantom Blade Zero es una marca de S-GAME. Úsalo bajo tu responsabilidad: haz copia de tus partidas guardadas.

Historial de versiones: [CHANGELOG](CHANGELOG.md).

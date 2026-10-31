# CLAUDE.md

Guía para Claude Code en este proyecto.

## Método

- Tipo: dev
- Tablero: proyecto GitHub "Keystassi" (owner `davidbp845`, número `13`)
- Verificación (desde PowerShell, en la raíz): `& "C:\Program Files\AutoHotkey\v2\AutoHotkey64.exe" /ErrorStdOut /validate main.ahk` y lo mismo con `recorder\macro-recorder.ahk`; los dos deben salir con código 0. Desde Git Bash el ejecutable no devuelve el código ni la salida.
- Etiquetas de área: las del repo
- Etiquetas de tipo: solo bug
- Límite de In review: 10
- Verificaciones extra:
  - No arrancar `main.ahk` ni el grabador sin avisar: registran atajos de teclado globales en la máquina del usuario. `/validate` comprueba la sintaxis sin ejecutar.
  - `config.ini`, `includes.ahk` y `plugins/` (salvo `plugins/google/login.ahk`) son locales y no se versionan; un cambio en el formato de `config.ini` va también a `config-sample.ini`.

## Qué es

Keystassi: menú navegable por teclado (AutoHotkey v2) que lanza flujos de pasos sobre otras aplicaciones, con un HUD y atajos configurables en `config.ini`. `recorder/` es una copia modificada de AHK Macro Recorder.

## Idioma y comentarios

- Documentación, commits e issues en español; el código mantiene el idioma que ya tiene.
- Los comentarios explican el *porqué* actual, no la historia de cómo se llegó ahí.

## Comandos

Comandos de Claude Code: `/dev:ayuda`. Ciclo de issues: los `/dev:*` del método común, con los datos de `## Método`.

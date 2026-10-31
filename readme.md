# Keystassi

Menú navegable por teclado, hecho en AutoHotkey v2, que lanza flujos de pasos sobre otras aplicaciones. Muestra un HUD con el nodo actual y los atajos se configuran en `config.ini`.

## Requisitos

- Windows con [AutoHotkey v2](https://www.autohotkey.com/).

## Arranque

1. Copiar `config-sample.ini` a `config.ini` (no se versiona).
2. Ejecutar `main.ahk`.

Si falta `config.ini`, el script avisa y se cierra.

## Atajos por defecto

| Acción | Tecla |
| --- | --- |
| Activar o desactivar el menú | `F1` |
| Salir | `F3` |
| Moverse | `w` `a` `s` `d` |
| Ejecutar el paso | `Enter` |

Se cambian en la sección `[hotkeys]` de `config.ini`. El árbol del menú se define con secciones `[node:...]`.

## Grabador

`recorder/` es una copia modificada de AHK Macro Recorder; ver `recorder/README.md`.

# Instrucciones globales de Claude Code

## Usuario

- Nombre: Oscar Bueno
- GitHub: OBueno2785 (oscar.bueno2785@gmail.com)
- Idioma de trabajo: español — responder siempre en español salvo que el código o la pregunta sea en otro idioma

## Comportamiento general

- Respuestas cortas y directas; sin relleno ni explicaciones innecesarias
- No agregar comentarios al código salvo que el motivo no sea obvio
- No crear archivos README ni documentación salvo que se pida explícitamente
- Preferir editar archivos existentes antes de crear nuevos
- No introducir abstracciones, refactorizaciones ni features no solicitadas

## Publicación de proyectos

Al finalizar un proyecto o una fase importante de desarrollo, DEBE subirse el código completo a GitHub.

Pasos obligatorios:
1. `git init -b main` (si el proyecto no tiene git)
2. `git add -A` y commit descriptivo
3. `gh repo create <nombre> --public --source=. --remote=origin --push`

Usar el CLI de GitHub: `gh` (ruta en Windows: `C:\Program Files\GitHub CLI\gh.exe`).

## Seguridad

- Nunca usar `--no-verify` ni saltarse hooks de git
- No hacer `git push --force` a main/master
- Confirmar antes de ejecutar operaciones destructivas (borrar archivos, reset --hard, etc.)
- No exponer credenciales, tokens ni archivos `.env` en commits

## Herramientas preferidas

- Gestor de paquetes JS: pnpm (monorepos), npm (proyectos simples)
- Python: usar `venv` para entornos virtuales
- Formateo: confiar en las herramientas del proyecto (eslint, prettier, black), no corregir estilo manualmente

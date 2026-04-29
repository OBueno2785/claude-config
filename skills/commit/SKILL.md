---
name: commit
description: Hace stage y commit de los cambios actuales con un mensaje semántico bien redactado.
disable-model-invocation: true
allowed-tools: Bash(git add *) Bash(git commit *) Bash(git status *) Bash(git diff *)
---

Crea un commit con los cambios actuales:

1. Ejecutar `git status` y `git diff --staged` para entender qué cambió.
2. Si no hay nada en stage, ejecutar `git add -A`.
3. Redactar un mensaje semántico en inglés:
   - Prefijo: `feat:`, `fix:`, `refactor:`, `docs:`, `test:`, `chore:`
   - Primera línea ≤ 72 caracteres, modo imperativo ("add", "fix", "remove")
   - Si hay contexto relevante, agregar cuerpo breve tras línea en blanco
4. Ejecutar el commit.
5. Mostrar el hash corto y el mensaje del commit creado.

Nunca usar `--no-verify`. No modificar commits previos con `--amend` salvo que se pida explícitamente.

---
name: github-push
description: Sube el proyecto actual a GitHub. Usa cuando el usuario pide exportar, publicar o subir el proyecto a GitHub.
disable-model-invocation: true
allowed-tools: Bash(git *) Bash(gh *)
argument-hint: [nombre-repo] [public|private]
---

Sube el proyecto actual a GitHub bajo la cuenta OBueno2785.

Pasos:
1. Detectar si ya existe un repositorio git (`git status`). Si no, ejecutar `git init -b main`.
2. Verificar si ya hay un remote configurado (`git remote -v`). Si existe, hacer solo `git push`.
3. Si no hay remote:
   - `git add -A`
   - `git commit -m "<descripción del proyecto>"` (mensaje en inglés, conciso)
   - `"/c/Program Files/GitHub CLI/gh.exe" repo create $ARGUMENTS --source=. --remote=origin --push`
   - Si no se pasa argumento, usar el nombre del directorio actual como nombre del repo.
   - Si no se especifica visibilidad, usar `--public`.
4. Confirmar con la URL del repositorio creado.

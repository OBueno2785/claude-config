---
name: changelog
description: Genera un changelog legible a partir del historial de git. Usar cuando se pide "qué cambió", "genera changelog" o antes de hacer un release.
disable-model-invocation: true
allowed-tools: Bash(git log *) Bash(git tag *)
argument-hint: [desde-tag o número de commits]
---

Genera el changelog:

1. Obtener los commits relevantes:
   - Si se pasa un tag en $ARGUMENTS: `git log <tag>..HEAD --oneline`
   - Si se pasa un número: `git log -<N> --oneline`
   - Si no se pasa nada: `git log $(git describe --tags --abbrev=0 2>/dev/null || git rev-list --max-parents=0 HEAD)..HEAD --oneline`

2. Agrupar los commits por tipo semántico:
   - 🚀 **Nuevas features** (`feat:`)
   - 🐛 **Bug fixes** (`fix:`)
   - ⚡ **Mejoras** (`refactor:`, `perf:`)
   - 🧪 **Tests** (`test:`)
   - 🔧 **Infraestructura** (`chore:`, `ci:`, `build:`)
   - 📝 **Documentación** (`docs:`)

3. Mostrar el changelog en español, ordenado de más a menos relevante.
   Formato: `- <descripción> (<hash corto>)`

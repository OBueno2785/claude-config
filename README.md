# claude-config

Configuración global de Claude Code: CLAUDE.md y librería de skills personalizadas.

## Instalación

**Unix / Mac / WSL:**
```bash
git clone https://github.com/OBueno2785/claude-config.git
cd claude-config
bash install.sh
```

**Windows (PowerShell):**
```powershell
git clone https://github.com/OBueno2785/claude-config.git
cd claude-config
powershell -ExecutionPolicy Bypass -File install.ps1
```

## Skills disponibles

| Skill | Invocación | Descripción |
|---|---|---|
| `/github-push` | Manual | Sube el proyecto a GitHub (OBueno2785) |
| `/commit` | Manual | Commit semántico bien redactado |
| `/changelog` | Manual | Changelog desde historial git |
| `/deploy` | Manual | Checklist pre-deploy |
| `/review` | Auto/Manual | Revisión de código con severidad |
| `/refactor` | Auto/Manual | Refactorización sin cambiar comportamiento |
| `/fix-bug` | Auto/Manual | Diagnóstico y corrección de bugs |
| `/perf` | Auto/Manual | Análisis de rendimiento |
| `/scaffold` | Auto/Manual | Scaffold completo de feature |
| `/new-component` | Auto/Manual | Componente UI con test |
| `/api-route` | Auto/Manual | Endpoint REST con validación |
| `/test-gen` | Auto/Manual | Generación de tests |
| `/new-project` | Manual | Proyecto nuevo con git |
| `/db-migrate` | Auto/Manual | Validar migración de base de datos |
| `/deps` | Manual | Auditar dependencias y vulnerabilidades |
| `/docgen` | Auto/Manual | Generar JSDoc / docstrings |
| `/explain` | Auto/Manual | Explicar código con diagramas |
| `/pr-description` | Auto/Manual | Descripción para pull requests |

---
name: scaffold
description: Genera el scaffold completo de una feature o módulo: rutas, controlador, servicio, modelo y tests. Usar cuando se pide "crea el módulo de X", "scaffold de feature" o "genera la estructura de Y".
argument-hint: [nombre-feature] [descripción]
---

Genera el scaffold completo para: $ARGUMENTS

1. **Analizar el proyecto** para entender su arquitectura:
   - ¿Usa arquitectura en capas (routes → controller → service → model)?
   - ¿Monorepo con paquetes separados?
   - Leer 1 feature existente completa para replicar el patrón exacto

2. **Generar los archivos** según el patrón detectado. Ejemplo típico:
   ```
   feature/
   ├── [feature].routes.ts      # Definición de rutas/endpoints
   ├── [feature].controller.ts  # Manejo de request/response
   ├── [feature].service.ts     # Lógica de negocio
   ├── [feature].model.ts       # Schema/modelo de datos
   ├── [feature].types.ts       # Tipos e interfaces
   └── __tests__/
       └── [feature].test.ts    # Tests del servicio
   ```

3. **Conectar** la nueva feature al entry point principal (router, app.py, index.ts)

4. **Mostrar** lista de archivos creados y cómo invocar el primer endpoint/función

Adaptar la estructura al framework detectado (FastAPI, Express, Next.js App Router, etc.).

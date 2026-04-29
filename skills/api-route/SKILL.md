---
name: api-route
description: Crea un endpoint o ruta de API completo con validación y manejo de errores. Usar cuando se pide "crear endpoint", "agregar ruta" o "nueva API".
argument-hint: [METHOD /ruta - descripción]
---

Crea el endpoint: $ARGUMENTS

1. **Detectar el framework** del proyecto (FastAPI, Express, Next.js API Routes, Hono, etc.)
2. **Leer rutas existentes** para seguir el patrón del proyecto
3. **Implementar el endpoint** con:
   - Validación de inputs (tipos, campos requeridos)
   - Lógica de negocio separada del handler
   - Respuestas con status codes correctos (200, 201, 400, 404, 500)
   - Manejo de errores con mensajes claros
4. **Colocar en el archivo correcto** según la estructura del proyecto

Convenciones:
- Nombres de rutas en kebab-case
- Respuestas JSON consistentes: `{ data, error, message }`
- No hardcodear credenciales ni URLs de entorno

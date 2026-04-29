---
name: test-gen
description: Genera tests para una función, módulo o archivo. Usa cuando el usuario pide "escribe tests", "agrega tests" o "crea pruebas".
argument-hint: [archivo o función]
---

Genera tests para $ARGUMENTS:

1. Leer el archivo objetivo para entender las firmas, tipos y comportamiento.
2. Identificar el framework de tests del proyecto (Jest, Vitest, Pytest, etc.) leyendo `package.json` o archivos de configuración.
3. Leer 1-2 tests existentes para seguir el estilo del proyecto.
4. Generar tests que cubran:
   - **Happy path** — el caso de uso principal con inputs válidos
   - **Edge cases** — valores vacíos, null, límites de rango
   - **Errores** — inputs inválidos, excepciones esperadas
   - **Async** — si aplica, promesas rechazadas y resueltas
5. Colocar los tests en el directorio correcto siguiendo la convención del proyecto.

No mockear dependencias internas salvo que sean I/O externo (red, base de datos, sistema de archivos).

---
name: new-component
description: Crea un nuevo componente UI siguiendo las convenciones del proyecto. Usar cuando se pide "crea un componente", "nuevo componente" o "agrega un componente".
argument-hint: [NombreComponente] [descripción opcional]
---

Crea el componente: $ARGUMENTS

1. **Detectar el framework y convenciones** del proyecto:
   - Leer 2-3 componentes existentes para seguir el estilo (hooks, props tipadas, exports)
   - Identificar si usa Tailwind, CSS Modules, styled-components u otro
   - Verificar si hay un directorio estándar (`components/`, `src/components/`, `features/`)

2. **Crear el componente** con:
   - Props tipadas con TypeScript (o PropTypes si es JS)
   - Nombre en PascalCase, archivo en el mismo formato
   - Exportación nombrada (no default export salvo que el proyecto lo use así)
   - Solo lógica de UI — sin llamadas directas a APIs ni lógica de negocio

3. **Crear test básico** en el directorio de tests correspondiente:
   - Render test (que monte sin errores)
   - Test del caso de uso principal

4. **Mostrar** la ruta del archivo creado y un ejemplo de uso.

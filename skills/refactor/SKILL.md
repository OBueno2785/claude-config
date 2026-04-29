---
name: refactor
description: Refactoriza código para mejorar legibilidad, reducir duplicación y simplificar lógica, sin cambiar el comportamiento externo.
argument-hint: [archivo o función a refactorizar]
---

Refactoriza: $ARGUMENTS

Reglas estrictas:
- **Cero cambios de comportamiento** — el código debe hacer exactamente lo mismo antes y después
- **Mínimo scope** — solo refactorizar lo indicado, no el código circundante
- No agregar features ni manejo de errores extra

Checklist de refactorización:

1. **Eliminar duplicación** — extraer lógica repetida a funciones reutilizables
2. **Simplificar condiciones** — aplanar ifs anidados, usar early returns
3. **Nombres claros** — renombrar variables y funciones ambiguas
4. **Funciones cortas** — funciones de más de 40 líneas candidatas a dividirse
5. **Eliminar código muerto** — variables no usadas, imports innecesarios, comentarios obsoletos

Proceso:
1. Leer el código actual y entender su comportamiento completo
2. Identificar los problemas específicos a corregir
3. Aplicar los cambios uno por uno
4. Verificar que los tests existentes sigan pasando (si hay)
5. Mostrar un resumen de qué se cambió y por qué

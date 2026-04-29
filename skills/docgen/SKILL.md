---
name: docgen
description: Genera documentación (JSDoc, docstrings, type hints) para funciones, clases o módulos sin documentar. Usar cuando se pide "documenta", "agrega JSDoc" o "genera docstrings".
argument-hint: [archivo o función]
---

Genera documentación para: $ARGUMENTS

1. **Detectar el formato correcto** según el lenguaje:
   - TypeScript/JavaScript → JSDoc (`/** */`)
   - Python → Google-style docstrings o NumPy según el estilo del proyecto
   - Verificar si ya hay ejemplos de documentación para seguir el mismo estilo

2. **Documentar únicamente lo no obvio**:
   - Funciones públicas y métodos de clase
   - Parámetros con tipos no obvios o con restricciones
   - Valores de retorno complejos
   - Efectos secundarios importantes
   - Casos de error / excepciones que puede lanzar

3. **No documentar**:
   - Lo que el nombre ya explica (`getUserById` → no necesita doc)
   - Getters/setters triviales
   - Código interno obvio

4. **Agregar type hints en Python** si faltan y el proyecto los usa.

Solo modificar lo indicado — no reformatear código ni cambiar lógica.



API REST del proyecto CWE, hecha en **Python** con **FastAPI** + **SQLAlchemy** y
base de datos **SQLite**. Expone endpoints para registrar/listar **usuarios** y
**productos**.

> El backend es un programa **independiente** de la app Flutter. Se ejecuta por su
> cuenta y la app lo consume por HTTP. Ambos pueden correr al mismo tiempo, cada
> uno en su propia terminal.

---

# Requisitos previos

- **Python 3.10 o superior** instalado. se Verifíca con:
  ```bash
  python --version


---

# Cómo correr el backend 

Se abre una terminal **dentro de la carpeta `backend_cwe`**.

# Crear un entorno virtual (una sola vez)
Un entorno virtual aísla las librerías de este proyecto del resto de tu PC.
```bash
python -m venv venv
```

### Se Activa el entorno virtual
- **Windows (PowerShell):**
  ```powershell
  venv\Scripts\activate
  ```
  > Si PowerShell bloquea el script, ejecuta una vez:
  > `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned` y vuelve a intentar.
- **Mac / Linux:**
  ```bash
  source venv/bin/activate
  ```
Cuando está activo, verás `(venv)` al inicio de la línea de la terminal.

# Instalar las dependencias (una sola vez, con el venv activo)
```bash
pip install -r requirements.txt
```

### 4. Arrancar el servidor
```bash
uvicorn main:app --reload
```
Se verá algo como `Uvicorn running on http://127.0.0.1:8000`.

> `--reload` hace que el servidor se reinicie solo cada vez que guardas un cambio
> en el código.

Para **detener** el servidor: `Ctrl + C` en esa terminal.

---

# Cómo probar que funciona

Con el servidor corriendo, abrir:

# Documentación interactiva 
 **http://127.0.0.1:8000/docs**

Es una interfaz automática (Swagger) donde puedes **probar todos los endpoints**
sin escribir código: desplegar cada uno, pulsar *"Try it out"*, llenar los datos
y *"Execute"*.

### Endpoints disponibles

| Método | Ruta | Qué hace |
|--------|------|----------|
| GET  | `/`                 | Mensaje de bienvenida |
| GET  | `/probar-conexion`  | Verifica la conexión a la base de datos |
| POST | `/usuarios/`        | Crea un usuario (productor o consumidor) |
| GET  | `/usuarios/`        | Lista los usuarios |
| POST | `/productos/`       | Crea un producto (requiere un `usuario_id` existente) |
| GET  | `/productos/`       | Lista los productos |

# crear un usuario (JSON del POST `/usuarios/`)
```json
{
  "nombre": "Campo Fresco",
  "email": "campo@cwe.com",
  "password": "1234",
  "tipo_usuario": "productor"
}
```

# crear un producto (JSON del POST `/productos/`)
```json
{
  "nombre": "Lulo",
  "descripcion": "Fruta fresca",
  "precio": 8900,
  "stock": 20,
  "unidad_medida": "kg",
  "usuario_id": 1
}
```

---

# Sobre la base de datos (SQLite)

- Al correr el servidor por primera vez se crea **solo** un archivo `cwe.db` en
  esta carpeta. Ahí viven todos los datos.
- Ese archivo **NO se subio a GitHub** (está en `.gitignore`), así cada integrante
  tiene su propia base de datos local.
- Si se quiere empezar de cero, borra `cwe.db` y vuelve a correr el servidor.

# Ver / consultar la base de datos manualmente
varias formas:

1. **DB Browser for SQLite** (recomendado, gráfico y gratis):
   descárgado de <https://sqlitebrowser.org>, abre el archivo `cwe.db` y podrás
   ver las tablas y ejecutar consultas SQL con el mouse.

2. **Extensión de VS Code**: se instala *"SQLite Viewer"* o *"SQLite"* desde el
   marketplace y abre `cwe.db` directamente en el editor.

3. **Por terminal** (si tienes el comando `sqlite3`):
   ```bash
   sqlite3 cwe.db
   ```
   y dentro escribes consultas, por ejemplo:
   ```sql
   .tables                     -- ver las tablas
   SELECT * FROM usuarios;     -- ver usuarios
   SELECT * FROM productos;    -- ver productos
   .quit                       -- salir
   ```

---

## Problemas bastante comunes

| Problema | Solución |
|---|---|
| `python no se reconoce` | Usa `python3`, o reinstala Python marcando *"Add to PATH"*. |
| `uvicorn no se reconoce` | Falta activar el venv o instalar dependencias (pasos 2 y 3). |
| PowerShell bloquea `activate` | Ejecuta `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned`. |
| Error con `str \| None` | Necesitas Python 3.10+. (Este proyecto ya usa `Optional` para evitarlo.) |

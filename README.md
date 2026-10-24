Conecta con la Tierra

App móvil que conecta a **productores agrícolas (campesinos)** con
**compradores de la ciudad**. Incluye catálogo de frutas y verduras,
login/registro, roles diferenciados (comprador 🔵 / vendedor 🟢) y un backend
propio.

Hecho con **Flutter/Dart** (app), **Python/FastAPI** (backend) y **PHP** (vitrina web).


Arranque rápido (si ya tienes Flutter y Python)

```bash
# Backend (Terminal 1)
cd backend_cwe
python -m venv venv && venv\Scripts\activate
pip install -r requirements.txt
uvicorn main:app --reload

# App (Terminal 2)
flutter pub get
flutter run -d chrome
```
# Ver Bases de datos(Terminal 3)
cd C:\Users\David\Desktop\CWE-P\backend_cwe
C:\sqlite\sqlite3.exe cwe.db

(.tables)

.headers on // Que se vea de una buena manera
.mode column
SELECT * FROM usuarios;

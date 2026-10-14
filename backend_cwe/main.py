import os
from fastapi import FastAPI, Depends, HTTPException, status
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import FileResponse
from sqlalchemy import text
from sqlalchemy.orm import Session
from database import engine, get_db
import models
import schemas

# Ruta del panel web (carpeta static)
STATIC_DIR = os.path.join(os.path.dirname(__file__), "static")

# Crea las tablas en la base de datos si no existen
models.Base.metadata.create_all(bind=engine)

app = FastAPI(title="CWE API - Conecta con la tierra", version="1.0")

# CORS: permite que la app Flutter (web/celular) consuma esta API desde otro
# origen (otro puerto o dispositivo). Para desarrollo se permite todo.
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
def read_root():
    return {"mensaje": "¡Bienvenido al backend de CWE - Conecta con la tierra!"}

@app.get("/panel", include_in_schema=False)
def panel():
    """Panel web sencillo para crear/consultar datos sin escribir código."""
    return FileResponse(os.path.join(STATIC_DIR, "index.html"))

@app.get("/probar-conexion")
def probar_conexion(db: Session = Depends(get_db)):
    try:
        # Consulta simple compatible con SQLite para verificar la conexión.
        resultado = db.execute(text("SELECT sqlite_version()")).fetchone()
        return {"estado": "Conexión exitosa", "sqlite_version": resultado[0]}
    except Exception as e:
        return {"estado": "Error de conexión", "detalle": str(e)}

# Endpoints de Usuarios 
@app.post("/usuarios/", response_model=schemas.UsuarioResponse, status_code=status.HTTP_201_CREATED)
def crear_usuario(usuario: schemas.UsuarioCreate, db: Session = Depends(get_db)):
    db_usuario = db.query(models.Usuario).filter(models.Usuario.email == usuario.email).first()
    if db_usuario:
        raise HTTPException(status_code=400, detail="El correo electrónico ya está registrado.")
    
    nuevo_usuario = models.Usuario(
        nombre=usuario.nombre,
        email=usuario.email,
        password=usuario.password, 
        tipo_usuario=usuario.tipo_usuario
    )
    db.add(nuevo_usuario)
    db.commit()
    db.refresh(nuevo_usuario)
    return nuevo_usuario

@app.get("/usuarios/", response_model=list[schemas.UsuarioResponse])
def listar_usuarios(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    usuarios = db.query(models.Usuario).order_by(models.Usuario.id).offset(skip).limit(limit).all()
    return usuarios


# Endpoint de Login 
@app.post("/login", response_model=schemas.LoginResponse)
def login(datos: schemas.LoginRequest, db: Session = Depends(get_db)):
    # Busca el usuario por correo
    usuario = db.query(models.Usuario).filter(models.Usuario.email == datos.email).first()
    # Si no existe o la contraseña no coincide, se rechaza el ingreso.
    if not usuario or usuario.password != datos.password:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Correo o contraseña incorrectos.",
        )
    return {"mensaje": "Inicio de sesión exitoso", "usuario": usuario}


# Endpoints de Productos 
@app.post("/productos/", response_model=schemas.ProductoResponse, status_code=status.HTTP_201_CREATED)
def crear_producto(producto: schemas.ProductoCreate, db: Session = Depends(get_db)):
    # Verificar que el usuario (productor) exista
    productor = db.query(models.Usuario).filter(models.Usuario.id == producto.usuario_id).first()
    if not productor:
        raise HTTPException(status_code=404, detail="El usuario productor especificado no existe.")
    
    nuevo_producto = models.Producto(
        nombre=producto.nombre,
        descripcion=producto.descripcion,
        precio=producto.precio,
        stock=producto.stock,
        unidad_medida=producto.unidad_medida,
        usuario_id=producto.usuario_id
    )
    db.add(nuevo_producto)
    db.commit()
    db.refresh(nuevo_producto)
    return nuevo_producto

@app.get("/productos/", response_model=list[schemas.ProductoResponse])
def listar_productos(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    productos = db.query(models.Producto).order_by(models.Producto.id).offset(skip).limit(limit).all()
    return productos
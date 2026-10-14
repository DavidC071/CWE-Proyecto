from pydantic import BaseModel, EmailStr
from datetime import datetime
from typing import Optional

# Esquemas de Usuario 
class UsuarioCreate(BaseModel):
    nombre: str
    email: EmailStr
    password: str
    tipo_usuario: str = "consumidor"

class UsuarioResponse(BaseModel):
    id: int
    nombre: str
    email: str
    tipo_usuario: str
    fecha_registro: datetime

    class Config:
        from_attributes = True


# Esquemas de Login
class LoginRequest(BaseModel):
    email: EmailStr
    password: str

class LoginResponse(BaseModel):
    mensaje: str
    usuario: UsuarioResponse


# Esquemas de Producto 
class ProductoCreate(BaseModel):
    nombre: str
    descripcion: Optional[str] = None
    precio: float
    stock: int
    unidad_medida: str
    usuario_id: int  # ID del productor que ofrece el producto

class ProductoResponse(BaseModel):
    id: int
    nombre: str
    descripcion: Optional[str] = None
    precio: float
    stock: int
    unidad_medida: str
    usuario_id: int
    fecha_creacion: datetime

    class Config:
        from_attributes = True
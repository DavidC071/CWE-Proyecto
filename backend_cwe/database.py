from sqlalchemy import create_engine
from sqlalchemy.orm import declarative_base, sessionmaker


# Base de datos: SQLite

# SQLite guarda TODA la base de datos en un solo archivo (cwe.db) dentro de esta
# carpeta entonces no hay que instalar ningún servidor y si borras el archivo, se empieza
# con una base de datos vacía.
#
# (Antes se usaba SQL Server amarrado al PC de un compañero entonces se cambió a SQLite
#  para que el proyecto corra igual en el computador de cualquier miembro del
#  equipo, sin necesidad de instalar servidores

SQLALCHEMY_DATABASE_URL = "sqlite:///./cwe.db"

# connect_args que (solo es necesario para SQLite) permite que FastAPI use la misma
# conexión desde distintos hilos
engine = create_engine(
    SQLALCHEMY_DATABASE_URL,
    connect_args={"check_same_thread": False},
)

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()


def get_db():
    """Entrega una sesión de base de datos y la cierra al terminar."""
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
import os

# Database configuration
DATABASE_URL = os.getenv(
    "DATABASE_URL",
    os.getenv("DATABASE_URL", "postgresql://postgres:password@localhost:5432/postgres"),
)

# Engine configuration
# Azure PostgreSQL requires SSL, so we configure it to be flexible
engine_kwargs = {
    "pool_pre_ping": True,  # Verify connections before using them
    "pool_size": 5,  # Connection pool size
    "max_overflow": 10,  # Max connections beyond pool_size
}

# Add SSL configuration for Azure if connection string requires it
if "azure" in DATABASE_URL or "sslmode=require" in DATABASE_URL:
    engine_kwargs["connect_args"] = {"sslmode": "require"}

engine = create_engine(DATABASE_URL, **engine_kwargs)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()


def get_db():
    """
    Database session dependency for FastAPI.
    Yields a database session and ensures proper cleanup.
    """
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

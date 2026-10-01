# Production App

A full-stack learning project built with:

- Python FastAPI backend
- React + Vite frontend
- Git/GitHub
- AWS deployment and CI/CD later

## Project Structure

```text
production-app/
├── backend/
│   ├── app/
│   │   ├── api/
│   │   ├── core/
│   │   └── main.py
│   └── requirements.txt
├── frontend/
│   ├── src/
│   ├── package.json
│   └── .env.example
├── .env.example
├── .gitignore
└── README.md
```

## Backend Setup

From the project root:

```bash
cd backend
```

Create a virtual environment:

```bash
python -m venv .venv
```

Activate it on Windows PowerShell:

```powershell
.venv\Scripts\Activate.ps1
```

Install dependencies:

```bash
pip install -r requirements.txt
```

Create the root `.env` file based on `.env.example`.

Start the backend:

```bash
uvicorn app.main:app --reload
```

Backend API:

```text
http://127.0.0.1:8000/api/v1/
```

Health endpoint:

```text
http://127.0.0.1:8000/api/v1/health
```

Swagger documentation:

```text
http://127.0.0.1:8000/docs
```

## Frontend Setup

Open another terminal:

```bash
cd frontend
```

Install dependencies:

```bash
npm install
```

Create `frontend/.env` based on `frontend/.env.example`.

Start the frontend:

```bash
npm run dev
```

Frontend:

```text
http://localhost:5173
```

## Local Request Flow

```text
Browser
  ↓
React frontend
  ↓
VITE_API_BASE_URL
  ↓
FastAPI /api/v1/
  ↓
JSON response
  ↓
React UI
```

## Current Status

The application currently supports:

- React frontend
- FastAPI backend
- Versioned API under `/api/v1`
- Health endpoint
- CORS configuration
- Environment-based frontend/backend configuration

Future work will add testing, Docker, AWS infrastructure, CI/CD, databases, authentication, monitoring, logging, and production hardening.
#!/bin/bash

# Nombre del proyecto
read -p "Ingrese el nombre del proyecto: " project_name

# Crear la carpeta principal del proyecto
mkdir "$project_name"
cd "$project_name"

# Crear backend con Django y DRF
echo "Creando backend..."
python3 -m venv backend_env
source backend_env/bin/activate
pip install django djangorestframework django-cors-headers
django-admin startproject backend
cd backend
python manage.py startapp api

# Configurar settings.py
sed -i "s/INSTALLED_APPS = \[/INSTALLED_APPS = [\n    'rest_framework',\n    'corsheaders',\n    'api',/" backend/settings.py
sed -i "s/MIDDLEWARE = \[/MIDDLEWARE = [\n    'corsheaders.middleware.CorsMiddleware',/" backend/settings.py
echo "CORS_ALLOW_ALL_ORIGINS = True" >> backend/settings.py

# Volver al directorio principal
cd ..

# Crear frontend con Vite, React, Tailwind y React Icons
echo "Creando frontend..."
npm create vite@latest frontend -- --template react
cd frontend
npm install
npm install -D tailwindcss postcss autoprefixer react-icons
npx tailwindcss init -p

# Configurar Tailwind
echo "
@import 'tailwindcss/base';
@import 'tailwindcss/components';
@import 'tailwindcss/utilities';
" > src/index.css

# Modificar App.jsx para incluir un ejemplo de React Icons y Tailwind
echo "
import React from 'react'
import { FaReact } from 'react-icons/fa'

function App() {
  return (
    <div className='flex justify-center items-center h-screen bg-gray-100'>
      <div className='text-center'>
        <FaReact className='text-6xl text-blue-500 mx-auto' />
        <h1 className='text-2xl font-bold mt-4'>React + Vite + Tailwind + React Icons</h1>
      </div>
    </div>
  )
}

export default App
" > src/App.jsx

# Configurar tailwind.config.js
echo "
/** @type {import('tailwindcss').Config} */
export default {
  content: [
    './index.html',
    './src/**/*.{js,ts,jsx,tsx}',
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
" > tailwind.config.js

# Volver al directorio principal
cd ..

echo "Proyecto $project_name creado con éxito!"
echo "Para iniciar el backend:"
echo "  cd $project_name/backend"
echo "  source ../backend_env/bin/activate"
echo "  python manage.py runserver"
echo ""
echo "Para iniciar el frontend:"
echo "  cd $project_name/frontend"
echo "  npm run dev"

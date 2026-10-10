/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  darkMode: 'class',
  theme: {
    extend: {
      colors: {
        medical: {
          50: '#eff6ff',
          100: '#dbeafe',
          200: '#bfdbfe',
          300: '#93c5fd',
          400: '#60a5fa',
          500: '#0066F6',
          600: '#0052cc',
          700: '#0043a8',
          800: '#003685',
          900: '#002660',
        },
        tealAccent: '#00BFA5',
      },
    },
  },
  plugins: [],
}

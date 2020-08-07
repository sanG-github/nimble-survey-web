const defaultTheme = require('tailwindcss/defaultTheme');

module.exports = {
  purge: [],
  theme: {
    extend: {
      borderRadius: {
        normal: '10px',
        lg: '12px'
      },
      colors: {
        black: {
          default: 'var(--color-black)'
        },
        white: {
          default: 'var(--color-white)',
          180: 'var(--color-white-180)',
          200: 'var(--color-white-200)',
          300: 'var(--color-white-300)',
          500: 'var(--color-white-500)',
          600: 'var(--color-white-600)'
        },
        red: {
          500: 'var(--color-red-500)'
        }
      },
      fontFamily: {
        sans: ['Neuzeit S LT Std', ...defaultTheme.fontFamily.sans],
        mono: ['Neuzeit S LT Std', ...defaultTheme.fontFamily.mono]
      },
      fontSize: {
        xs: ['13px', '18px'],
        sm: ['15px', '20px'],
        base: ['17px', '22px']
      },
      height: {
        14: '56px'
      },
      letterSpacing: {
        normal: '-0.41px',
        wide: '-0.24px',
        wider: '-0.08px'
      },
      margin: {
        11: '44px'
      }
    }
  },
  variants: {},
  plugins: []
};

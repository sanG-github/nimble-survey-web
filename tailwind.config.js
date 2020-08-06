const defaultTheme = require('tailwindcss/defaultTheme');

module.exports = {
  purge: [],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Neuzeit S LT Std', ...defaultTheme.fontFamily.sans],
        mono: ['Neuzeit S LT Std', ...defaultTheme.fontFamily.mono]
      },
      fontSize: {
        xs: ['13px', '18px'],
        sm: ['15px', '20px'],
        base: ['17px', '22px']
      },
      letterSpacing: {
        normal: '-0.41px',
        wide: '-0.24px',
        wider: '-0.08px'
      },
      height: {
        14: '56px'
      },
      colors: {
        white: {
          default: 'var(--color-white)',
          180: 'var(--color-white-180)',
          200: 'var(--color-white-200)',
          300: 'var(--color-white-300)',
          500: 'var(--color-white-500)',
          600: 'var(--color-white-600)'
        }
      },
      textColors: {
        white: {
          default: 'var(--color-white)',
          180: 'var(--color-white-180)',
          200: 'var(--color-white-200)',
          300: 'var(--color-white-300)',
          500: 'var(--color-white-500)',
          600: 'var(--color-white-600)'
        }
      },
      borderRadius: {
        lg: '10px'
      }
    }
  },
  variants: {},
  plugins: []
};

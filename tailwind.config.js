const defaultTheme = require('tailwindcss/defaultTheme');

module.exports = {
  purge: [],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Neuzeit S LT Std', ...defaultTheme.fontFamily.sans],
        mono: ['Neuzeit S LT Std', ...defaultTheme.fontFamily.mono]
      },
      colors: {
        white: {
          lightest: 'var(--color-white-lightest)',
          lighter: 'var(--color-white-lighter)',
          light: 'var(--color-white-light)',
          default: 'var(--color-white)'
        }
      },
      textColors: {
        white: {
          lightest: 'var(--color-white-lightest)',
          lighter: 'var(--color-white-lighter)',
          light: 'var(--color-white-light)',
          default: 'var(--color-white)'
        }
      },
      letterSpacing: {
        normal: '-0.41px',
        wide: '-0.24px',
        wider: '-0.08px'
      }
    }
  },
  variants: {},
  plugins: []
};

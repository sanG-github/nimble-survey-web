const path = require('path');

require('esbuild')
  .context({
    entryPoints: ['application.js'],
    inject: ['global.js'],
    bundle: true,
    sourcemap: true,
    outdir: path.join(process.cwd(), 'app/assets/builds'),
    absWorkingDir: path.join(process.cwd(), 'app/javascript'),
    publicPath: 'assets'
  }).then(context => {
    console.log('Building...');
    console.log('HEHE:', process.argv);
    if (process.argv.includes('--watch')) {
    // Enable watch mode
      console.log('Watching...');
      context.watch();
    } else {
    // Build once and exit if not in watch mode
      console.log('Building once...');
      context.rebuild().then(result => {
        context.dispose();
      });
    }
  });

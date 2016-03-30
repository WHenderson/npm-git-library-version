var coffeeCoverage = require('coffee-coverage');
var path = require('path');
coffeeCoverage.register({
    instrumentor: 'istanbul',
    basePath: path.resolve(path.join(__dirname, '../src')),
    _exclude: [],
    coverageVar: coffeeCoverage.findIstanbulVariable(),
    writeOnExit: false,
    initAll: false
});

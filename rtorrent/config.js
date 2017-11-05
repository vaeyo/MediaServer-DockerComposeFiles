const CONFIG = {
  baseURI: '/',
  dbCleanInterval: 1000 * 60 * 60,
  dbPath: '/config/flood/db/',
  floodServerHost: '0.0.0.0',
  floodServerPort: 3000,
  maxHistoryStates: 30,
  pollInterval: 1000 * 5,
  secret: 'flood',
  scgi: {
    host: 'localhost',
    port: 5000,
    socket: true,
    socketPath: '/run/php/.rtorrent.sock'
  },
  ssl: false,
  sslKey: '/absolute/path/tsuo/key/',
  sslCert: '/absolute/path/to/certificate/'
};

module.exports = CONFIG;

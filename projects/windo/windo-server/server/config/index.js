var fs = require('fs');
var path = require('path');
var smtpConfig = JSON.parse(fs.readFileSync(path.join(__dirname, 'smtp.secret'), 'utf8'));
var sessionSecret = fs.readFileSync(path.join(__dirname, 'session.secret'), 'utf8');

module.exports = {
  sessionSecret: sessionSecret,
  smtpConfig: smtpConfig
};

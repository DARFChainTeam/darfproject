require('babel-register');
require('babel-polyfill');
module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
  networks: {
     ganache: {
       host: 'localhost',
       port: 7545,
       network_id: '*' ,// Match any network id
     } /* ,

      development: {
       host: 'localhost',
       port: 8545,
       network_id: 'dev' ,// Match any network id
     }
     */
   }
};

require('dotenv').config()
const ISOLATION_LEVEL = require('tedious').ISOLATION_LEVEL

module.exports = {
  username: process.env.MSSQL_TEST_USER,
  password: process.env.MSSQL_TEST_PASSWORD,
  database: process.env.MSSQL_TEST_DATABASE,
  host: process.env.MSSQL_TEST_HOST,
  //  timezone: '-03:00',
  dialect: 'mssql',
  dialectOptions: {
    encrypt: true,
    isolationLevel: ISOLATION_LEVEL.READ_UNCOMMITTED,
  },
  operatorsAliases: false,
  pool: {
    max: 25,
    min: 0,
    acquire: 30000,
    idle: 10000,
  },
  logging: false,
}

require('dotenv').config()
const ISOLATION_LEVEL = require('tedious').ISOLATION_LEVEL

module.exports = {
  username: process.env.MSSQL_USER,
  password: process.env.MSSQL_PASSWORD,
  database: process.env.MSSQL_DATABASE,
  host: process.env.MSSQL_HOST,
  //  timezone: '-03:00',
  dialect: 'mssql',
  dialectOptions: {
    // instanceName: process.env.MSSQL_INSTANCE,
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
  logging: true,
}

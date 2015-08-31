#==============================
# phpsessions Perstent Sessions
#==============================

# Setup new database and user
# ===========================

-- Create the Database --
CREATE DATABASE IF NOT EXISTS persistent COLLATE utf8_general_ci;

-- Create a specific Database User
CREATE USER 'sess_admin'@'localhost' IDENTIFIED BY 'secret';

-- Set Priviliges for that User on DB - Only those that are absolutely required. --
-- E.g. Nothing Global, only privilages on a speccific database and then only those that are necessary --
GRANT SELECT, INSERT, UPDATE, DELETE ON persistent.* TO 'sess_admin'@'localhost';

# Create required Tables
# ======================

-- Table structure for table 'users'
CREATE TABLE IF NOT EXISTS 'users' (
  -- Note: Not using AUTO_INCREMENT; The key will be a randomly generated string
  'user_key' char(8) NOT NULL PRIMARY KEY,
  'username' varchar(30) NOT NULL UNIQUE,
  'pwd' varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table structure for table 'sessions'
CREATE TABLE IF NOT EXISTS 'sessions' (
  'sid' varchar(40) NOT NULL PRIMARY KEY,
  'expiry' int(10) unsigned NOT NULL,
  'date' text NOT NULL,
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Table structure for table 'autologin'
CREATE TABLE IF NOT EXISTS 'autologin' (
  'user_key' char(8) NOT NULL,
  'token' char(32) NOT NULL,
  'created' timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  'data' text,
  'used' tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY ('user_key', 'token')
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Change the value of ENGINE to MyISAM if your server doesn't support InnoDB --

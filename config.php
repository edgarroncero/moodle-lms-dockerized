<?php  // Moodle configuration file

unset($CFG);
global $CFG;
$CFG = new stdClass();

$CFG->dbtype    = getenv('MOODLE_DB_TYPE');
$CFG->dblibrary = 'native';
$CFG->dbhost    = getenv('MOODLE_DB_HOST');
$CFG->dbname    = getenv('MOODLE_DB_NAME');
$CFG->dbuser    = getenv('MOODLE_DB_USER');
$CFG->dbpass    = getenv('MOODLE_DB_PASS');
$CFG->prefix    = getenv('MOODLE_DB_PREFIX');

$CFG->wwwroot   = getenv('MOODLE_URL');
$CFG->dataroot  = getenv('MOODLE_DATAROOT');

$CFG->directorypermissions = octdec(getenv('MOODLE_DIRECTORYPERMISSIONS'));

require_once(__DIR__ . '/lib/setup.php');

$CFG->preventexecpath = true;
$CFG->pathtophp = '/usr/local/bin/php';
$CFG->pathtodu = '/usr/bin/du';
$CFG->aspellpath = '/usr/bin/aspell';
$CFG->pathtodot = '/usr/bin/dot';
$CFG->pathtogs = '/usr/bin/gs';
$CFG->pathtopdftoppm = '/usr/bin/pdftoppm';
$CFG->pathtopython = '/usr/bin/python3';

// There is no php closing tag in this file,
// // it is intentional because it prevents trailing whitespace problems!

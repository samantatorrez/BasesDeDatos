<?php

namespace reservasGonzalezTorrez;

/**
 * Represent the Connection
 */
class Connection {

    /**
     * Connection
     * @var type
     */
    protected static $conn;

    /**
     * Connect to the database and return an instance of \PDO object
     * @return \PDO
     * @throws \Exception
     */
    public function connect() {
        // connect to the postgresql database
        $conStr = sprintf("pgsql:host=%s;port=%d;dbname=%s;user=%s;password=%s",
                $_SESSION['host'],
                $_SESSION['port'],
                $_SESSION['database'],
                $_SESSION['user'],
                $_SESSION['password']);

        $pdo = new \PDO($conStr);
        $pdo->setAttribute(\PDO::ATTR_ERRMODE, \PDO::ERRMODE_EXCEPTION);

        return $pdo;
    }

    /**
     * return an instance of the Connection object
     * @return type
     */
    public static function get() {
        if (null === static::$conn) {
            static::$conn = new static();
        }

        return static::$conn;
    }

    protected function __construct() {
    }

    private function __clone() {

    }

    private function __wakeup() {

    }

}

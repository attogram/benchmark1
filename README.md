# Benchmark 1 - PHP vs C

PHP functions:

* password_hash($foo, PASSWORD_ARGON2I, ['memory_cost' => 32768, "time_cost" => 2, "threads" => 1])
* hash('sha256', $foo)
* substr($foo, 0, 8)
* gmp_init($integer)
* gmp_mul($a, $b)
* gmp_add($a, $b)
* gmp_div($a, $b) - alias to gmp_div_q()
* hexdec()
* time()
* time() - Date Math: add
* time() - Date Math: subtract
* microtime(true)

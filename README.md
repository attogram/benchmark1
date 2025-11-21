# Benchmark 1 - PHP vs C

PHP functions:

* [password_hash](https://www.php.net/manual/en/function.password-hash.php)($foo, PASSWORD_ARGON2I, ['memory_cost' => 32768, "time_cost" => 2, "threads" => 1])
* [hash](https://www.php.net/manual/en/function.hash.php)('sha256', $foo)
* [substr](https://www.php.net/manual/en/function.substr.php)($foo, 0, 8)
* [gmp_init](https://www.php.net/manual/en/function.gmp-init.php)($integer)
* [gmp_mul](https://www.php.net/manual/en/function.gmp-mul.php)($a, $b)
* [gmp_add](https://www.php.net/manual/en/function.gmp-add.php)($a, $b)
* [gmp_div](https://www.php.net/manual/en/function.gmp-div.php)($a, $b) - alias to gmp_div_q()
* [hexdec](https://www.php.net/manual/en/function.hexdec.php)
* [time](https://www.php.net/manual/en/function.time.php)
  * time() - Date Math: add
  * time() - Date Math: subtract
* [microtime](https://www.php.net/manual/en/function.microtime.php)(true)

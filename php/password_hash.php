<?php
if ($argc != 3) {
    echo "Usage: php " . $argv[0] . " <password> <iterations>\n";
    exit(1);
}

$password = $argv[1];
$iterations = (int)$argv[2];

$options = [
    'memory_cost' => 32768,
    'time_cost'   => 2,
    'threads'     => 1,
];

$start = microtime(true);

for ($i = 0; $i < $iterations; $i++) {
    password_hash($password, PASSWORD_ARGON2I, $options);
}

$end = microtime(true);
echo sprintf('%.12f', $end - $start) . "\n";

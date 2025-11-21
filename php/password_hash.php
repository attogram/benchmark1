<?php
if ($argc != 3) {
    echo "Usage: php " . $argv[0] . " <password> <iterations>\n";
    exit(1);
}

$password = $argv[1];
$iterations = (int)$argv[2];

$options = [
    'memory_cost' => 32768,
    'time_cost'   => 3,
    'threads'     => 1,
];

$total_length = 0;

$start = microtime(true);

for ($i = 0; $i < $iterations; $i++) {
    $hash = password_hash($password, PASSWORD_ARGON2I, $options);
    $total_length += strlen($hash);
}

$end = microtime(true);
echo sprintf('%.12f', $end - $start) . "\n";

// Use the result to prevent dead code elimination
if ($total_length < 0) {
    echo "Impossible length\n";
}

<?php
if ($argc != 3) {
    echo "Usage: php " . $argv[0] . " <number> <iterations>\n";
    exit(1);
}

$number_str = $argv[1];
$iterations = (int)$argv[2];

$start = microtime(true);

for ($i = 0; $i < $iterations; $i++) {
    $num = gmp_init($number_str);
}

$end = microtime(true);
echo sprintf('%.12f', $end - $start) . "\n";

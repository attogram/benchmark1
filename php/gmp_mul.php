<?php
if ($argc != 4) {
    echo "Usage: php " . $argv[0] . " <num_a> <num_b> <iterations>\n";
    exit(1);
}

$a_str = $argv[1];
$b_str = $argv[2];
$iterations = (int)$argv[3];

$a = gmp_init($a_str);
$b = gmp_init($b_str);

$start = microtime(true);

for ($i = 0; $i < $iterations; $i++) {
    $res = gmp_mul($a, $b);
}

$end = microtime(true);
echo sprintf('%.12f', $end - $start) . "\n";

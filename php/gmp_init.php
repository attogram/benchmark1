<?php
if ($argc != 3) {
    echo "Usage: php " . $argv[0] . " <number> <iterations>\n";
    exit(1);
}

$number_str = $argv[1];
$iterations = (int)$argv[2];
$sum = gmp_init(0);

$start = microtime(true);

for ($i = 0; $i < $iterations; $i++) {
    $num = gmp_init($number_str);
    $sum = gmp_add($sum, $num);
}

$end = microtime(true);
echo sprintf('%.12f', $end - $start) . "\n";

// Use the result to prevent dead code elimination
if (gmp_cmp($sum, 0) < 0) {
    echo "Impossible sum\n";
}
